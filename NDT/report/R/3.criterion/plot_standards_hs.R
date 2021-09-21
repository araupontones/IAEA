
cli::cli_alert_success("Plot standard HS")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "3.criterion/standards_HS.png")}'))

infile <- file.path(dir_indicators_NDT, "3.criterion/indicators_hs.rds")
exfile <- file.path(dir_plots_NDT,"3.criterion/standards_HS.png" )

indicators_hs <- import(infile)
hs_vars <- criterion_3_vars()$hs_vars

#plot certification ----------------------------------------------------------


#View(indicators_centre)

data_plot <- indicators_hs %>%
  filter(!country %in% support_countries) %>%
  long_data_standards(var_total = hs_total,
                      var_standard = hs_standard,
                      vars_criterion = hs_vars,
                      prefix = "hs_")





#View(data_plot)
#data_plot$country
annotate_label <- data_plot %>% get_standard_label(standard = hs_standard)


#View(annotate_label)

#View(annotate_label)


plot_standards(db = data_plot,
               x_title = "Evaluation Criteria Improved Health & Safety",
               vars_dimension = hs_vars,
               caption = caption_NDT,
               data_label = annotate_label,
               color_fill = blue_navy,
               color_text = c(blue_navy,blue_light,color_adequate, color_inadequate))
#exfile



#export ========================================================================
ggsave(exfile,
       last_plot(),
       height = height_standards,
       width = width_standards,
       units = 'cm',
       dpi = dpi_report)
