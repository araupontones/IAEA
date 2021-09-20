cli::cli_alert_success("Plot RO societies")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/societies.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "soc_types"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "societies.rds")
exfile <- file.path(dir_plots_RT, "1.criterion/societies.png")



soc <- import(infile) 



#prepare for plot 

soc_plot <- soc %>%
  filter(!is.na(value),
         value >0) %>%
  group_by(country) %>%
  mutate(total = sum(value)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total))

View(soc_plot)

plot_stacked (data = soc_plot ,
              x = value,
              y = country,
              fill = type,
              fill_palete= c(blue_navy,blue_sky),
              limits = c(0,40),
              xlab = "Number of Radiation Oncology (RO) Societies", 
              caption = caption_RT,
              breaks = c("Regional", "National")) 

 

#=================================================================================
exfile
ggsave(exfile,
       last_plot(),
       width = width_bar_rt,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)



