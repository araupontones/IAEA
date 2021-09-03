cli::cli_alert_success("indicators certified personnel")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "1.criterion/indicators_certified_personel.rds")}'))


#create indicators for certification ------------------------------------------
survey <- "iaea_ndt"
module <- "iaea_ndt"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "certified_personel.rds") #created in clean
exfile <- file.path(dir_indicators_NDT, "1.criterion/indicators_certified_personel.rds")



#read data======================================================================
main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds")) %>% select(country) #created in clean
pers <- import(infile)



#create reference vectors ======================================================
methods <- pers %>% group_by(method) %>% slice(1) %>% select(method, accronym, type) %>% ungroup()%>% mutate_all(as.character)

methods_main <- methods$accronym[methods$type == "Main"]
methods_adv <- methods$accronym[methods$type == "Advanced"]

#methods_adv

#clean data ====================================================================

pers_c <- pers %>%
  select(country, accronym) %>%
  mutate(cert = T) %>%
  pivot_wider(id_cols = "country",
              names_from = "accronym",
              values_from = "cert") %>%
  mutate(
    across(all_of(c(methods_main, methods_adv)),function(x)case_when(is.na(x)~ FALSE,
                                                                     T ~ x))
  ) %>%
  rowwise()%>%
  mutate(adequate = any(c(VT , ET , PT , MT , UT, RT)),
         good = all(c(VT , ET , PT , MT , UT, RT), na.rm = T),
         excellent = all(c(good , PEC,  TOFD, PAUT, `RT-D`), na.rm = T),
         total =  sum(c_across(all_of(c(methods_main, methods_adv))), na.rm = T)
         
  ) %>%
  ungroup() 



#join with countries that do not have certification ===========================
standards <- main %>%
  left_join(pers_c, by = "country") %>%
  mutate(
    
    total = case_when(is.na(total)~0,
                      T ~ as.numeric(total)),
    inadequate = is.na(excellent),
    across(all_of(c(methods_main, methods_adv, "excellent", "good", "adequate")), function(x)case_when(is.na(x)~ FALSE,
                                                                                                       T ~ x))) %>%
  mutate(
    
    #standard ---------------------------------------------------------
    criterion= factor(case_when(
      excellent ~ "Excellent",
      good ~ "Good",
      adequate ~ "Adequate",
      T ~ "Inadequate"
    ),
    levels = rev(c("Inadequate", "Adequate", "Good", "Excellent")),
    ordered = T),
    #To fix the sorting by total
    total = case_when(criterion ==  "Excellent" ~  total + 4,
                      criterion==  "Good" ~  total + 3,
                      criterion==  "Adequate" ~  total + 2,
                      criterion==  "Inadequate" ~  total + 0,
                      T ~  0)
    
  ) %>%
  select(-c(excellent, good, adequate, inadequate)) %>%
  mutate(country = fct_reorder(country, total)) %>%
  arrange(criterion) %>%
  rename(cert_pers_total = total,
         cert_pers_standard = criterion)


#export =======================================================================
export(standards, exfile)
