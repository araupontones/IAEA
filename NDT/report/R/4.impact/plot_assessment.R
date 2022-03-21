cli::cli_alert_info("Plot assessment")
cli::cli_alert_success(glue::glue('saved in {file.path(dir_plots_NDT, "4.impact/plot_assessment.pdf")}'))

dir_plots_NDT

exfile <- file.path(dir_plots_NDT, "4.impact/plot_assesment.pdf")
infile <- file.path(dir_clean_ndt, "iaea_ndt.rds")

ip_vars <- impact_vars()$ip_vars

View(ipct)

ipct <- import(infile) %>%
  arrange(country) %>%
  select(country,
         lkert = impact_assessment) %>%
  mutate(indicator = " ",
         lkert = case_when(is.na(lkert) ~ "N/A",
                           lkert == "Excellent" ~ "Important",
                           lkert == "Good" ~ "High",
                           lkert == "Poor" ~ "Minor",
                           T ~ lkert),
         lkert = factor(lkert, 
                        levels = rev(c("Important",
                                   "High",
                                   "Minor",
                                   "N/A")),
                        ordered = T)
  ) %>%
  arrange(lkert) %>%
  mutate(country = fct_reorder(country, row_number()))
        


ipct %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = lkert,
                    caption = caption_NDT,
                    pallete = c("white", color_inadequate,color_good ,blue_navy),
                    legend = "GP's assesment of the role of RCA in achieving objectives and benefits of NDT through industrial growth") 



# View(ipct)
# ipct %>%
#   tabyl(lkert)


exfile

ggsave(exfile, device = cairo_pdf,
       last_plot(),
       height = height_plot - 6.5,
       width = width_plot + 4,
       dpi = dpi_report)
