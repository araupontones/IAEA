cli::cli_alert_success("indicators certification")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds")}'))


#create indicators for certification ------------------------------------------
survey <- "iaea_ndt"
module <- "iaea_ndt"
exfile <- file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds")

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


#import clean data -------------------------------------------------------------
clean_data <- import(param$file_clean)




#Identify variables=============================================================

#1certification
cert_vars <- criterion_1_vars()$cert_vars



#clean data
indicators_cert <- clean_data %>%
  
  #indicators of criterion 1: certification
  standards_boolean(vars_criterion = criterion_1_vars()$cert_vars,
      criterion = "cert",
       vars_adequate = cert_schm,
       vars_good = c(cert_society,cert_ncb),
       vars_excellent = c(cert_society_APPFNDT , cert_society_ICNDT ,
                          cert_ncb_iso17024 ,
                          cert_ncb_ICNDT)
       )

#View(indicators_cert)

#export ========================================================================
export(indicators_cert, exfile)


#View(indicators_cert)


