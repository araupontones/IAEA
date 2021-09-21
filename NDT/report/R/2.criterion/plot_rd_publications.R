cli::cli_alert_success("Plot, trained people RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/RD_publications.png")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
infile <-file.path(dir_indicators_NDT, "2.criterion/RD_long.rds")
exfile <- file.path(dir_plots_NDT, "2.criterion/RD_publications.png")



#read data =====================================================================
rd <- import(infile)

names(rd)
rd %>%
  tabyl(indicator)




#prepare data =================================================================

rd_plot <- rd %>%
  filter(indicator == "Pubilished publication",
         value > 0) %>%
  mutate(country = fct_reorder(country, value))

#View(rd_plot)

max(rd_plot$value, na.rm = T)

bar_plot(
  db = rd_plot,
  x_var = value,
  y_var = country,
  caption = caption_NDT,
  x_title = "Publications related to NDT have been published since 2000",
  limits = c(0,270),
  label = value,
  fill = blue_navy
)

exfile

#export===========================================================================

ggsave(exfile,
       last_plot(),
       width = width_plot,
       height = height_plot,
       dpi = dpi_report,
       units = "cm")
