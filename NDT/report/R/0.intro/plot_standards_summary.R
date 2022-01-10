cli::cli_alert_success("Plot standard Criterion 2")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "intro/standard.png")}'))



dims <- c("centres", "cert", "certified_personel")
#dims must allow reading as follows:
#infile <- file.path(dir_indicators_NDT, glue("1.criterion/indicators_{x}.rds"))


exfile <- file.path(dir_plots_NDT,"intro/standard.png" )

#read all indicators  =====================================================

#criterion 1
cert  <- import(file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds"))
pers <- import(file.path(dir_indicators_NDT, "1.criterion/indicators_certified_personel.rds"))
centres <- import(file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds"))


#criterion 2
aws <- import(file.path(dir_indicators_NDT, "2.criterion/awareness.rds"))
rd <- import(file.path(dir_indicators_NDT, "2.criterion/RD.rds"))


#criterion 3
hs <- import(file.path(dir_indicators_NDT, "3.criterion/indicators_hs.rds"))


list_files <- list(
  cert, pers, centres,
  aws,rd,
  hs
  
)

#join tables
#files <- lapply(dims, read_dims)
files_app <- plyr::join_all(list_files, by = "country", type = 'left')





#prepare data for plot ========================================================

#define indicators

ind_vct <- c("cert_standard" = "Fulfillment MRA",
             'cert_pers_standard' = "Certified personnel",
             'centres_standard' = "Self-reliance in NDT",
             #criterion 2
             "aws_standard" = "Awareness, interest, and application",
             'rd_standard' = "Knowledge developed",
             #criterion 3
             "hs_standard" = "Health and Safety"
             )




#'data (files_app) must be the joint version of the standards of this dimension


data_plot <- files_app %>% 
  filter(!country %in% support_countries) %>%
  select(country, ends_with("standard")) %>%
  data_plot_standards_sum(ind_vct = ind_vct) %>%
  group_by(country)



#plot =======================================================================


  plot_standards_sum(data_plot)





exfile
ggsave(exfile,
       last_plot(),
       height = height_plot - 3.5,
       width = width_plot,
       dpi = dpi_report)






 
  
 
  
  
