cli::cli_alert_success("Cleaning patients")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/patients.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "pat"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(param$dir_clean_s, "patients.rds")


param$file_clean
param$file_raw


#import main ------------------------------------------------------------------

raw_main <- import(file.path(param$dir_clean_s, "iaea_rt.rds")) %>% select(interview__key, country)

raw_pat <- import(param$file_raw) %>% select(-c(interview__id)) %>%
rename(year = pat__id)
# 
# raw_time00 <- import(file.path(param$dir_raw_s, "wait_2000prop.dta")) %>% select(-c(interview__id)) %>%
#   rename(prop = wait_2000prop__id) %>%
#   mutate(prop = as.character(susor_get_stata_labels(prop)))


#View(raw_time00)


#clean patients -------------------------------------------------------------------------
pat <- raw_pat %>%
  mutate(year = susor_get_stata_labels(year)) %>%
  left_join(raw_main, by = "interview__key") %>%
  select(country, year, pat_num)



#import waiting ================================================================
# 
# w0_raw <- import(file.path(param$dir_raw_s, "wait_2000prop.dta")) %>%
#   rename(prop = wait_2000prop__id,
#          value = prop_2000) %>%
#   mutate(prop = as.character(susor_get_stata_labels(prop)),
#          year = "2000"
#          ) %>%
#   select(-interview__id)

 

#View(spec)
exfile

#export ---------------------------------------------------------------------

export(pat, exfile)


