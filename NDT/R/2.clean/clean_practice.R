cli::cli_alert_success("Cleaning practice: productivity")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_ndt/practice.rds.rds")

survey <- "iaea_ndt"
module <- "productivity"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

exfile <- file.path(param$dir_clean_s, "practice.rds")

main_qn <- import(file.path(param$dir_clean_s, paste0(survey,".rds")))

ref_ind <- import(file.path(dir_reference, "industries_NDT.xlsx")) %>%
  rename(id = ID_industry,
         industry = Industry)



#View(main_qn)

#import rosters of inspection firms -------------------------------------------
prod_raw <- import(param$file_raw) %>%
  rename(id = productivity__id)





#View(prod)

#clean rosters and join together ----------------------------------------------
prod <- prod_raw %>%
  left_join(ref_ind, by = "id") %>%
  left_join(select(main_qn, interview__id, country), by = "interview__id")%>%
  select(country,
         industry,
         controlled_manufacturing = productivity_dim__1,
         lower_production_costs = productivity_dim__2,
         ensuring_material_quality = productivity_dim__3,
         greater_product_integrity = productivity_dim__4,
         productivity_cost) %>%
  mutate(productivity_cost = susor::susor_get_stata_labels(productivity_cost)) 

export(prod, exfile)





