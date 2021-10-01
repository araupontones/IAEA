cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/growth_patients.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "2.criterion/growth_patients.png")
infile <- file.path(param$dir_clean_s, "patients.rds")






#prepare data for plotting
pat2 <- import(infile) %>%
  group_by(country) %>%
  mutate(p_g = per_grow(lag(pat_num,1), pat_num),
         label = nums_to_label(p_g,"perc")) %>%
  ungroup() %>%
  filter(year == "2020") %>%
  filter(p_g != Inf) %>%
  mutate(country = fct_reorder(country, p_g),
         label_null = "   ")


min(pat2$p_g)
max(pat2$p_g)

bar_plot(db = pat2,
         x_var = p_g,
         y_var = country,
         label = label,
         scale = "perc",
         just = -.2,
         limits = c(0,460),
         x_title = "(%) change of cancer patients treated using RT facilities between 2000 and 2020",
         caption = caption_RT
)+
 geom_vline(xintercept = 0) 
exfile
ggsave(exfile,
       last_plot(),
       width = width_bar_rt +2,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)
           