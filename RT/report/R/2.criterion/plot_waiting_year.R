cli::cli_alert_success("Plot: waiting improve")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/waiting_improve.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "waiting.rds")
exfile <- file.path(dir_plots_RT, "2.criterion/waiting_improve.png")


my_point <- function(size,
                     color,
                     year){
  
  geom_point(data = filter(w_p, year == year),
             aes(fill = year),
             size = size,
             color = color)
  
  
}

my_arrow <- function(data,
                     color){
  geom_segment(data = data,
               aes(x = `2000`,
                   xend = `2020`,
                   y = country,
                   yend = country,
               ),
               arrow = arrow(length = unit(.2,"cm"), type = "closed"),
               color = color,
               arrow.fill = color)
}


#import data -------------------------------------------------------------------

w_r <- import(infile) 



names(pat)
#prepare for plot --------------------------------------------------------------

w_p <- w_r %>%
  arrange(country, year) %>%
  filter(indicator %in% c("Less than 5 days","Between 5 and 6 days", "Between 7 and 9 days")) %>%
  group_by(country, year) %>%
  summarise(perc = sum(value, na.rm = T), .groups = 'drop') %>%
  group_by(country) %>%
  mutate(tot = case_when(year == "2020" ~ perc,
                         T ~ 0),
         dif = perc - lag(perc,1),
         dif = case_when(is.na(dif) ~ lead(dif,1),
                         T ~ dif),
         tot2 = sum(perc, na.rm = T)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, tot),
         label = paste0(perc, "%")) %>%
  filter(tot2 >0)



w_a <- w_p %>%
  select(-tot) %>%
  pivot_wider(id_cols = country,
              names_from = year,
              values_from = perc) %>%
  filter(`2020` != `2000`) %>%
  mutate(`2020` = case_when(`2000` < `2020` ~ `2020` - 2,
                            T ~ `2020` + 2),
         fill = case_when(`2000` < `2020` ~  "good",
                                   T ~ "bad")
         ) 
  
export(w_p, file.path(dir_indicators_RT, "waiting_less_10days.rds")) #export to use in contribution plot






#arrows ------------------------------------------------------------------------
wa_g <- w_a %>%
  filter(fill == "good")

wa_b <- w_a %>%
  filter(fill == "bad")





#text --------------------------------------------------------------------------

text <- w_p %>%
  filter(year == "2020")

text_p <- text %>%
  filter(dif > 0)

text_n <- text %>%
  filter(dif <= 0)




my_text <- function(data,
                    just,
                    nudge){
  
  geom_text(data = data,
            aes(label = label),
            hjust = just,
            nudge_x = nudge,
            family = font_main,
            color = blue_navy,
            size = 3)
}



  ggplot(w_p,
         aes(x = perc,
             y = country,
             color = year)
         )+
  # geom_point(aes(color = year),
  #            size = 2) +
    geom_point(data = filter(w_p, year == "2020"),
               size = 4) +
  
  
    geom_point(data = filter(w_p, year == "2000"),
               size = 2
               ) +
  my_text(data = text_p,
          just = 0,
          nudge = 3) +
    my_text(data = text_n,
            just = 1,
            nudge = -3) +
    
  my_arrow(data = wa_g,
           color = blue_sky) +
  my_arrow(data = wa_b,
           color = "grey") +
    scale_x_continuous(limits = c(0,120),
                       breaks = seq(0,120, 20),
                       labels = c(paste0(seq(0,100,20), "%"),""),
                       position = 'top'
                       ) +
    scale_color_manual(values =c(blue_light, blue_navy),
                       name = "Year") +
    
    labs(y ="",
         x =  "Proportion of patients that experienced less than 10 days to be treated",
         caption = caption_RT)+
  theme_iaea() +
  theme_bar() +
    theme(legend.position = "bottom"
          )
  
  exfile

ggsave(exfile,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)





