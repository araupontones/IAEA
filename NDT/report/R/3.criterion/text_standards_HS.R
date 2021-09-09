
cli::cli_alert_success("Text standard HS")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "3.criterion/txt_hs_s.rds")}'))

infile <- file.path(dir_indicators_NDT, "3.criterion/indicators_hs.rds")
exfile <- file.path(dir_text_NDT,"3.criterion/txt_hs_s.rds" )

hs <- import(infile)
hs_vars <- criterion_3_vars()$hs_vars

#View(indicators_rd)



#plot certification ----------------------------------------------------------

ctr_ex <- hs$country[hs$hs_standard == "Excellent"]
ctr_g <- hs$country[hs$hs_standard == "Good"]



ex_num <- length(ctr_ex) %>% to_text()
g_num <- length(ctr_g) %>% to_text()


aw_perc <- paste0(mean(hs$`hs_More aware of benefits for safer operations`) *100, "%")
ap_perc <- paste0(mean(hs$`hs_Apply NDT for safer operations`) *100, "%")
ap_perc

ex_tx <- knitr::combine_words(sort(ctr_ex))
g_tx <- knitr::combine_words(sort(ctr_g))



txt_stand <- list(
  
  ex_num = ex_num,
  g_num = g_num,
  ex_tx = ex_tx,
  g_tx = g_tx,
  aw_perc = aw_perc,
  ap_perc = ap_perc
  
)


export(txt_stand, exfile)
