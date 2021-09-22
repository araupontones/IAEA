cli::cli_alert_success("Plot: waiting improve")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "2.criterion/waiting.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "waiting.rds")
exfile <- file.path(dir_text_RT, "2.criterion/waiting.rds")

exfile

#import data -------------------------------------------------------------------

w_r <- import(infile) %>%
  arrange(country, year)
View(w_r)


#prepare for plot --------------------------------------------------------------

#calculate percentage below 10 days
w_p <- w_r %>%
  arrange(country, year) %>%
  filter(indicator %in% c("Less than 5 days","Between 5 and 6 days", "Between 7 and 9 days")) %>%
  group_by(country, year) %>%
  summarise(perc = sum(value, na.rm = T), .groups = 'drop') %>%
  filter(perc >0) 



    

w_20 <- round(mean(w_p$perc[w_p$year == "2020"]),1) %>% paste("%")
w_0 <-  round(mean(w_p$perc[w_p$year == "2000"]),1) %>%  paste("%")




txt <- list(
  
  w_0 = w_0,
  w_20 = w_20
)

exfile

export(txt, exfile)
