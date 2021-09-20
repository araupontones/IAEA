cli::cli_alert_success("Text RO specialists")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "1.criterion/number_specialists.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_text_RT, "1.criterion/number_specialists.rds")
infile <- file.path(param$dir_clean_s, "specialists.rds")



#read file --------------------------------------------------------------------
spec <- import(infile)

#total -------------------------------------------------------------------------

total <- spec %>%
  filter(indicator == "Total") %>%
  filter(year == "2020") %>%
  filter(!is.na(value)) %>%
  group_by(country) %>%
  summarise(total = sum(value), .groups = 'drop') %>%
  arrange(desc(total)) 



cert <- spec %>%
  filter(indicator == "Certified") %>%
  filter(year == "2020") %>%
  filter(!is.na(value))  %>%
  group_by(country) %>%
  summarise(total = sum(value), .groups = 'drop') %>%
  arrange(desc(total)) 





total_20 <- sum(total$total) 
cert_20 <- sum(cert$total)


perc_cert_20 <- paste0(round(cert_20 / total_20 * 100, 1), "%")
total_20 <- prettyNum(total_20, big.mark = ",")

count1 <- as.character(total[1,1])
count1_num <- prettyNum(as.numeric(total[1,2]), big.mark = ",")


count2 <- as.character(total[2,1])
count2_num <- prettyNum(as.numeric(total[2,2]), big.mark = ",")

count3 <- as.character(total[3,1])
count3_num <- prettyNum(as.numeric(total[3,2]), big.mark = ",")

count3_num
#by method ---------------------------------------------------------------------
meth <- spec %>%
  filter(indicator == "Total") %>%
  group_by(method) %>%
  summarise(total = sum(value, na.rm = T), .groups = 'drop') %>%
  arrange(desc(total)) %>%
  mutate(method = as.character(method))



meth1 <- as.character(meth[1,1])
meth1_num <- prettyNum(as.numeric(meth[1,2]), big.mark = ",")


#View(spec_plot)


txt <- list(
  total_20 = total_20,
  perc_cert_20 = perc_cert_20,
  count1 = count1,
  count1_num = count1_num,
  count2_num = count2_num,
  count3_num = count3_num,
  count2 = count2,
  count3 = count3,
  meth1 =meth1,
  meth1_num = meth1_num
  
  
)



#export ==================================================================


#=================================================================================
exfile

export(txt, exfile)

