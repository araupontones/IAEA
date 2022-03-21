cli::cli_alert_success("Plot population coverage")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/population.pdf")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "2.criterion/population.pdf")
infile <- file.path(param$dir_clean_s, "iaea_rt.rds")





#prepare data for plotting
pop <- import(infile) %>%
  select(country, mach_rad) %>%
  mutate(country= fct_reorder(country, mach_rad),
         label = nums_to_label(mach_rad, "perc"))
  


min(pat2$p_g)
max(pat2$p_g)

bar_plot(db = pop,
         x_var = mach_rad,
         y_var = country,
         label = label,
         scale = "perc",
         just = -.2,
         limits = c(0,111),
         x_title = "(%) of the population that lives within a radius of 100km from a RT equipment",
         caption = caption_RT
)
exfile
ggsave(exfile, device = cairo_pdf,
       last_plot(),
       width = width_bar_rt +2,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)
           
