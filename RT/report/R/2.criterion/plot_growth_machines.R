cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/growth_machines.pdf")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "2.criterion/growth_machines.pdf")
infile <- file.path(param$dir_clean_s, "machines.rds")







#prepare data for plotting
mach2 <- import(infile) %>%
  filter(year %in% c("2000", "2020")) %>%
  group_by(country) %>%
  mutate(p_g = per_grow(lag(mach_num,1), mach_num),
         label = nums_to_label(p_g,"perc")) %>%
  ungroup() %>%
  filter(year == "2020") %>%
  filter(p_g != Inf) %>%
  mutate(country = fct_reorder(country, p_g),
         label_null = "   ")
View(mach2)

min(mach2$p_g)
max(mach2$p_g)

bar_plot(db = mach2,
         x_var = p_g,
         y_var = country,
         label = label,
         scale = "perc",
         just = -.2,
         limits = c(0,800),
         x_title = "Percentage change of operational RT equipment by GP between 2000 and 2020",
         caption = caption_RT
)+
 geom_vline(xintercept = 0) 
exfile
ggsave(exfile, device = cairo_pdf,
       last_plot(),
       width = width_bar_rt +2,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)
           
