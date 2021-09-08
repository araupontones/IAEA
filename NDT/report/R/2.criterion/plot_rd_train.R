cli::cli_alert_success("Plot, trained people RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/RD_train.png")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
infile <-file.path(dir_indicators_NDT, "2.criterion/RD_long.rds")
exfile <- file.path(dir_plots_NDT, "2.criterion/RD_train.png")



#read data =====================================================================
rd <- import(infile)

names(rd)
# rd %>%
#   tabyl(indicator)




#prepare data =================================================================

rd_plot <- rd %>%
  filter(indicator == "Trained people under RCA NDT",
         value > 0) %>%
  mutate(country = fct_reorder(country, value))


max(rd_plot$value)

bar_plot(
  db = rd_plot,
  x_var = value,
  y_var = country,
  x_title = "Personnel trained on NDT under the RCA NDT programme",
  limits = c(0,1150),
  label = value,
  fill = blue_navy
)

#exfile

#export===========================================================================

ggsave(exfile,
       last_plot(),
       width = width_plot,
       height = height_plot,
       dpi = dpi_report,
       units = "cm")
