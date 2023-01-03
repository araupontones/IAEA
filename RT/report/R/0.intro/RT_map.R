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
#import main ------------------------------------------------------------------

clean_main <- import(importfile) %>%
  select(country) %>%
  mutate(responded = "Yes")



countries_RCA <- import(file.path(dir_reference, "countries.xlsx")) %>%
  select(country = Country)






shape <- world_sf <- import(file.path(dir_reference, "world_sf.rds")) %>%
  mutate(iaea = ifelse(country == "Taiwan", TRUE, iaea))



#x_nudge <- c("Thailand")

#left.countries <- c("Singapore", "Sri Lanka", "Malaysia")

data_plot <- clean_main %>% 
  right_join(countries_RCA, by = "country") %>%
  mutate(responded = case_when(responded == "Yes" ~ "Yes",
                               T ~ "No")) %>%
  right_join(shape, by = "country") %>%
  mutate(responded = case_when(!is.na(responded) ~ responded,
                               country == "Taiwan" ~ "Yes",
                               T ~ "Not RCA")) %>%
  
  
  sf::st_as_sf() 


View(data_plot)



#label variables ---------------------------------------------------------------



set.seed(42)
ggplot(data = data_plot,
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
scale_fill_manual(breaks = c("Yes", "No", "Not RCA"),
                  values = c( blue_navy, "#f1626e","#CCCCCC"),
                  name = "Participated")+
  labs(caption = "Data: online survey, 2021") +
  
  #theme -----------------------------------------------------------------------
theme(axis.text.y = element_blank()) +
  #theme_iaea() 
  theme_map() +
  theme(legend.key.height = unit(.3, 'cm'),
        legend.key.width = unit(.3, 'cm'))






#export -------------------------------------------------------------------------
exdir <- file.path(dir_plots_RT, "0.intro")


exfile<-file.path(exdir, "map.pdf")


ggsave(exfile, device = cairo_pdf,
       last_plot(), 
       width = 13.1,
       height = 8.71,
       units = 'cm',
       dpi = 360)
