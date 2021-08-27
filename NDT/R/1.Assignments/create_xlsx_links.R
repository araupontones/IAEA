
#create file to links
countries_ref <- import(file.path(ndt_dir_reference, "countries.xlsx")) 

#experts_pilot <- import(file.path(ndt_dir_reference, "experts_pilot.xlsx")) %>%
 # arrange(Country)

#experts <- experts_pilot$Expert
#experts



passwords <- import(file.path(ndt_dir_ass,"passwords.txt")) %>%
  select(assignment__link, assignment__password) %>%
  rename_all(function(x){str_remove_all(x, '.*__')}) %>%
  mutate(ID_country = as.double(str_extract(password, "(?<=A)(.*)(?=A)"))) %>%
  left_join(select(countries_ref, -Recipient)) %>%
  arrange(Country)

#assign users
#passwords$Expert <- experts

passwords %>%
  dplyr::filter(!is.na(user)) %>%
  select(- ID_country) %>%
  export(., file.path(ndt_dir_ass, "links.xlsx"))


