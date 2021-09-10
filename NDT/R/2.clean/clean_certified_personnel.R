cli::cli_alert_success("Cleaning certifield personel")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_ndt/certified_personel.rds")

survey <- "iaea_ndt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

exfile <- file.path(param$dir_clean_s, "certified_personel.rds")




#--Read data ===============================================================

#main qn
main_qn <- import(file.path(param$dir_clean_s, paste0(survey,".rds"))) %>%
  select(interview__key, country)


#methods reference
methods<- import(file.path(dir_reference, "methods_NDT.xlsx")) %>%
  select(id = ID_method,
         method = methods,
         accronym = Accronym,
         type = Type) %>%
  mutate(across(c(method, accronym), function(x){fct_reorder(x, -id)}))
  





#clean roster of certified by methods=========================================
certi_raw <- import(file.path(param$dir_raw_s, "cert_advanced.dta")) %>%
  rename(id = cert_advanced__id) %>%
  left_join(main_qn, by = "interview__key") %>%
  left_join(methods, by = "id") %>%
  mutate(across(c(cert_per, cert_fem), NA_to_cero),
         cert_fem = cert_fem/100,
         cert_women = cert_per * cert_fem,
         cert_total_20 = cert_per * 20,
         cert_total_20_women = cert_women * 20
         ) %>% 
  select(-starts_with("interview")) 
  #filter(cert_per == 0)

#View(certi_raw)




certi_raw %>%
  tabyl(country)

#export ========================================================================


exportar <- function(pais){
  
  d <- certi_raw %>%
    filter(country == pais) %>%
    select(`How many personnel was certified by local NDT Accredited Training Centres as a result of participating in the RCA NDT programme, per year, for the period of 2000 to 2020?` = cert_per,
            `% of female certified personnel` = cert_fem, 
           method, 
           accronym)
  
  print(names(d))
  excheck_sk<- glue("C:/Users/andre/Dropbox/Kate and Julian IAEA 2019/Survey_NDT_RT/docs/NDT_checks/{pais}_trained_personel.xlsx")
  export(d, excheck_sk, overwrite = T)
  
}


#exportar("Vietnam")




export(certi_raw, exfile)

#from main: country cert_method



