cli::cli_alert_success("Text contribution to certification")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "1.criterion/contribution_RCA_cert.rds")}'))


infile <- file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_cert.rds")
exfile <- file.path(dir_text_NDT, "1.criterion/contribution_cert.rds")



contribution_cert <- import(infile)




#View(contribution_cert)

has_NCB <- contribution_cert$Country[contribution_cert$`Has NCB` == "Yes"]
has_NCB_num <- length(has_NCB) %>% to_text()



countries_NCB <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NCB` == "To a great extent"]
countries_NCB <- countries_NCB[!is.na(countries_NCB)]

countries_NCB_not <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NCB` == "Not at all"]

countries_NCB_num <- to_text(length(countries_NCB))
NCB_text_alot <- knitr::combine_words(sort(countries_NCB), sep = ", ")
NCB_text_not <- knitr::combine_words(sort(countries_NCB_not), sep = ", ")


texto <- list(
  
  a_lot = NCB_text_alot,
  num_alot = countries_NCB_num,
  not = NCB_text_not,
  has_NCB_num = has_NCB_num
  
)



export(texto, exfile)
