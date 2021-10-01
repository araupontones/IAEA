cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/growth_specialists.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "1.criterion/growth_specialists.png")
exfile_woChina <- file.path(dir_plots_RT, "1.criterion/growth_specialists_withoutChina.png")
infile <- file.path(param$dir_clean_s, "specialists.rds")





#read file --------------------------------------------------------------------
# spec <- import(infile) %>%
#   filter(indicator == "Total") %>%
#   #filter(!is.na(value)) %>%
#   group_by(country, year) %>%
#   summarise(Total = sum(value, na.rm = T), .groups = 'drop') %>%
#   group_by(country) %>%
#   mutate(t = sum(Total)) %>%
#   filter(t >0) %>%
#   ungroup() %>%
#   mutate(country = fct_reorder(country, t),
#          year = factor(year, 
#                        levels = rev(c("2000", "2020")),
#                        ordered = T),
#          label = case_when(year == "2020" ~ prettyNum(as.character(Total),big.mark = ","),
                      #     T ~ ""))
 


#prepare data for plotting
spec2 <- import(infile) %>%
  filter(indicator == "Total") %>%
  group_by(country, year) %>%
  summarise(Total = sum(value, na.rm = T), .groups = 'drop')



m20 <- spec2 %>%
  filter(year == "2020") %>%
  mutate(country = fct_reorder(country, Total))%>%
  mutate(label = nums_to_label(Total))




m10 <- spec2 %>%
  filter(year != "2020") %>%
  mutate(label  = "") %>%
  filter(Total > 0)



max(m20$Total)

m20 %>% plot_by_year(data_prev = m10,
                     var_x = Total,
                     var_y = country,
                     var_label = label,
                     breaks = c("2000"),
                     pallete = c(blue_light ),
                     limits = c(0,50e3),
                      x_title = "Total number of RT specialists")


ggsave(exfile,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)



#=================================================================================
m20 %>% filter(country != "China") %>%
  plot_by_year(data_prev = filter(m10,country!="China"),
               var_x = Total,
               var_y = country,
               var_label = label,
               breaks = c("2000"),
               pallete = c(blue_light ),
               limits = c(0,10e3),
               x_title = "Total number of RT specialists (without China)")

ggsave(exfile_woChina,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)
           