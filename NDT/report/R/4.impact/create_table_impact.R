cli::cli_alert_info("Indicators impact")
cli::cli_alert_success(glue::glue('saved in {file.path(dir_indicators_NDT, "4.impact/table_impact.rds")}'))


exfile <- file.path(dir_indicators_NDT, "4.impact/table_impact.rds")
infile <- file.path(dir_clean_ndt, "iaea_ndt.rds")

ip_vars <- impact_vars()$ip_vars



ipct <- import(infile) %>%
  arrange(country) %>%
  select(country, init_year,all_of(names(ip_vars))) %>%
  rename(Country = country) %>%
  rename_at(vars(names(ip_vars)), function(x)ip_vars[x]) %>%
  rename(`Year when first took part in the RCA NDT` = init_year)


#View(ipct)


exfile

export(ipct, exfile)
