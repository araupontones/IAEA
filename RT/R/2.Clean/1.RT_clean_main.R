cli::cli_alert_success("Cleaning Main questionnaire")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/iaea_rt.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "iaea_rt"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)




param$file_clean

#import main ------------------------------------------------------------------

raw_main <- import(param$file_raw)
names(raw_main)

#label variables ---------------------------------------------------------------

labelvars <- c("country", "interview__status", "currency",
               
               #contribution programmes
               "train_cont", "dep_cont", "soc_cont",
               
               #contributiob specialists
               "spec_cont",
               
               #waiting
               "wait_cont",
               
               #control
               "surv_cont", "cont_cont"
               )


non_ap <- c("train_num", "dep_num")




label_main <- raw_main %>%
  mutate(across(all_of(labelvars), susor::susor_get_stata_labels)) %>%
  mutate(across(all_of(labelvars), as.character)) %>%
  mutate(across(all_of(non_ap), function(x)case_when(x == -97 ~ NA_real_,
                                                     T ~ x)))
  #mutate(across(matches("impact_"), susor::susor_get_stata_labels))

#head(label_main$benefits)

#names(label_main)
label_main %>%
  tabyl(train_cont)


#clean file -------------------------------------------------------------------
clean_main <- label_main 
#View(clean_main)  

#filter(interview__status != "InterviewAssigned")


#export ---------------------------------------------------------------------

export(clean_main, param$file_clean)


