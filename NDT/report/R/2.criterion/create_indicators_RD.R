cli::cli_alert_success("indicators R & D")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "2.criterion/RD.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
exfile <- file.path(dir_indicators_NDT, "2.criterion/RD.rds")


#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


vars_rd <- criterion_2_vars()$vars_rd



#inspection <- import(param$file_clean)
main_qn <- import(file.path(param$dir_clean_s, paste0(survey, ".rds"))) %>%
  select(country, rd_train, rd_act, rd_publications, rd_seminars) %>%
  mutate(rd_train = rd_train>0,
         rd_act = rd_act == 1,
         rd_publications = rd_publications > 0,
         rd_seminars = rd_seminars >0,
         across(where(is.logical),function(x)case_when(is.na(x)~ FALSE,
                                                       T ~ x))) %>%
  standards_boolean(criterion = 'rd',
                    vars_criterion = vars_rd,
                    vars_adequate = c(rd_train),
                    vars_good = c(rd_act),
                    vars_excellent = c(rd_publications, rd_seminars))




#exfile
export(main_qn, exfile)


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


