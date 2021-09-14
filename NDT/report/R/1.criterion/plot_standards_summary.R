cli::cli_alert_success("Plot standard Criterion 1")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/standards_crit1.png")}'))



dims <- c("centres", "cert", "certified_personel")
#dims must allow reading as follows:
#infile <- file.path(dir_indicators_NDT, glue("1.criterion/indicators_{x}.rds"))


exfile <- file.path(dir_plots_NDT,"1.criterion/standards_crit1.png" )

#read all indicators  =====================================================

#join tables
files <- lapply(dims, read_dims)
files_app <- plyr::join_all(files, by = "country", type = 'left') %>%
  filter(!country %in% support_countries)




#prepare data for plot ========================================================

#define indicators
ind_vct <- c("cert_standard" = "Fulfillment MRA",
             'cert_pers_standard' = "Certified personnel",
             'centres_standard' = "Self-reliance in NDT")


#'data (files_app) must be the joint version of the standards of this dimension


data_plot <- files_app %>% data_plot_standards_sum(ind_vct = ind_vct)



#plot =======================================================================


  plot_standards_sum(data_plot)

exfile

ggsave(exfile,
       last_plot(),
       height = height_plot - 5,
       width = width_plot,
       dpi = dpi_report)






 
  
 
  
  
