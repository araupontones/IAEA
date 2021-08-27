infile <- file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_cert.rds")
exfile <- file.path(dir_text_NDT, "1.criterion/contribution_cert.rds")



contribution_cert <- import(infile)




countries_NCB <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NCB` == "To a great extent"]
countries_NCB <- countries_NCB[!is.na(countries_NCB)]

countries_NCB_not <- contribution_cert$Country[contribution_cert$`RCA contribution to establish NCB` == "Not at all"]

countries_NCB_num <- to_text(length(countries_NCB))
NCB_text_alot <- knitr::combine_words(sort(countries_NCB), sep = ", ")
NCB_text_not <- knitr::combine_words(sort(countries_NCB_not), sep = ", ")


texto <- list(
  
  a_lot = NCB_text_alot,
  num_alot = countries_NCB_num,
  not = NCB_text_not
  
)



export(texto, exfile)
