cli::cli_alert_success("Table RCA contribution certification")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_cert.rds")}'))



#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds")
exfile <- file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_cert.rds")

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


#define impact vars
impact_vars <- c(
  "cert_body_lkrt",
  "cert_society_lkrt"
  #"traincen_local_lkrt",
  #"impact_inspection",
  #"impact_inspinvest"
  
)

main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds")) %>%
  select(country, all_of(impact_vars)) 
#create table to vis the contribution of RCA in certification
cert_ind <- import(infile) %>%
  left_join(main,  by = "country") %>%




  mutate(across(c(`cert_Established NCB`,`cert_Established NDT Society`),True_to_YesNo)) %>%
  select(Country = country,
         `Has NCB` = `cert_Established NCB`,
         `RCA contribution to establish NCB` = cert_body_lkrt,
         `Has NDT certification scheme` = `cert_Established NDT Society`, 
         `RCA contribution to establish NDT certification scheme` = cert_society_lkrt
         #`RCA standard` = cert_standard
  ) %>%
  arrange(Country)



#View(cert_ind)

export(cert_ind, exfile)


