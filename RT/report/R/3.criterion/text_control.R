cli::cli_alert_success("Plot: waiting improve")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "3.criterion/control.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "control.rds")
exfile <- file.path(dir_text_RT, "3.criterion/control.rds")

exfile

#import data -------------------------------------------------------------------

c <- import(infile) %>%
  arrange(country, year)




#calculate percentage control rates ===========================================
c_all <- c %>%
  arrange(country, year) %>%
  group_by(year) %>%
  summarise(perc = mean(cont_num, na.rm = T), .groups = 'drop')



c_all    

c_0 <- c_all[1,2] %>% as.double() %>% round(1)
c_20 <- c_all[2,2] %>% as.double()%>% round(1)
imp_c <- c_20 - c_0

c_0 <- paste0(c_0, "%")
c_20 <- paste0(c_20, "%")
imp_c <- paste(imp_c, "pp")



#calculate percentage life rates ===========================================
l_all <- c %>%
  arrange(country, year) %>%
  group_by(year) %>%
  summarise(perc = mean(surv_num, na.rm = T), .groups = 'drop')



    

l_0 <- l_all[1,2] %>% as.double() %>% round(1)
l_20 <- l_all[2,2] %>% as.double()%>% round(1)
imp_l <- l_20 - l_0

l_0 <- paste0(l_0, "%")
l_20 <- paste0(l_20, "%")
imp_l <- paste(imp_l, "pp")




txt <- list(
  
  imp_c = imp_c,
  c_20 = c_20,
  c_0 = c_0,
  imp_l = imp_l,
  l_20 = l_20,
  l_0 = l_0
  
)



export(txt, exfile)
