#create chart for standards of criterion 1 certification

cli::cli_alert_success("Plot standard centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/centre_standards.png")}'))

infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")
exfile <- file.path(dir_plots_NDT,"1.criterion/centre_standards.png" )

indicators_centre <- import(infile)
centre_vars <- criterion_1_vars()$centres_vars


#plot certification ----------------------------------------------------------


#View(indicators_centre)

data_plot <- indicators_centre %>%
  filter(!country %in% support_countries) %>%
  long_data_standards(var_total = centres_total,
                      var_standard = centres_standard,
                      vars_criterion = centre_vars,
                      prefix = "centres_")


#View(data_plot)
#data_plot$country
annotate_label <- data_plot %>% get_standard_label(standard = centres_standard)

#View(annotate_label)


plot_standards(db = data_plot,
               x_title = "Evaluation Criteria Self-Reliance",
               caption = caption,
               data_label = annotate_label,
               vars_dimension = centre_vars,
               color_fill = blue_navy,
               color_text = c(blue_navy, blue_light, color_inadequate))


ggsave(exfile,
       last_plot(),
       height = height_standards,
       width = width_standards,
       units = 'cm',
       dpi = dpi_report)









