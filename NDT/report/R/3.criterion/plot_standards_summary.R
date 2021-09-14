cli::cli_alert_success("Plot standard Criterion 2")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/standards_crit2.png")}'))



#dims <- c("centres", "cert", "certified_personel")
#dims must allow reading as follows:
#infile <- file.path(dir_indicators_NDT, glue("1.criterion/indicators_{x}.rds"))


exfile <- file.path(dir_plots_NDT,"3.criterion/standards_crit3.png" )

#read all indicators  =====================================================

hs <- import(file.path(dir_indicators_NDT, "3.criterion/indicators_hs.rds"))
#rd <- import(file.path(dir_indicators_NDT, "2.criterion/RD.rds"))

#join tables
#files <- lapply(dims, read_dims)
#files_app <- plyr::join_all(list(aws, rd), by = "country", type = 'left')
files_app <- hs



#prepare data for plot ========================================================

#define indicators
ind_vct <- c("hs_standard" = "Health and Safety")


#'data (files_app) must be the joint version of the standards of this dimension


data_plot <- files_app %>% 
  filter(!country %in% support_countries) %>%
  select(country, ends_with("standard")) %>%
  data_plot_standards_sum(ind_vct = ind_vct)



#plot =======================================================================


  plot_standards_sum(data_plot,
                     pallete = c(color_inadequate, color_good, blue_navy))



ggsave(exfile,
       last_plot(),
       height = height_plot - 6,
       width = width_plot,
       dpi = dpi_report)






 
  
 
  
  
