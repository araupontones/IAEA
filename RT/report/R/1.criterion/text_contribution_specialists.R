cli::cli_alert_success("Plot # contribution personnel")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "1.criterion/contribuion_trained.rds")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_text_RT, "1.criterion/contribuion_trained.rds")


t <- import(infile) %>%
  select(country, init_year)


View(t)

#read data ====================================================================

soc <- import(file.path(param$dir_clean_s, "societies.rds")) %>%
  group_by(country) %>%
  summarise(soc_num = sum(value, na.rm = T))

#join
cont <- import(infile) %>%
  select(country, train_num,train_cont, dep_num, dep_cont, soc_cont) %>%
  left_join(soc, by = "country")
mutate(country = fct_reorder(country, train_num)) 
filter(train_num >0 & !is.na(train_num))



cont %>%
  filter(train_num >0 & !is.na(train_num)) %>%
  tabyl(train_cont)
  View()
  
  
  cont %>%
    filter(dep_num >0 & !is.na(dep_num)) %>%
    filter(dep_cont %in% c("To a great extent")) %>%
    .$country %>%
    sort() %>%
    knitr::combine_words()
    #tabyl(dep_cont)
    View()
    
    
  
  