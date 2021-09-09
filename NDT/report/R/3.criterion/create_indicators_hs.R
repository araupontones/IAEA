cli::cli_alert_success("indicators Health and safety")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "3.criterion/indicators_hs.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
exfile <- file.path(dir_indicators_NDT, "3.criterion/indicators_hs.rds")


#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


vars_hs <- criterion_3_vars()$hs_vars
vars_hs


#inspection <- import(param$file_clean)
main_qn <- import(file.path(param$dir_clean_s, paste0(survey, ".rds"))) %>%
  select(country, matches(names(vars_hs))) %>%
  mutate(
         across(c(hs_awareness, hs_applying), function(x)x  %in% c("To a great extent", "Little")),
         across(c(hs_injuries, hs_deaths, hs_pollution), function(x)x >0),
         across(where(is.logical),function(x)case_when(is.na(x)~ FALSE,
                                                       T ~ x))) %>%

 standards_boolean(criterion = 'hs',
                    vars_criterion = vars_hs,
                    vars_adequate = c(hs_awareness),
                    vars_good = c(hs_applying),
                    vars_excellent = c(hs_injuries, hs_deaths, hs_pollution)) %>%
  rowwise() %>%
  #recode because excellent is if any
  mutate(check = any(`hs_Fewer injuries`, `hs_Fewer deaths`, `hs_Reduced pollution`)
        ) %>% ungroup() %>%
  mutate(hs_standard = case_when(check ~ "Excellent",
                                  T ~ as.character(hs_standard)),
         hs_standard = fct_reorder(hs_standard, hs_total)) %>%
  select(-check)
  



#exfile
export(main_qn, exfile)




