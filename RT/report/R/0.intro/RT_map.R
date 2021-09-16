cli::cli_alert_success("Intro: Map respondents")
cli::cli_alert_info(glue::glue('Saved in: {file.path(dir_plots_RT, "0.intro")}'))

#'map of participant countries
library(ggrepel)

#clean main quesitonnaire
survey <- "iaea_rt"
param <- parameters(mode = survey)
filemain <- file.path(param$dir_clean_s,paste0(survey, ".dta"))
importfile <- file.path(param$dir_clean_s,paste0(survey, ".rds"))


importfile
#import main ------------------------------------------------------------------

clean_main <- import(importfile) %>%
  mutate(responded = T)

unique(clean_main$country)

world_sf <- import(file.path(dir_reference, "world_sf.rds")) %>%
  left_join(select(clean_main, c(country, responded)), by = "country") %>%
  mutate(responded = case_when(responded ~ T,
                               T ~ F))




#x_nudge <- c("Thailand")

#left.countries <- c("Singapore", "Sri Lanka", "Malaysia")

data_plot <- world_sf 





#label variables ---------------------------------------------------------------



set.seed(42)
map <- ggplot(data = data_plot,
              aes(fill = responded)
) +
  geom_sf( colour = '#E5E6EB',
           size = .05) +
  
  #map only Asia and Oceania
  coord_sf(crs = 4326, 
           xlim = c(42, 180), ylim = c(65, -58)
  ) +
  
labs(x = "",
     y = "")+
  #styles and labels ----------------------------------------------------------
scale_fill_manual(values = c("#CCCCCC", blue_navy))+
  labs(caption = caption_RT) +
  
  #theme -----------------------------------------------------------------------
theme(axis.text.y = element_blank()) +
  #theme_iaea() 
  theme_map() 

map



#export -------------------------------------------------------------------------
exdir <- file.path(dir_plots_RT, "0.intro")


exfile<-file.path(exdir, "map.png")


ggsave(exfile,
       map, 
       width = 13.1,
       height = 8.71,
       units = 'cm',
       dpi = 360)
