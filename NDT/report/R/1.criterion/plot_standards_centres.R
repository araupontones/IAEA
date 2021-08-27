#create chart for standards of criterion 1 certification

infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")
exfile <- file.path(dir_plots_NDT,"1.criterion/centre_standards.png" )

indicators_centre <- import(infile)
centre_vars <- criterion_1_vars()$centres_vars


#plot certification ----------------------------------------------------------


#View(indicators_centre)

data_plot <- indicators_centre %>%
  long_data_standards(var_total = centres_total,
                      var_standard = centres_standard,
                      vars_criterion = centre_vars,
                      prefix = "centres_")


#View(data_plot)
#data_plot$country
annotate_label <- data_plot %>% get_standard_label(standard = centres_standard)

#View(annotate_label)


plot_standards(db = data_plot,
               data_label = annotate_label,
               color_fill = blue_navy,
               color_text = c(blue_navy, blue_light, color_inadequate))


ggsave(exfile,
       last_plot(),
       height = height_plot + .5,
       width = width_plot + .5,
       units = 'cm',
       dpi = 360)








