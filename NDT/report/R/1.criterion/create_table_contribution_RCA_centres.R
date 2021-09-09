cli::cli_alert_success("Table RCA contribution establishment centers")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_centres.rds")}'))


#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")
exfile <- file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_centres.rds")

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


#define impact vars
impact_vars <- c(
  # "cert_body_lkrt",
  # "cert_society_lkrt"
  "traincen_local_lkrt",
  "impact_inspection",
  "impact_inspinvest"
  
)


#"centres_Inspection companies (local)" 
#impact_inspection : contributed to the establishment of local centres
#impact_inspinvest : RCA NDT facilitate local investment in NDT inspection facilities
#centres_Training centres (local)
#traincen_local_lkrt " etablishment of local training centres

#read main table ---------------------------------------------------------------
main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds")) %>%
  select(country, all_of(impact_vars))

#create table to vis the contribution of RCA in certification -----------------
cert_ind <- import(infile) %>%
  left_join(main, Joining, by = "country") %>%
  mutate(across(c(`centres_Inspection companies (local)`,  `centres_Training centres (local)`),True_to_YesNo)) %>%
  select(Country = country,
         `Has local inspection companies` = `centres_Inspection companies (local)`,
         `RCA contribution to establish local inspection centres` = impact_inspection,
         `RCA contributed to facilitate investment in inspection centres` = impact_inspinvest,
         `Has local training centres` = `centres_Training centres (local)`, 
         `RCA contribution to establish local training centres` = traincen_local_lkrt
         #`RCA standard` = centres_standard
  ) %>%
  arrange(Country)
#View(cert_ind)

#View(cert_ind)


export(cert_ind, exfile)


