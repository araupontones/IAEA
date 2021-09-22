cli::cli_alert_success("Plot: # patients")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/number_patients.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "patients.rds")
exfile <- file.path(dir_plots_RT, "2.criterion/number_patients.png")



#import data -------------------------------------------------------------------

pat <- import(infile) %>%
  filter(!is.na(pat_num))


#prepare for plot --------------------------------------------------------------

m20 <- pat %>%
  filter(year == "2020") %>%
  mutate(country = fct_reorder(country, pat_num))%>%
  mutate(label = nums_to_label(pat_num))




m10 <- pat %>%
  filter(year != "2020") %>%
  mutate(label  = "")



max(m20$pat_num, na.rm = T)



m20 %>% plot_by_year(data_prev = m10,
                     var_x = pat_num,
                     var_y = country,
                     var_label = label,
                     breaks = c("2000"),
                     pallete = c(blue_light),
                     limits = c(0,63e4),
                     x_title = "Total number of cancer patients treated using domestic RT facilities")

exfile

ggsave(exfile,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)




