
cli::cli_alert_success("Text number of industries")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "2.criterion/number_industries.rds")}'))

infile <- file.path(dir_clean_ndt, "practice.rds")
exfile <- file.path(dir_text_NDT,"2.criterion/number_industries.rds" )



#read data =====================================================================

prcts <- import(infile)


ctrs <- sort(unique(prct$country))
ctrs_num <- length(ctrs)
ctrs_perc <- paste0(ctrs_num / 20 *100, "%")



txt_practice <- list(
  ctrs_perc = ctrs_perc
  
)

exfile
export(txt_practice, exfile)


