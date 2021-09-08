
cli::cli_alert_success("Text standard awareness")
cli::cli_alert_info(glue('Saved: {file.path(dir_text_NDT, "2.criterion/tx_standards_aws.rds")}'))

infile <- file.path(dir_indicators_NDT, "2.criterion/awareness.rds")
exfile <- file.path(dir_text_NDT,"2.criterion/tx_standards_aws.rds" )


#import data ------------------------------------------------------------------
indicators_aws <- import(infile)
aws_vars <- criterion_2_vars()$awareness_vars



#text certification ----------------------------------------------------------

ctrs_ex <- indicators_aws$country[indicators_aws$aws_standard == "Excellent"]

ctrs_ex_num <- length(ctrs_ex) %>% to_text()
ctrs_ex_tx <- knitr::combine_words(sort(ctrs_ex))


aws_perc <- paste0(mean(indicators_aws$`aws_Awareness about NDT tech.`) *100, "%")



text_aws <- list(
  
  ctrs_ex_num = ctrs_ex_num,
  ctrs_ex_tx = ctrs_ex_tx,
  aws_perc = aws_perc
  
  
  
)



export(text_aws, exfile)
