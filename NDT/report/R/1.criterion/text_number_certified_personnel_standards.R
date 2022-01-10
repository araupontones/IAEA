cli::cli_alert_success("Text standatds certified personnel")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "1.criterion/stndrs_cert_pers.rds")}'))


infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_certified_personel.rds") 
exfile <- file.path(dir_text_NDT, "1.criterion/stndrs_cert_pers.rds")


cert_pers <-import(infile)


countries_excellent <- cert_pers$country[cert_pers$cert_pers_standard == "Excellent"] %>% as.character()
countries_gd <- cert_pers$country[cert_pers$cert_pers_standard == "Good"] %>% as.character()
countries_iq <- cert_pers$country[cert_pers$cert_pers_standard == "Minor"] %>% as.character()

ctres_excel_num <- length(countries_excellent) %>% to_text()
ctres_excel <- knitr::combine_words(sort(countries_excellent))

ctres_gd_num <- length(countries_gd) %>% to_text()
ctres_gd <- knitr::combine_words(sort(countries_gd))
ctres_iq <- knitr::combine_words(sort(countries_iq))


lista_txt <- list(
  ctres_excel_num = ctres_excel_num,
  ctres_excel = ctres_excel,
  ctres_gd_num =ctres_gd_num,
  ctres_gd = ctres_gd,
  ctres_iq = ctres_iq
  
  
)


export(lista_txt, exfile)
