cli::cli_alert_success("Cleaning waiting")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/waiting.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "pat"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(param$dir_clean_s, "waiting.rds")


param$file_clean
param$file_raw


#import main ------------------------------------------------------------------

raw_main <- import(file.path(param$dir_clean_s, "iaea_rt.rds")) %>% select(interview__key, country)


#import waiting ================================================================

w0_raw <- import(file.path(param$dir_raw_s, "wait_2000prop.dta")) %>%
  rename(indicator = wait_2000prop__id,
         value = prop_2000) %>%
  mutate(indicator = as.character(susor_get_stata_labels(indicator)),
         year = "2000"
         ) %>%
  select(-interview__id)


View(w0_raw)

w20_raw <- import(file.path(param$dir_raw_s, "wait_2020prop.dta")) %>%
  rename(indicator = wait_2020prop__id,
         value = prop_2020) %>%
  mutate(indicator = as.character(susor_get_stata_labels(indicator)),
         year = "2020"
  ) %>%
  select(-interview__id)

waiting <- rbind(w0_raw, w20_raw) %>%
  left_join(raw_main, by = "interview__key") %>%
  select(country,
         year,
         indicator, 
         value)
 

#View(spec)
exfile

#export ---------------------------------------------------------------------

export(waiting, exfile)


