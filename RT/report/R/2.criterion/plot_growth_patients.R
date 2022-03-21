cli::cli_alert_success("Plot population coverage")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/population.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "2.criterion/growth_patients.pdf")
infile <- file.path(param$dir_clean_s, "iaea_rt.rds")




#prepare data for plotting
pat <- import(infile) %>%
  select(country, pat_2000, pat_2020) %>%
  mutate(grow = per_grow(pat_2000, pat_2020)) %>%
  filter(!is.na(grow), grow !=Inf) %>%
mutate(country= fct_reorder(country, grow),
         label = nums_to_label(grow, "perc"))





bar_plot(db = pat,
         x_var = grow,
         y_var = country,
         label = label,
         scale = "perc",
         just = -.2,
         limits = c(0,450),
         x_title = "(%) change of cancer patients treated using RT facilities between 2000 and 2020",
         caption = caption_RT
)
exfile
ggsave(exfile,
       last_plot(),
       device = cairo_pdf,
       width = width_bar_rt +2,
       height = height_bar_rt +2,
       units = "cm",
       dpi = dpi_report
)
