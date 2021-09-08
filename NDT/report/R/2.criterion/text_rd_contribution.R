cli::cli_alert_success("Text, RD contribution")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "2.criterion/rd_tx_c.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
infile <-file.path(dir_indicators_NDT, "2.criterion/RD_long.rds")
exfile <- file.path(dir_text_NDT, "2.criterion/rd_tx_c.rds")



#read data =====================================================================
rd <- import(infile)

names(rd)
rd %>%
  tabyl(indicator)

#View(rd)

trained <- sum(rd$value[rd$indicator == "Trained people under RCA NDT"]) %>% prettyNum(., big.mark = ",")
publications <- sum(rd$value[rd$indicator == "Pubilished publication"]) %>% prettyNum(., big.mark = ",")
seminars <- sum(rd$value[rd$indicator == "Organized seminars"]) %>% prettyNum(., big.mark = ",")
activities <- paste0(sum(rd$value[rd$indicator == "Established any R&D activities"]) /20 *100, "%")










#export===========================================================================


rd_text <- list(
  
  
  trained = trained,
  publications = publications,
  seminars = seminars,
  activities = activities
)

exfile
export(rd_text, exfile)
