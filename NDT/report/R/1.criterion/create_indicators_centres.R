cli::cli_alert_success("indicators training & inspection centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
exfile <- file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")


#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


inspection <- import(param$file_clean)
main_qn <- import(file.path(param$dir_clean_s, paste0(survey, ".rds"))) %>%
  select(country, traincen, traincen_local, inspec_local_abroad, traincen_local_abroad)




#View(centres_1)
#Indicators=====================================================================

centres_1 <- inspection %>%
  filter(year == 2021) %>%
  mutate(inspect_foreign = inspec_foreign_firms > 0,
         inspect_local = inspec_local_firms >0) %>%
  select(country, inspect_local, inspect_foreign) %>%
  left_join(main_qn,  by = "country") %>%
  mutate(
    #training centres
    traincen_foreign = traincen - traincen_local,
    traincen_foreign = NA_to_cero(traincen_foreign),
    traincen_foreign = traincen_foreign >0,
    traincen_local = NA_to_cero(traincen_local),
    traincen_local = traincen_local >0,
    
    #abroad
    inspec_local_abroad = NA_to_no(inspec_local_abroad),
    inspec_local_abroad = inspec_local_abroad == "Yes" & inspect_local==T,
    traincen_local_abroad = NA_to_no(traincen_local_abroad),
    traincen_local_abroad = traincen_local_abroad == "Yes" & traincen_local==T,
  ) 
         


#create indicators ----------------------------------------------------------
ind_centres <- centres_1 %>%
  standards_boolean(criterion = "centres",
                    vars_criterion = criterion_1_vars()$centres_vars,
                    vars_adequate = c(inspect_foreign, traincen_foreign),
                    vars_good = c(inspect_local,traincen_local),
                    vars_excellent = c(inspec_local_abroad, traincen_local_abroad)
                    ) %>%
  #correct standard of Cambodia
  mutate(centres_standard = as.character(centres_standard),
         centres_standard = case_when(country == "Cambodia" ~ "Good",
                                      T ~ centres_standard),
         centres_standard = factor(centres_standard,
                                   levels = rev(c("Inadequate", "Adequate", "Good", "Excellent")),
                                   ordered = T)
         )




#View(ind_centres)

export(ind_centres, exfile)


#adequate
#GPs have training centres owned by foreign entities: traincen - train_local > 0 
#nd inspection companies owned by foreign entities, from inspection firms

#adequate = c(inspect_foreign, traincen_foreign)

#good 
#have local NDT training centres and inspection companies offering services to local industry. (local exists)
#good = c(inspect_local,traincen_local)

#excellent 
#excellent c(inspec_local_aborad, traincen_local_aborad)
#offering training and inspection activities to local industries as well as abroad. inspec_local_abroad traincen_local_abroad


