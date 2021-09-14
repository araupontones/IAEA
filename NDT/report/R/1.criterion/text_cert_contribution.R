cli::cli_alert_success("Text contribution to certification")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "1.criterion/contribution_RCA_cert.rds")}'))


infile <- file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_cert.rds")
exfile <- file.path(dir_text_NDT, "1.criterion/contribution_cert.rds")



contribution_cert <- import(infile) %>%
  filter(!Country %in% support_countries)

#contribution_cert %>%tabyl(Country)



#View(contribution_cert)

has_NCB <- contribution_cert$Country[contribution_cert$`Has NCB` == "Yes"]
has_NCB_num <- length(has_NCB) %>% to_text()
has_NCB_perc <-  paste0(round(length(has_NCB) / receipient_num *100,0),"%")

# contribution_cert %>%
#   tabyl(`RCA contribution to establish NCB`)
  

has_cerSch_perc  <- paste0(mean(contribution_cert$`Has NDT certification scheme` == "Yes") * 100, "%")

countries_NCB <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NCB` == "To a great extent"]
countries_NCB <- countries_NCB[!is.na(countries_NCB)]


NCS_ <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NDT certification scheme` == "To a great extent"]
NCS_ <- NCS_[!is.na(NCS_)]


ncs_perc <- paste0(length(NCS_) /20 *100, "%")


countries_NCB_not <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NCB` == "Not at all"]

countries_NCB_num <- to_text(length(countries_NCB))
NCB_text_alot <- knitr::combine_words(sort(countries_NCB), sep = ", ")
NCB_text_not <- knitr::combine_words(sort(countries_NCB_not), sep = ", ")


texto <- list(
  
  a_lot = NCB_text_alot,
  num_alot = countries_NCB_num,
  not = NCB_text_not,
  has_NCB_num = has_NCB_num,
  has_NCB_perc = has_NCB_perc,
  has_cerSch_perc = has_cerSch_perc,
  ncs_perc = ncs_perc
  
)



export(texto, exfile)

