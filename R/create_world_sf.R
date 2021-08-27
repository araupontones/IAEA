
#import data
world <- maps::map("world", fill=TRUE, plot=FALSE)
world_sf <- st_as_sf(world) %>%
  rename(country = ID)

#import reference of countries
countries_ref <- import(file.path(ndt_dir_reference, "countries.xlsx")) %>%
  select(country = Country) %>%
  mutate(iaea = TRUE)


#identify RCA countries
world_sp <- world_sf %>%
  left_join(countries_ref, by = "country") %>%
  mutate(iaea = case_when(is.na(iaea) ~ F,
                          T ~ iaea))



world_centroids <- countrt


ggplot(data = RCA_sp,
       aes(fill = iaea)) +
  geom_sf()


#export
export(world_sp, file.path(dir_reference, "world_sf.rds"))


