cli::cli_alert_success("Plot, RCA contribution to RD")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/contribution_rd.png")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
infile <-file.path(dir_clean_ndt, "iaea_ndt.rds")
exfile <- file.path(dir_plots_NDT, "2.criterion/contribution_rd.png")






#read data =====================================================================
rd_cont <- import(infile) %>%
  select(country,
         has = rd_act,
         likert = rd_acttrain) %>%
  mutate(has = susor::susor_get_stata_labels(has),
         likert = case_when(country %in% c("Australia", 
                                           "New Zealand")
                            ~ "Not at all",
                            country == "Indonesia" ~ "Little",
                            T ~ as.character(likert)),
         total = count_likert(likert),
         total = case_when(has == "Yes" & total == 0 ~ 1,
                           is.na(has) ~ -1,
                           T ~ total),
         #convert to NA if country did not report
         
         likert = likert_to_NA(has, likert),
         country = fct_reorder(country, total),
         label = case_when(likert == "N/A" ~ "N/A",
                           T ~ ""),
         indicator = "Established R&D NDT activities") %>%
  select(-total, - has) 




#plot ==========================================================================


rd_cont %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = likert,
                    pallete = c("white","#e7e9ea", color_inadequate, color_good, blue_navy),
                    legend = "Contribution of RCA to enable or promote the initiation of R&D ") +
  geom_text(aes(label = label),
            family = font_main)




#export===========================================================================

#export ========================================================================
exfile

ggsave(exfile,
       last_plot(),
       height = height_plot - 6.5,
       width = width_plot,
       dpi = dpi_report)
