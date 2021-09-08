
cli::cli_alert_success("Text standard RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "2.criterion/txt_rd_s.rds")}'))

infile <- file.path(dir_indicators_NDT, "2.criterion/RD.rds")
exfile <- file.path(dir_text_NDT,"2.criterion/txt_rd_s.rds" )

rd <- import(infile)
rd_vars <- criterion_2_vars()$vars_rd

#View(indicators_rd)



#plot certification ----------------------------------------------------------

ctr_ex <- rd$country[rd$rd_standard == "Excellent"]
ctr_g <- rd$country[rd$rd_standard == "Good"]

ex_num <- length(ctr_ex) %>% to_text()
g_num <- length(ctr_g) %>% to_text()


ex_tx <- knitr::combine_words(sort(ctr_ex))
g_tx <- knitr::combine_words(sort(ctr_g))


txt_stand <- list(
  
  ex_num = ex_num,
  g_num = g_num,
  ex_tx = ex_tx,
  g_tx = g_tx
  
)


export(txt_stand, exfile)
