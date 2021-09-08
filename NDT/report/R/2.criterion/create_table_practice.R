cli::cli_alert_success("Table number of industries")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "2.criterion/contribution_practice.rds")}'))

infile <- file.path(dir_clean_ndt, "practice.rds")
exfile <- file.path(dir_indicators_NDT,"2.criterion/contribution_practice.rds" )




prcts <- import(infile) %>%
  mutate(across(where(is.numeric), function(x)case_when(x == 1 ~ "Yes",
                                                        x == 0 ~ "No",
                                                        T ~ ""))
  ) %>%
  arrange(country, industry) %>%
  select(Country = country,
         `Industrial Sector` = industry,
         `NDT has caused positive improvements in Controlled manufacturing` = controlled_manufacturing,
         `NDT has caused positive improvements in Ensuring material quality` = ensuring_material_quality,
         `NDT has caused positive improvements in Greater product integrity` = greater_product_integrity,
         `NDT has caused positive improvements in Lower production costs` = lower_production_costs,
         `(%) by which production costs are lower between 2000 and 2020` =  productivity_cost
         
         
         )


exfile
export(prcts, exfile)
