
cli::cli_alert_success("Plot standard RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/standards_RD.png")}'))

infile <- file.path(dir_indicators_NDT, "2.criterion/RD.rds")
exfile <- file.path(dir_plots_NDT,"2.criterion/standards_RD.png" )

indicators_rd <- import(infile)
rd_vars <- criterion_2_vars()$vars_rd



names(indicators_rd)
#plot certification ----------------------------------------------------------


#View(indicators_centre)

data_plot <- indicators_rd %>%
  filter(!country %in% support_countries) %>%
  long_data_standards(var_total = rd_total,
                      var_standard = rd_standard,
                      vars_criterion = rd_vars,
                      prefix = "rd_")





#View(data_plot)
#data_plot$country
annotate_label <- data_plot %>% get_standard_label(standard = rd_standard)


#View(annotate_label)

#View(annotate_label)


plot_standards(db = data_plot,
               x_title = "Evaluation Criteria Research and Development",
               vars_dimension = rd_vars,
               caption = caption,
               data_label = annotate_label,
               color_fill = blue_navy,
               color_text = c(color_adequate, blue_navy ,blue_light, color_inadequate))
#exfile



#export ========================================================================
ggsave(exfile,
       last_plot(),
       height = height_standards,
       width = width_standards,
       units = 'cm',
       dpi = dpi_report)
