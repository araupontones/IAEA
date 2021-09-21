cli::cli_alert_success("Plot # of training centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/training_centres_by_country.png")}'))



survey <- "iaea_ndt"
module <- "inspec"
#get parameters to import and export file
exfile <-file.path(dir_plots_NDT, "1.criterion/training_centres_by_country.png")

param <- parameters(mode = survey,
                    module = module)

# 
main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds")) %>%
  select(country, traincen ,traincen_local) %>%
  mutate(traincen_foreign = traincen - traincen_local) %>%
  mutate(traincen_foreign = NA_to_cero(traincen_foreign),
         traincen_local = NA_to_cero(traincen_local))


#View(main)




#perare data for plot
data_plot <- main %>%
  ungroup() %>%
  mutate(country  = fct_reorder(country, traincen +10)) %>%
  select(-traincen) %>%
  pivot_longer(-country,
               names_to = "indicator") %>%
  mutate(indicator = case_when(indicator == "traincen_foreign" ~ "Owned by foreign firms",
                               indicator == "traincen_local" ~ "Owned by local firms",
                               T ~ ""
  )
  )



#plot
plot_stacked(data = data_plot,
             x = value,
             y = country,
             fill = indicator,
             caption = caption_NDT,
             breaks = c("Owned by local firms", "Owned by foreign firms"),
             fill_palete = c(blue_sky, blue_navy),
             limits = c(0,110),
             xlab = "Number of training centres")


ggsave(exfile,
       last_plot(),
       width = width_plot,
       height = height_plot + 1,
       units = 'cm',
       dpi = dpi_report)


