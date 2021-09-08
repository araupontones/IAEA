cli::cli_alert_success("Contribution awareness")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "2.criterion/contribution_aws.rds")}'))

infile <- file.path(dir_indicators_NDT, "2.criterion/awareness.rds")
exfile <- file.path(dir_indicators_NDT,"2.criterion/contribution_aws.rds" )


#import data ------------------------------------------------------------------
aws <- import(infile)

main_qn <- import(file.path(dir_clean, "iaea_ndt/iaea_ndt.rds")) %>%
  select(country, awareness, starts_with("awareness_which")) %>%
  rename_at(vars(matches("awareness_")), function(x)str_remove_all(x, "awareness_")) %>%
  rename(`Has conducted seminars, workshops and/or forums`  = which__1,
        `Has engaged with policymakers and regulatory body(s)` = which__2,
        `Has conducted talks to universities or colleges` = which__3
        ) %>%
  select(Country = country,
         `Has taken actions to create awarenes about benefits of NDT` = awareness,
         starts_with("Has")
         
         
         ) %>%
  mutate(across(where(is.numeric), function(x)case_when(x == 1 ~ "Yes",
                                             x == 0 ~ "No",
                                             T ~ ""))) %>%
  arrange(Country)





export(main_qn, exfile)



View(main_qn)

#export
