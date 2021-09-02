cli::cli_alert_success("Cleaning Main questionnaire")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_ndt/iaea_ndt.rds")

#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "iaea_ndt"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)






#import main ------------------------------------------------------------------

raw_main <- import(param$file_raw)


#label variables ---------------------------------------------------------------

labelvars <- c("country", "interview__status", "currency",
               #certification
               "cert_schm", 
               "cert_society","cert_society_APPFNDT" , "cert_society_ICNDT", "cert_society_APPFNDT",
               "cert_ncb", "cert_ncb_ICNDT", "cert_ncb_iso17024", "cert_body_lkrt", "cert_society_lkrt",
               #inspection companies
               "inspec_local_abroad","inspec_profit", "impact_inspection", "impact_inspinvest",
               
               #training centres
               "traincen_local_abroad", "traincen_local_lkrt",
               
               #impact
               "impact_inspection", "impact_inspinvest"
               )



label_main <- raw_main %>%
  mutate(across(all_of(labelvars), susor::susor_get_stata_labels)) %>%
  mutate(across(all_of(labelvars), as.character))


names(label_main)
label_main %>%
  tabyl(cert_ncb_ICNDT)


#clean file -------------------------------------------------------------------
clean_main <- label_main 
#View(clean_main)  

#filter(interview__status != "InterviewAssigned")



#export ---------------------------------------------------------------------

export(clean_main, param$file_clean)

param$file_clean
