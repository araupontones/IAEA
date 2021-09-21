
cli::cli_alert_success("Plot number of industries")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/number_industries.rds")}'))

infile <- file.path(dir_clean_ndt, "practice.rds")
exfile <- file.path(dir_plots_NDT,"2.criterion/number_industries.png" )



#import data ------------------------------------------------------------------
prct <- import(infile)

#aws_vars <- criterion_2_vars()$awareness_vars

#View(prct)


#prepare data for plot ----------------------------------------------------------

prct_plot <- prct %>%
  group_by(country) %>%
  summarise(industries = n()) %>%
  mutate(country = fct_reorder(country, industries))




#plot ----------------------------------------------------------------------

bar_plot(
  db = prct_plot,
  x_var = industries,
  y_var = country,
  caption = caption_NDT,
  x_title = "Number of industrial sectors in which NDT has been applied",
  limits = c(0,12),
  label = industries
)



#export(text_aws, exfile)
#exfile

ggsave(exfile,
       last_plot(),
       width = width_plot,
       height = height_plot,
       dpi = dpi_report,
       units = "cm")
