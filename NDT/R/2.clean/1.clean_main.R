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
names(raw_main)

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
               "impact_inspection", "impact_inspinvest",
               "impact_speed", "impact_speeddet", "impact_adopt", "impact_adoptdet","impact_product", 'impact_productdet', 
               "impact_assessment",
               
               #awareness
               "awareness", "concern", "practice_level",
               
               #R&D
               "rd_acttrain",
               
               #health
               "hs_awareness", "hs_applying"
               )



label_main <- raw_main %>%
  mutate(across(all_of(labelvars), susor::susor_get_stata_labels)) %>%
  mutate(across(all_of(labelvars), as.character))%>%
  rename(benefits = impact_benefits) 
  #mutate(across(matches("impact_"), susor::susor_get_stata_labels))

#head(label_main$benefits)

#names(label_main)
label_main %>%
  tabyl(practice_level)


#clean file -------------------------------------------------------------------
clean_main <- label_main 
#View(clean_main)  

#filter(interview__status != "InterviewAssigned")



#export ---------------------------------------------------------------------

export(clean_main, param$file_clean)


