cli::cli_alert_success("Text contribution to establishment of centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "1.criterion/contribution_centres.rds")}'))


infile <- file.path(dir_indicators_NDT, "1.criterion/contribution_RCA_centres.rds")
exfile <- file.path(dir_text_NDT, "1.criterion/contribution_centres.rds")



contribution_centre <- import(infile)



alot_inspec <- contribution_centre$Country[contribution_centre$`RCA contribution to establish local inspection centres` == "To a great extent"]
alot_inspec <- alot_inspec[!is.na(alot_inspec)]



alot_training <- contribution_centre$Country[contribution_centre$`RCA contribution to establish local training centres` == "To a great extent"]
alot_training <- alot_training[!is.na(alot_training)]

yes_investment <- contribution_centre$Country[contribution_centre$`RCA contributed to facilitate investment in inspection centres` == "Yes"]

alot_inspec_num <- to_text(length(alot_inspec))
alot_training_num <- to_text(length(alot_training))
yes_investment <- to_text(length(yes_investment))



alot_inspec <- knitr::combine_words(sort(alot_inspec), sep = ", ")
alot_inspec <- knitr::combine_words(sort(alot_inspec), sep = ", ")

alot_training <- knitr::combine_words(sort(alot_training), sep = ", ")



texto <- list(
  
  alot_inspec = alot_inspec,
  alot_inspec_num = alot_inspec_num,
  alot_training = alot_training,
  alot_training_num = alot_training_num,
  yes_investment = yes_investment
  
)


#exfile
export(texto, exfile)
