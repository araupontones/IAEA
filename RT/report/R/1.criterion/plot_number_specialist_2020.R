cli::cli_alert_success("Plot RO specialists")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/number_specialists_china.pdf")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "1.criterion/number_specialists_china.pdf")
infile <- file.path(param$dir_clean_s, "specialists.rds")



#read file --------------------------------------------------------------------
spec <- import(infile)


#prepare data for plot 
spec_plot <- spec %>%
  filter(indicator %in% c("Certified", "Uncertified", "Unknown")) %>%
  filter(!is.na(value)) %>%
  filter(year == "2020") %>%
  group_by(country) %>%
  mutate(total = sum(value)) %>%
  ungroup() %>%
  #filter(country != "China") %>%
  mutate(country = fct_reorder(country, total),
         indicator = factor(indicator,
                            levels = rev(c("Certified", "Uncertified", "Unknown")),
                            ordered = F)
  )





#View(spec_plot)


#seq(from = 0, to = 20e3, length.out = 5)

max(spec_plot$value, na.rm = T)




spec_plot %>% plot_facet_specialists()


#export ==================================================================


#=================================================================================
exfile
ggsave(exfile, device = cairo_pdf,
       last_plot(),
       width = width_bar_rt ,
       height = height_bar_rt +3,
       units = "cm",
       dpi = dpi_report
)



