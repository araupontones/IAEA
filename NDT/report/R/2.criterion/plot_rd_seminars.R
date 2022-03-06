cli::cli_alert_success("Plot, #seminars RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/RD_seminar.png")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
infile <-file.path(dir_indicators_NDT, "2.criterion/RD_long.rds")
exfile <- file.path(dir_plots_NDT, "2.criterion/RD_seminar.png")



#read data =====================================================================
rd <- import(infile)

names(rd)
rd %>%
  tabyl(indicator)




#prepare data =================================================================

rd_plot <- rd %>%
  filter(indicator == "Organized seminars",
         value > 0) %>%
  mutate(value = case_when(country == "Mongolia" ~ 10,
                           T ~ value)) %>%
  mutate(country = fct_reorder(country, value))

View(rd_plot)

sum(rd_plot$value)

bar_plot(
  db = rd_plot,
  x_var = value,
  y_var = country,
  caption = caption_NDT,
  x_title = "NDT Seminars/conferences organized since 2000",
  limits = c(0,1100),
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
