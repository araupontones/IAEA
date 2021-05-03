#Create reference of indistries

#list of industries
industries_raw <- as.character(expression(Oil_and_gas,Power_generation_excluding_nuclear,
           Petrochemical,Chemical,Aerospace, Manufacturing,	Railway,Nuclear,Construction, Shipping))


#clean and export
industries_clean <- tibble(Industry = str_replace_all(industries_raw, "_", " ")) %>%
  mutate(Industry = str_replace(Industry, "excluding nuclear", " (excluding nuclear)")) %>%
  export(., file.path(ndt_dir_reference, "Industries.xlsx"))



  