
cli::cli_alert_success("Plot # trained personnel")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/number_dep.png")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_plots_RT, "1.criterion/number_dep.png")



infile

#read data ====================================================================

dep <- import(infile) %>%
  select(country, dep_num) %>%
  filter(dep_num >0 & !is.na(dep_num)) %>%
  mutate(country = fct_reorder(country, dep_num),
         label = nums_to_label(dep_num))



#to define the limit
max(dep$dep_num, na.rm = T)


bar_plot(db = dep,
         x_var = dep_num,
         y_var = country,
         label = label,
         limits = c(0,1590),
         x_title = "Number Radiation Oncology (RO) Departments available",
         caption = caption_RT
         )



#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       width = width_bar_rt,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
       )
