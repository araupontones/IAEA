cli::cli_alert_success("Plot: control rates")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "3.criterion/life.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "control.rds")
exfile <- file.path(dir_plots_RT, "3.criterion/life.png")



#import data -------------------------------------------------------------------

c <- import(infile) %>%
  select(-cont_num) %>%
  filter(!is.na(surv_num) & surv_num >0)


#prepare for plot --------------------------------------------------------------

m20 <- c %>%
  filter(year == "2020") %>%
  mutate(country = fct_reorder(country, surv_num))%>%
  mutate(label = nums_to_label(surv_num, scale = "perc"))

55 - 41
55-39

m10 <- c %>%
  filter(year != "2020") %>%
  mutate(label  = "")



max(m20$surv_num, na.rm = T)



m20 %>% plot_by_year(data_prev = m10,
                     var_x = surv_num,
                     var_y = country,
                     var_label = label,
                     breaks = c("2000"),
                     pallete = c(blue_light),
                     limits = c(0,75),
                     scale = "perc",
                     x_title = "Average  5-year survival rate (across all types of cancer)")




ggsave(exfile,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)




