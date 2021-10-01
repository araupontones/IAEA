cli::cli_alert_success("Plot: # machines")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/number_machines.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "machines.rds")
exfile <- file.path(dir_plots_RT, "2.criterion/number_machines.png")



#import data -------------------------------------------------------------------

mach <- import(infile) %>%
  filter(!is.na(mach_num))


#prepare for plot --------------------------------------------------------------

m20 <- mach %>%
  filter(year == "2020") %>%
  mutate(country = fct_reorder(country, mach_num))%>%
  mutate(label = nums_to_label(mach_num))




m10 <- mach %>%
  filter(year != "2020") %>%
  mutate(label  = "") %>%
  filter(mach_num >0)



max(m20$mach_num, na.rm = T)



m20 %>% plot_by_year(data_prev = m10,
                     var_x = mach_num,
                     var_y = country,
                     var_label = label,
                     breaks = c("2000", "2010", "2020"),
                     pallete = c(blue_light,yellow),
                     limits = c(0,2300),
                     x_title = "Total number of operational RT equipment") 




exfile
ggsave(exfile,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)




