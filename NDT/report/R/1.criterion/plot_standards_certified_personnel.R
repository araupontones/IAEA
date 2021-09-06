
cli::cli_alert_success("Plot standard centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/cert_pers_standards.png")}'))

infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_certified_personel.rds")
exfile <- file.path(dir_plots_NDT,"1.criterion/cert_pers_standards.png" )

indicators_cert_pers <- import(infile)
pers_vars <- names(indicators_cert_pers)[!names(indicators_cert_pers) %in% c("country", "cert_pers_total", "cert_pers_standard")]




#plot certification ----------------------------------------------------------


#View(indicators_centre)

data_plot <- indicators_cert_pers %>%
  long_data_standards(var_total = cert_pers_total,
                      var_standard = cert_pers_standard,
                      vars_criterion = pers_vars,
                      prefix = "centres_pers")




#View(data_plot)
#data_plot$country
annotate_label <- data_plot %>% get_standard_label(standard = cert_pers_standard)

#View(annotate_label)

#View(annotate_label)


plot_standards(db = data_plot,
               x_title = "Evaluation Criteria Certified Personnel",
               vars_dimension = pers_vars,
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
