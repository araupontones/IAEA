cli::cli_alert_success("Plot: contribution control")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "3.criterion/contribution_control.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "iaea_rt.rds")
exfile <- file.path(dir_plots_RT, "3.criterion/contribution_control.png")




#import data -------------------------------------------------------------------

cont <- import(infile) %>%
  select(country,surv_cont, cont_cont )


c <- import(file.path(param$dir_clean_s, "control.rds")) %>%
  filter(year == "2020") %>%
  select(country, surv_num, cont_num) 





#prepare for plot ------------------------------------------------------------

c_p <- cont %>%
  select(-surv_cont) %>%
  left_join(select(c, country,cont_num), by = "country") %>%
  mutate(indicator = "Control rate") %>%
  rename(likert = cont_cont,
         value = cont_num)


l_p <- cont %>%
  select(-cont_cont)%>%
  left_join(select(c, country,surv_num), by = "country") %>%
  mutate(indicator = "Survival rate") %>%
  rename(likert = surv_cont,
         value = surv_num)



#bind 

d_p <- rbind(c_p, l_p) %>%
  #clean vars 
  mutate(likert = str_remove_all(likert, " \\(.*\\)| impact"),
         label = nums_to_label(value, "perc"),
         likert = case_when(is.na(likert) ~ " ", 
                            likert == "No" ~ "No impact",
                            T ~ likert),
         likert = factor(likert,
                         levels = c("n/a",
                                    "No impact",
                                    "Small",
                                    "Moderate",
                                    "Significant",
                                    "Large"),
                         ordered = T),
         sum = case_when(likert == "No impact" ~ 1,
                         likert == "Small" ~ 2,
                         likert == "Moderate"~3,
                         likert =="Significant"~5,
                         likert == "Large"~ 8,
                         T ~ 0)) %>%
  group_by(country) %>%
  mutate(tot = sum(sum)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, tot),
         indicator = factor(indicator,
                            levels = rev(c("Control rate", "Survival rate"))
                            ),
         color = case_when(likert %in% c("Significant", "Large") ~ "white", T ~ "black")
         )



View(d_p)


d_p %>%
  ggplot(aes(x = country,
             y = indicator, 
             fill = likert,
             label = label))+
  geom_tile(color = "white") +
  #text
  geom_text(aes(label = label,
                color = color),
            show.legend = F,
            size = 5
            ) +
  #scales
  scale_x_discrete(position = "top") +
  scale_color_manual(values = c("black", "white"))+
  scale_fill_manual(values = c("white", "#e7e9ea", color_adequate, blue_light, blue_sky, blue_navy),
                    name = 'RCA impact to increase 5-year survival and control rates between 2000 and 2020'
                    ) +
  guides(fill = guide_legend(title.position = "top",
                             title.hjust = .5))+
  labs(y = "",
       x = "",
       caption = glue('The figures within the boxes show the average 5-year control and survival rates reported by the GPs in 2020.\n\n{caption_RT}')
       )+
  #coord_equal() +
  theme_iaea() +
  theme_standards_sum() +
  theme(legend.title = element_text(color = "black")) +
  theme_standards_rt()


exfile
ggsave(exfile,
       last_plot(),
       height = height_plot +2,
       width = width_plot+20,
       units = "cm",
       dpi = dpi_report
)




