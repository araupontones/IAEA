cli::cli_alert_success("Plot RO societies")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "1.criterion/societies.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "soc_types"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "societies.rds") 
exfile <- file.path(dir_text_RT, "1.criterion/societies.rds")



soc <- import(infile) %>%
  filter(!is.na(value))

#text -------------------------------------------------------------------------

tot_soc <- sum(soc$value, na.rm = T)
reg_soc <- sum(soc$value[soc$type == "Regional"])
reg_perc <- paste0(round(reg_soc/tot_soc *100, 1),"%")



#countries with only regional
c_national <- soc %>%
  filter(value >0) %>%
  group_by(country) %>%
  mutate(obs = n()) %>%
  filter(obs ==1) %>%
  .$country %>%
  sort() %>%
  knitr::combine_words()

  


txt <- list(
  tot_soc = tot_soc,
  reg_perc = reg_perc,
  c_national = c_national
  
  
)

exfile
export(txt, exfile)
