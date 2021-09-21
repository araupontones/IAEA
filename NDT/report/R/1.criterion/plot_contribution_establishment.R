cli::cli_alert_success("Plot RCA contribution certification")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/contribution_RCA_cert.pmg")}'))



#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds")
exfile <- file.path(dir_plots_NDT, "1.criterion/contribution_RCA_cert.png")

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)



cent <- import(file.path(dir_clean_ndt, "iaea_ndt.rds")) %>%
  select(country, cert_schm,cert_schm_lkrt, cert_ncb,cert_body_lkrt) %>%
  mutate(cert_schm_lkrt = susor::susor_get_stata_labels(cert_schm_lkrt)) 


#pivor longer tables ==========================================================
#indicators for NCS 
scs <- cent %>%
  #rename to be able to bind later
  select(country, 
         has = cert_schm,
         likert = cert_schm_lkrt) %>%
  mutate(indicator = "Has NCS",
         #count great extent = 4, etc
         total = count_likert(likert),
         #convert to NA if country did not report
         likert = likert_to_NA(has, likert)
  )





#indicators for NCB
ncb <- cent %>%
  select(country, 
         has = cert_ncb, 
         likert = cert_body_lkrt) %>%
  mutate(indicator = "Has NCB",
         total = count_likert(likert),
         likert = likert_to_NA(has, likert)) 

#bind and transform country to factor
both <- scs %>%
  rbind(ncb) %>%
  select(-has) %>%
  group_by(country) %>%
  mutate(total = sum(total)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total)) %>%
  select(-total)




#plot ============================================================================

both %>%
plot_contribution(x = country,
                  y = indicator,
                  fill = likert,
                  caption = caption_NDT,
                  pallete = c("white", "#e7e9ea", color_inadequate, color_good, blue_navy),
                  legend = "Contribution of RCA to establish NCS or NCB")


#export ========================================================================
exfile

ggsave(exfile,
       last_plot(),
       height = height_plot - 6,
       width = width_plot,
       dpi = dpi_report)

       