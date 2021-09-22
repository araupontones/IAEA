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



#import data -------------------------------------------------------------------

w_r <- import(infile) 


View(w_p)

names(pat)
#prepare for plot --------------------------------------------------------------

w_p <- w_r %>%
  arrange(country, year) %>%
  filter(indicator %in% c("Less than 5 days","Between 5 and 6 days", "Between 7 and 9 days")) %>%
  group_by(country, year) %>%
  summarise(perc = sum(value, na.rm = T), .groups = 'drop') %>%
  group_by(country) %>%
  mutate(tot = sum(perc)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, tot),
         label = paste0(perc, "%")) %>%
  filter(tot >0)

w_a <- w_p %>%
  select(-tot) %>%
  pivot_wider(id_cols = country,
              names_from = year,
              values_from = perc) %>%
  filter(`2020` != `2000`) %>%
  mutate(`2020` = case_when(`2000` < `2020` ~ `2020` - 1,
                            T ~ `2020` + 1),
         fill = case_when(`2000` < `2020` ~  "good",
                                   T ~ "bad")
         ) 
  

wa_g <- w_a %>%
  filter(fill == "good")

wa_b <- w_a %>%
  filter(fill == "bad")
View(w_p)


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
  
  my_arrow(data = wa_g,
           color = green) +
  my_arrow(data = wa_b,
           color = "grey") +
    scale_x_continuous(labels = function(x)paste0(x,"%"),
                       position = 'top') +
    
    labs(y ="",
         x =  "% of patients that experienced less than 10 days to be treated")+
  theme_iaea() +
    theme(legend.position = "bottom"
          )
  

# ggsave(exfile,
#        last_plot(),
#        width = width_bar_rt ,
#        height = height_bar_rt,
#        units = "cm",
#        dpi = dpi_report
# )



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


?arrow
arrow()
