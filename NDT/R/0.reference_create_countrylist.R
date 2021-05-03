##Create reference table of countries that will participate in the survey


#countries NDT --------------------------------------------------------------------
countries_raw <- as.character(expression(Australia, Bangladesh, 
                        Cambodia, China, Fiji, India,Indonesia, Japan, Korea, Laos, Malaysia, Mongolia,
                        Myanmar, Nepal, New_Zealand, Pakistan, Palau, Philippines, Singapore, Sri_Lanka, Thailand, Viet_Nam))


countries_clean <- tibble(Country = str_replace(countries_raw, "_", " ")) %>%
#clean names to match world map
  mutate(Country = case_when(Country == "Korea" ~ "South Korea",
                           Country == "Viet Nam" ~ "Vietnam",
                             T ~ Country))



#data from polygons -------------------------------------------------------------
worldmap <- maps::map("world", fil = T, plot = F) %>% st_as_sf() %>% rename(Country = ID)

#worldmap[str_detect(worldmap$Country, "Viet"), ]

#setdiff(countries_clean$Country, worldmap$Country)

#join data ---------------------------------------------------------------------

countries_reference <- countries_clean %>%
  left_join(worldmap) %>%
  select(-geom) %>%
  export(., file.path(ndt_dir_reference, "countries.xlsx"))
  



