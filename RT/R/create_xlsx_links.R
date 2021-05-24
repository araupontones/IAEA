
#create file to links
countries_ref <- import(file.path(ndt_dir_reference, "countries.xlsx")) 



passwords <- import(file.path(rt_dir_ass,"password_pilot.txt")) %>%
   select(assignment__link, assignment__password) %>%
   rename_all(function(x){str_remove_all(x, '.*__')}) %>%
  mutate(ID_country = as.double(str_extract(password, "(?<=A)(.*)(?=A)"))) %>%
  left_join(select(countries_ref, -Recipient))

#assign users
passwords$user <- c("Aaron", "Andres", "Julian", "Kate", "Martina", rep(NA_character_, 17))

passwords %>%
  dplyr::filter(!is.na(user)) %>%
  select(- ID_country) %>%
  export(., file.path(rt_dir_ass, "links.xlsx"))


 names(passwords)