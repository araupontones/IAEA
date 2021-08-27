#create assignments of pilot

#experts_ref <- import(file.path(ndt_dir_reference, "experts.xlsx")) 
countries_ref <- import(file.path(ndt_dir_reference, "countries.xlsx")) 



#create file for assignments
experts_ass <- countries_ref %>%
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
exfile <- file.path(rt_dir_ass, "assignment_fw.tab")
write.table(experts_ass, exfile, col.names = T, row.names = F, sep = "\t", quote = FALSE)


