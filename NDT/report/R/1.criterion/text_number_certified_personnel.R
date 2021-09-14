cli::cli_alert_success("Text # certifield personel")
cli::cli_alert_info('Saved:in {file.path(dir_text_NDT, "1.criterion/number_certified_personel.rds")}')


survey <- "iaea_ndt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "certified_personel.rds") #created in clean
exfile <- file.path(dir_text_NDT, "1.criterion/number_certified_personel.rds")


#read data=====================================================================

personnel <- import(infile)
#View(personnel)

# View(personnel)

#create text ==================================================================
total_certified <- sum(personnel$cert_total_20)
total_certified_w <- sum(personnel$cert_total_20_women)

tot_year <- sum(personnel$cert_per)
tot_year <- prettyNum(tot_year, big.mark = ",")


perc_certified_women <- paste0(round(total_certified_w/total_certified, 3) *100, "%")
total_certified <- prettyNum(total_certified, big.mark = ",")


countries <- unique(personnel$country)
certified_number_countries <- length(countries)
certified_names_countries <- knitr::combine_words(sort(countries))


#calculate by method

personnel_methods <- personnel %>%
  group_by(method)%>%
  summarise(total = sum(cert_per)) %>%
  arrange(desc(total)) %>%
  mutate(method = as.character(method))




certified_top_method_name <-  as.character(personnel_methods[1,1]) 
certified_top_method_num <- as.numeric(personnel_methods[1,2]) %>% prettyNum(., big.mark = ",")

certified_second_method_name <-  as.character(personnel_methods[2,1]) 
certified_third_method_name <-  as.character(personnel_methods[3,1]) 




list_text <- list(
  
  total_certified = total_certified,
  perc_certified_women = perc_certified_women,
  certified_number_countries = certified_number_countries,
  certified_names_countries = certified_names_countries,
  certified_top_method_name = certified_top_method_name,
  certified_top_method_num = certified_top_method_num,
  certified_second_method_name = certified_second_method_name,
  certified_third_method_name = certified_third_method_name,
  tot_year = tot_year
  
)


#list_text$certified_third_method_name

export(list_text, exfile)

