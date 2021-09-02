cli::cli_alert_success("Cleaning inspection centres")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_ndt/inspection_firms.rds")

survey <- "iaea_ndt"
module <- "inspec"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

exfile <- file.path(param$dir_clean_s, "inspection_firms.rds")

main_qn <- import(file.path(param$dir_clean_s, paste0(survey,".rds")))
#View(main_qn)

#import rosters of inspection firms -------------------------------------------
inspec_raw <- import(param$file_raw) %>%
  rename(id = inspec__id)

inspec_local <- import(file.path(param$dir_raw_s, "inspeclocal.dta")) %>%
  rename(id = inspeclocal__id)

inspec_revuenues <- import(file.path(param$dir_raw_s, "revenues.dta")) %>%
  rename(id = revenues__id)



#clean rosters and join together ----------------------------------------------
inspec <- inspec_raw %>%
  left_join(inspec_local, by = c("interview__key", "interview__id", "id")) %>%
  left_join(inspec_revuenues, by = c("interview__key", "interview__id", "id")) %>%
  left_join(select(main_qn, c(country, interview__key, currency)), by = "interview__key") %>%
  select(country,
         year = id,
         inspec_firms = inspec_num,
         inspec_perc_local = inspec_numloc,
         inspec_revenue = revenue,
         currency) %>%
  
  #clean variables and create relevant indicators 
  mutate(year = case_when(year == 1 ~ 2000,
                          year == 2 ~ 2021),
         inspec_perc_local = inspec_perc_local/100,
         inspec_local_firms = round(inspec_firms * inspec_perc_local, digits = 0),
         inspec_local_firms = case_when(is.na(inspec_local_firms) ~ inspec_firms,
                                  T ~ inspec_local_firms),
         inspec_foreign_firms = inspec_firms - inspec_local_firms,
         inspec_foreign_firms = case_when(is.na(inspec_foreign_firms) ~ inspec_foreign_firms,
                                         T ~ inspec_foreign_firms),
         
         ) %>%
  #count growth of companies by country
  group_by(country) %>%
  arrange(country, year) %>%
  mutate(
    inspec_growth_local = inspec_local_firms - lag(inspec_local_firms, 1),
    inspec_growth_foreign = inspec_foreign_firms - lag(inspec_foreign_firms, 1),
    currency = susor::susor_get_stata_labels(currency)
  )


#View(inspec)

#export 
export(inspec, exfile)

