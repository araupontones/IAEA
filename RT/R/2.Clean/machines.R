cli::cli_alert_success("Cleaning machines")
cli::cli_alert_info("Saved:in dropbox/Survey_NDT_RT/3.clean/iaea_rt/machines.rds")

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(param$dir_clean_s, "machines.rds")


param$file_clean
param$file_raw


#import main ------------------------------------------------------------------

raw_main <- import(file.path(param$dir_clean_s, "iaea_rt.rds")) %>% select(interview__key, country)

raw_mach <- import(param$file_raw) %>% select(-c(interview__id)) %>%
rename(year = mach__id)



#clean machines -------------------------------------------------------------------------
mach <- raw_mach %>%
  mutate(year = susor_get_stata_labels(year)) %>%
  left_join(raw_main, by = "interview__key") %>%
  select(country, year, mach_num)


# 
# View(mach)
# 
# spec_wide <- mach %>%
#   filter(indicator == "Total") %>%
#   select(method, value, year) %>%
#   group_by(method, year) %>%
#   summarise(total = sum(value,na.rm = T)) %>%
#   pivot_wider(id_cols = method,
#               values_from = "total",
#               names_from = "year") %>%
#   mutate(change = `2020` - `2000`)


#View(spec)


#export ---------------------------------------------------------------------

export(mach, exfile)


