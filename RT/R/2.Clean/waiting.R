cli::cli_alert_success("Cleaning control")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/control.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "control"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(param$dir_clean_s, "control.rds")


param$file_clean
param$file_raw


#import main ------------------------------------------------------------------

raw_main <- import(file.path(param$dir_clean_s, "iaea_rt.rds")) %>% select(interview__key, country)


#import control ================================================================
View(c0_raw)
c_raw <- import(file.path(param$dir_raw_s, "control.dta")) %>%
  select(interview__key, 
         year = control__id,
         cont_num) %>%
  mutate(year = as.character(susor_get_stata_labels(year)))



#import life   ================================================================


l_raw <- import(file.path(param$dir_raw_s, "survival.dta")) %>%
  select(interview__key, 
         year = survival__id,
         surv_num) %>%
  mutate(year = as.character(susor_get_stata_labels(year)))



#join =========================================================================

h <- c_raw %>%
  left_join(l_raw, by = c("interview__key", "year")) %>%
  left_join(raw_main, by =c("interview__key")) %>%
  select(country, year, ends_with("num"))




#View(spec)
exfile

#export ---------------------------------------------------------------------

export(h, exfile)


