cli::cli_alert_success("Cleaning RO specialists")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/specialists.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(param$dir_clean_s, "specialists.rds")


param$file_clean
param$file_raw


#import main ------------------------------------------------------------------

raw_main <- import(file.path(param$dir_clean_s, "iaea_rt.rds")) %>% select(interview__key, country)
raw_spec <- import(param$file_raw) %>% select(-c(interview__id)) %>%
  rename(method = spec2000__id)


raw_spec20 <- import(file.path(param$dir_raw_s, "spec2020.dta")) %>% select(-c(interview__id)) %>%
  rename(method = spec2020__id)

#View(spec)

#label variables ---------------------------------------------------------------

spec <- raw_spec %>%
  left_join(raw_spec20, by= c("interview__key", "method")) %>%
  mutate(method = as.character(susor_get_stata_labels(method)),
         method = case_when(str_detect(method, "Technology") ~ "Radiation Therapists",
                            str_detect(method, "Oncology") ~ "RO Nurses",
                            T ~ method),
         
         method = fct_reorder(method, tot_2020),
         
         perc_2000 = cert_2000/tot_2000,
         perc_2020 = cert_2020/tot_2020,
         un_2000 = tot_2000 - cert_2000,
         un_2020 = tot_2020 - cert_2020 ,
         not_2020 = case_when(!is.na(tot_2020) & is.na(cert_2020) ~ tot_2020,
                         T ~ NA_real_
                         ) 
         ) %>%
  left_join(raw_main, by = "interview__key") %>%
  select(-interview__key) %>%
  pivot_longer(-c(country, method),
               names_to = "indicator") %>%
  mutate(year = str_sub(indicator, -4,-1 ),
         indicator = case_when(str_detect(indicator, "tot") ~ "Total",
                               str_detect(indicator, "cert") ~ "Certified",
                               str_detect(indicator, "un") ~ "Uncertified",
                               str_detect(indicator, "perc") ~ "% Certified",
                               str_detect(indicator, "not") ~ "Unknown",
                               T ~ NA_character_))



#View(clean_main)  

#View(spec)


#export ---------------------------------------------------------------------

export(spec, exfile)


