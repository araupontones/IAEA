cli::cli_alert_success("Table: waiting improve")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/waiting_freq.png")}')


#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "waiting.rds")
exfile <- file.path(dir_plots_RT, "2.criterion/waiting_freq.png")



#import data -------------------------------------------------------------------

w_r <- import(infile) %>%
  filter(year == "2020") %>%
  mutate(indicator = str_replace_all(indicator,"Less than", "<"),
         indicator = str_replace_all(indicator,"10 days or more", "10+ days"),
         indicator = str_replace_all(indicator,"and", "&")) %>%
  filter(indicator != "N/A because RT treatment was not available") %>%
  mutate(indicator = factor(indicator,
                      levels = rev(c("< 5 days",
                                 "Between 5 & 6 days",
                                 "Between 7 & 9 days",
                                 "10+ days"
                                 ))),
         tot = case_when(indicator == "< 5 days" ~ value,
                         T ~ 0)) %>%
  group_by(country) %>%
  mutate(tot = sum(tot)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, tot)) %>%
    filter(!is.na(tot),
           country != "Palau") %>%
  filter(value !=0) %>%
  mutate(color = case_when(indicator =="< 5 days" ~ "white",
                           T ~ "black"),
         label = case_when(value <=3 ~ "",
                           T ~ nums_to_label(value, "perc")))
    
  dias <- c("< 5 days",
      "Between 5 & 6 days",
      "Between 7 & 9 days",
      "10+ days"
)

  color_adequate
  
  w_r %>%
    ggplot(aes(x = value,
               y = country,
               fill = indicator))+
    geom_col() +
    geom_text(aes(label = label,
                  color = color),
              position = position_stack(vjust = .5),
              show.legend = F,
              family = font_light,
              size = 2.5) +
    scale_fill_manual(name = "",
                      breaks = dias,
                      values = c(blue_navy, color_good, color_adequate, color_inadequate))+
    scale_x_continuous(labels = function(x)nums_to_label(x,"perc"),
                       position = "top")+
    scale_color_manual(values = c("black", "white")) +
    labs(y = "",
         x = "Proporiton of patients treated by waiting times in 2020",
         caption = caption_RT)+
    theme_iaea() +
    theme(legend.position = "bottom",
          legend.spacing = unit(0, 'cm'),
          legend.key.height = unit(.25, "cm"),
          legend.key.width =  unit(.25, "cm"),
          legend.text = element_text(hjust = 0),
          axis.title.x.top =  element_text(size = 9, hjust = .5)
    )
  
  exfile
#  export(w_r, exfile)

  ggsave(exfile,
         last_plot(),
         width = width_bar_rt +2 ,
         height = height_bar_rt,
         units = "cm",
         dpi = dpi_report
  )
  