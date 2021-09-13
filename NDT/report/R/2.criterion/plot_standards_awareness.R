
cli::cli_alert_success("Plot standard awareness")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/standards_aws.png")}'))

infile <- file.path(dir_indicators_NDT, "2.criterion/awareness.rds")
exfile <- file.path(dir_plots_NDT,"2.criterion/standards_aws.png" )

indicators_aws <- import(infile)
aws_vars <- criterion_2_vars()$awareness_vars




#plot certification ----------------------------------------------------------


#View(indicators_centre)

data_plot <- indicators_aws %>%
  long_data_standards(var_total = aws_total,
                      var_standard = aws_standard,
                      vars_criterion = aws_vars,
                      prefix = "aws_")


data_plot_c <- data_plot %>%
  #this is because Australia did not provide this information
  mutate(not_answered = case_when(country == "Australia" & !str_detect(indicator, "Aware|apply") ~ "N/A",
                                  country == "Indonesia" & !str_detect(indicator, "Aware|apply") ~ "N/A",
                            T ~ ""))


#View(data_plot_c)


#View(data_plot)

#View(data_plot)
#data_plot$country
annotate_label <- data_plot %>% get_standard_label(standard = aws_standard)


#View(annotate_label)

#View(annotate_label)


plot_standards(db = data_plot,
               x_title = "Evaluation Criteria Awareness Interest, and Application",
               vars_dimension = aws_vars,
               caption = glue('The "N/A" indicates that information was not provided during the online survey.\n{caption}'),
               data_label = annotate_label,
               color_fill = blue_navy,
               color_text = c(color_adequate, blue_navy ,blue_light, color_inadequate)) +
  geom_text(data = data_plot_c,
            aes(x = indicator,
                y = country,
                label = not_answered),
            family = font_main,
            fontface = "italic",
            size = 3)
  
#exfile



#export ========================================================================
ggsave(exfile,
       last_plot(),
       height = height_standards,
       width = width_standards,
       units = 'cm',
       dpi = dpi_report)
