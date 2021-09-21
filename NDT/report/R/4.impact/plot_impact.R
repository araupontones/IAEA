cli::cli_alert_info("Indicators impact")
cli::cli_alert_success(glue::glue('saved in {file.path(dir_plots_NDT, "4.impact/plot_impact.png")}'))

dir_plots_NDT

exfile <- file.path(dir_plots_NDT, "4.impact/plot_impact.png")
infile <- file.path(dir_clean_ndt, "iaea_ndt.rds")

ip_vars <- impact_vars()$ip_vars



ipct <- import(infile) %>%
  arrange(country) %>%
  select(country,all_of(names(ip_vars))) %>%
  rename(Country = country) 
  


#separate indicators ===========================================================
speed <- ipct %>%
  select(Country,
         has = impact_speed,
         lkert = impact_speeddet) %>%
  mutate( indicator = "RCA help speed up adoption")



adopt <-  ipct %>%
  select(Country,
         has = impact_adopt,
         lkert = impact_adoptdet) %>%
  mutate( indicator = "RCA help private business adoption")

product <- ipct %>%
  select(Country,
         has = impact_product,
         lkert = impact_productdet) %>%
  mutate(indicator = "RCA increased productivity")




#bind tables and format for plotting ================== ========================
im <- rbind(speed, adopt, product) %>%
  mutate(lkert = str_remove_all(lkert,("faster|Between|Average inspection time reduced by")),
         lkert = str_trim(lkert),
         lkert = case_when(is.na(lkert) ~ "",
                           T ~ lkert),
         has = case_when(is.na(has) ~ "N/A",
                           T ~ has),
         total = case_when(has == "Yes" & lkert == "6-10 years" ~ 3,
                           has == "Yes" & lkert == "4-5 years" ~ 2.5,
                           
                          has == "Yes" ~ 2,
                           has == "No" ~ 1,
                           has == "N/A" ~ 0,
                           T ~0)) %>%
  mutate(lkert = case_when(str_detect(lkert, "6-10 years") ~ str_replace(lkert, "6-10 years", "+6yr\nfaster"),
                           str_detect(lkert, "years") ~ str_replace(lkert, "years", "yr\nfaster"),
                           #str_detect(lkert, "yrs") ~ paste0(lkert,"\nfaster"),
                           str_detect(lkert, "Up to") ~ str_replace(lkert, "Up to ", "Up to\n"),
                           str_detect(lkert, "up to") ~ str_replace(lkert, "up to ", "Up to\n"),
                           str_detect(lkert, "-") ~ str_replace(lkert, "% - ", " to\n"),
                           str_detect(lkert, "% to") ~ str_replace(lkert, "% to ", " to\n"),
                           str_detect(lkert, "more than ") ~ str_replace(lkert, "more than ", "+"),
                          
                           #str_detect(lkert, "//%") ~ str_replace(lkert, "5", "to\n"),
                          T ~ lkert)) %>%
  group_by(Country) %>%
  mutate(total = sum(total)) %>%
  ungroup() %>%
  mutate(Country = fct_reorder(Country, total)) %>%
  group_by(indicator) %>%
  mutate(total = sum(has == "Yes")) %>%
  ungroup() %>%
  mutate(indicator = fct_reorder(indicator, total))
  


im %>%tabyl(lkert)

#plot ==========================================================================
im %>%
  plot_contribution(x = Country,
                    y = indicator,
                    fill = has,
                    caption = caption_NDT,
                    pallete = c("white", color_inadequate, blue_navy),
                    legend = "Contribution of RCA in achieving general objectives") +
  geom_text(aes(label = lkert),
            family = font_main,
            color = "white",
            size = 6)




#export ========================================================================
exfile

ggsave(exfile,
       last_plot(),
       height = height_plot - 4,
       width = width_plot + 4,
       dpi = dpi_report)
