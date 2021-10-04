cli::cli_alert_success("Table: waiting improve")
cli::cli_alert_info('Saved:in {file.path(dir_indicators_RT, "2.criterion/waiting.rds")}')


#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "waiting.rds")
exfile <- file.path(dir_indicators_RT, "2.criterion/waiting.rds")



#import data -------------------------------------------------------------------

w_r <- import(infile) %>%
  arrange(country, year) %>%
  pivot_wider(id_cols = c(country, indicator),
              values_from = "value",
              names_from = "year"
              ) %>%
  rename(Country = country,
         `Waiting time` = indicator) %>%
  mutate(Change = `2020` - `2000`) %>%
  mutate(across(all_of(c("2020", "2000", "Change")), function(x)case_when(is.na(x) ~ "",
                                                                          T ~paste0(x,"%")))
  )
View(w_r)




export(w_r, exfile)
