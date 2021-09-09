cli::cli_alert_success("Intro: Map respondents")
cli::cli_alert_info(glue::glue('Saved in: {file.path(dir_plots_NDT, "intro")}'))

#'map of participant countries
library(ggrepel)

#clean main quesitonnaire
survey <- "iaea_ndt"
param <- parameters(mode = survey)
filemain <- file.path(param$dir_clean_s,paste0(survey, ".dta"))
importfile <- file.path(param$dir_clean_s,paste0(survey, ".dta"))



#import main ------------------------------------------------------------------

clean_main <- import(importfile) %>%
  mutate(responded = T)

unique(clean_main$country)

world_sf <- import(file.path(dir_reference, "world_sf.rds")) %>%
  left_join(select(clean_main, c(country, responded)), by = "country") %>%
  mutate(responded = case_when(responded ~ T,
                               T ~ F))



#prepare data for chart
big.countries <- c("China", "Mongolia", "India", "Australia", "Pakistan"
)

#x_nudge <- c("Thailand")

#left.countries <- c("Singapore", "Sri Lanka", "Malaysia")

data_plot <- world_sf %>%
  mutate(name1 = country %in% big.countries ,
         name2 = !country %in% c(big.countries) & responded)
#name_X = country %in% x_nudge)





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
#   #names of big countries *to avoid overlapping -------------------------------
# stat_sf_coordinates(data = filter(data_plot, name1 ==T),
#                     geom = "text",
#                     color = "black",
#                     aes(label = country),
#                     family = "Open Sans Light",
#                     size = 2
#  )+ 
#   #points of other countries ---------------------------------------------------
# stat_sf_coordinates(
#   data = subset(data_plot, name2),
#   geom = "point",
#   size = .5
# ) +
#   #names of small countries -------------------------------------------------
# stat_sf_coordinates(data = filter(data_plot, name2 ==T),
#                     geom = "text_repel",
#                     aes(label = country),
#                     direction = c("both"),
#                     min.segment.length = 0, 
#                     box.padding = .5,
#                     family = "Open Sans Light",
#                     max.overlaps = Inf, 
#                     size = 2,
#                     segment.size = .2
#                     
# ) +
  labs(x = "",
       y = "")+
  #styles and labels ----------------------------------------------------------
scale_fill_manual(values = c("#CCCCCC", blue_navy))+
  labs(caption = "Data: online survey, 2021") +
  
  #theme -----------------------------------------------------------------------
theme(axis.text.y = element_blank()) +
#theme_iaea() 
theme_map() 

#map



#export -------------------------------------------------------------------------
exdir <- file.path(dir_plots_NDT, "intro")
if(!dir.exists(exdir)){
  
  dir.create(exdir)
}

exfile<-file.path(exdir, "map.png")

ggsave(exfile,
       map, 
       width = 13.1,
       height = 8.71,
       units = 'cm',
       dpi = 360)


