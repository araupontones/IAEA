cli::cli_alert_success("Cleaning RO societies")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/iaea_rt.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "soc_types"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(param$dir_clean_s, "societies.rds")


param$file_clean
param$file_raw


#import main ------------------------------------------------------------------

raw_main <- import(file.path(param$dir_clean_s, "iaea_rt.rds")) %>% select(interview__key, country)
raw_soc <- import(param$file_raw)


#label variables ---------------------------------------------------------------
soc <- raw_main %>%
  left_join(raw_soc, by = "interview__key") %>%
  select(-starts_with("inter")) %>%
  rename(type = soc_types__id,
         value = soc_num) %>%
  mutate(type = susor_get_stata_labels(type))



#View(clean_main)  

#filter(interview__status != "InterviewAssigned")


#export ---------------------------------------------------------------------

export(soc, exfile)


