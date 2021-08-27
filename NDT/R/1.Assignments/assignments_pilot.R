#experts_ref <- import(file.path(ndt_dir_reference, "experts.xlsx")) 
countries_ref <- import(file.path(ndt_dir_reference, "countries.xlsx")) 
experts_pilot <- import(file.path(ndt_dir_reference, "experts_pilot.xlsx")) 



#create file for assignments
#create file for assignments
experts_ass <- experts_pilot %>%
  select(Country)%>%
  left_join(select(countries_ref, ID_country, Country), by= c("Country")) %>%
  #dplyr::filter(pilot == "T") %>%
  select(ID_country) %>%
  #left_join(countries_ref, by=c("country"="Country")) %>%
  #select(-country) %>%
  rename(#name = ID_expert,
    country = ID_country) %>%
  mutate(`_webmode` = 1,
         `_quantity`= 1,
         `_responsible` = "andres_int",
         `_password` = paste0("A",country,"A",round(runif(nrow(.)) * 10^6, digits = 0))
  )



#export file
exfile <- file.path(ndt_dir_ass, "assignment_pilot.tab")
write.table(experts_ass, exfile, col.names = T, row.names = F, sep = "\t", quote = FALSE)

