cli::cli_alert_success("Plot standard Criterion 2")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/standards_crit2.pdf")}'))



dims <- c("centres", "cert", "certified_personel")
#dims must allow reading as follows:
#infile <- file.path(dir_indicators_NDT, glue("1.criterion/indicators_{x}.rds"))


exfile <- file.path(dir_plots_NDT,"2.criterion/standards_crit2.pdf" )

#read all indicators  =====================================================

aws <- import(file.path(dir_indicators_NDT, "2.criterion/awareness.rds"))
rd <- import(file.path(dir_indicators_NDT, "2.criterion/RD.rds"))

#join tables
files <- lapply(dims, read_dims)
files_app <- plyr::join_all(list(aws, rd), by = "country", type = 'left') %>%
  filter(!country %in% support_countries) 




#prepare data for plot ========================================================

#define indicators
ind_vct <- c("aws_standard" = "Awareness, interest, and application",
             'rd_standard' = "Knowledge developed through R&D")


#'data (files_app) must be the joint version of the standards of this dimension


data_plot <- files_app %>% 
  select(country, ends_with("standard")) %>%
  data_plot_standards_sum(ind_vct = ind_vct)



#plot =======================================================================


  plot_standards_sum(data_plot)

exfile

ggsave(exfile, device = cairo_pdf,
       last_plot(),
       height = height_plot - 6,
       width = width_plot,
       dpi = dpi_report)






 
  
 
  
  
