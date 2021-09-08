cli::cli_alert_success("Indicators long!, numbers R & D")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "2.criterion/RD_long.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
exfile <- file.path(dir_indicators_NDT, "2.criterion/RD_long.rds")


#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


vars_rd <- criterion_2_vars()$vars_rd



#inspection <- import(param$file_clean)
main_qn <- import(file.path(param$dir_clean_s, paste0(survey, ".rds"))) %>%
  select(country, rd_train, rd_act, rd_publications, rd_seminars) %>%
  mutate(across(c(rd_seminars, rd_publications), function(x) x * 20)) %>%
rename_at(vars(names(vars_rd)), function(x)vars_rd[x]) %>%
  pivot_longer(-country,
               names_to = "indicator") %>%
  filter(!is.na(value))


export(main_qn, exfile)



