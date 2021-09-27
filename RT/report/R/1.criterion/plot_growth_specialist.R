cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/growth_specialists.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "1.criterion/growth_specialists.png")
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



# 
# View(spec2)
# 
# max(spec$Total)
# 
# spec %>%
# ggplot(aes(x = Total,
#            y = country,
#            fill = year)) +
#   geom_col(position = "dodge") +
#   geom_text(aes(label = label,
#                 color = year),
#             position = position_dodge(width =1),
#             size = 2.5,
#             hjust = 0,
#             vjust = 0.2,
#             show.legend = F) +
#   labs(y = "",
#        x = "Number of RT specialists in 2000 and 2020",
#        caption = caption_RT)+
#   scale_fill_manual(breaks = c("2000", "2020"),
#                     values = c( blue_light, blue_navy),
#                     name = "") +
#   scale_color_manual(values = c(blue_navy, blue_light)) +
#   scale_x_continuous(position = "top",
#                      label = function(x)str_replace(x, "000$", "K"),
#                      limits = c(0, 50e3)) +
#   theme_iaea() +
#   theme_stacked_bar() +
#   theme(panel.grid.minor.x = element_line(color = grid_color, linetype = "dotted"))

#=================================================================================
exfile
ggsave(exfile,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)
           