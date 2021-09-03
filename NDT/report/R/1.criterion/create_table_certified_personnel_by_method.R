cli::cli_alert_success("Table # certifield personel by method")
cli::cli_alert_info('Saved:in {file.path(dir_indicators_NDT, "1.criterion/certified_personel_by_method.rds")}')

dir_indicators_NDT
survey <- "iaea_ndt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "certified_personel.rds") #created in clean
exfile <- file.path(dir_indicators_NDT, "1.criterion/certified_personel_by_method.rds")


#clean data ====================================================================
personnel <- import(infile) %>%
  group_by(method,accronym, type) %>%
  summarise(avg_year = sum(cert_per),
            total_20 = sum(cert_total_20),
            women_20 = sum(cert_total_20_women),
            countries = n_distinct(country),
            .groups = 'drop') %>%
  arrange(desc(accronym))
  #adorn_totals("row")

  
#count totals -------------------------------------------------------------  
total <- tibble(
  
  method = "Total",
  accronym = "-",
  type = "-",
  avg_year = sum(personnel$avg_year),
  total_20 = sum(personnel$total_20),
  women_20 = sum(personnel$women_20),
  countries = max(personnel$countries)
  
  
)

#append totals and clean -------------------------------------------------

personnel_table <- rbind(personnel, total) %>%
  mutate(women_20 = paste0(round(women_20 / total_20 *100,2), "%"),
         women_20 = case_when(women_20 == "NaN%"~ "-",
                              T ~ women_20),
         across(c(avg_year, total_20), function(x)prettyNum(x, big.mark = ",")),
         type = case_when(type == "Main" ~ "Conventional",
                          type == "Advanced" ~ "Advanced technique",
                          T ~ type)
         ) %>%
  rename(Method = method,
         Accronym = accronym,
         Type = type,
         `Persnonnel certified per year` = avg_year,
         `Personnel certified from 2000 to 2020` = total_20,
         `(%) of Certified female personnel` = women_20,
         `Countries supported by RCA NDT` = countries
         )
  
  #View(personnel_table)
#export ------------------------------------------------------------------------
  export(personnel_table, exfile)
 
         