cli::cli_alert_success("Plot # of inspection centres")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/inspec_centres_by_country.png")}'))


survey <- "iaea_ndt"
module <- "inspec"
#get parameters to import and export file
exfile <-file.path(dir_plots_NDT, "1.criterion/inspec_centres_by_country.png")

param <- parameters(mode = survey,
                    module = module)

# 
# main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds")) %>%
#   select(country, traincen ,traincen_local) %>%
#   mutate(traincen_foreign = traincen - traincen_local) %>%
#   mutate(traincen_foreign = NA_to_cero(traincen_foreign),
#          traincen_local = NA_to_cero(traincen_local))



#import data
inspec <- import(file.path(param$dir_clean_s, "inspection_firms.rds"))



#perare data for plot
data_plot <- inspec %>%
  ungroup() %>%
  filter(year == 2021) %>%
  select(country, inspec_local_firms, inspec_foreign_firms,inspec_firms) %>%
  mutate(country  = fct_reorder(country, inspec_firms)) %>%
  select(-inspec_firms) %>%
  pivot_longer(-country,
               names_to = "indicator") %>%
  mutate(indicator = case_when(indicator == "inspec_foreign_firms" ~ "Owned by foreign firms",
                               indicator == "inspec_local_firms" ~ "Owned by local firms",
                               T ~ ""
  )
  )



#plot
plot_stacked(data = data_plot,
             x = value,
             y = country,
             fill = indicator,
             breaks = c("Owned by local firms", "Owned by foreign firms"),
             caption = caption_NDT,
             fill_palete = c(blue_sky, blue_navy))





ggsave(exfile,
       last_plot(),
       width = width_plot,
       height = height_plot + 1,
       units = 'cm',
       dpi = dpi_report)


