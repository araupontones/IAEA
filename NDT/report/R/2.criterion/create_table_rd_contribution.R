cli::cli_alert_success("Table, RCA contribution to RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "2.criterion/contribution_rd.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
infile <-file.path(dir_clean_ndt, "iaea_ndt.rds")
exfile <- file.path(dir_indicators_NDT, "2.criterion/contribution_rd.rds")



#read data =====================================================================
rd_cont <- import(infile) %>%
  select(country,rd_act,rd_publications,rd_seminars,rd_acttrain) %>%
  mutate(rd_act = susor::susor_get_stata_labels(rd_act),
         across(c(rd_publications, rd_seminars), function(x)x*20)) %>%
  arrange(country) %>%
  rename(Country = country,
        `Has established any R&D activities related to NDT` = rd_act,
        `Publications related to NDT since 2000` = rd_publications,
        `Seminars related to NDT organized since 2000` = rd_seminars,
        `Extent to which the RCA NDT enabled or promoted the initiation of R&D activities` = rd_acttrain
        
         )







#export===========================================================================

export(rd_cont, exfile)
