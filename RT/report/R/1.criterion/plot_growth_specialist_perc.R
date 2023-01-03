cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/growth_specialists_perc.pdf")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "1.criterion/growth_specialists_perc.pdf")
infile <- file.path(param$dir_clean_s, "specialists.rds")







#prepare data for plotting
spec2 <- import(infile) %>%
  filter(indicator == "Total") %>%
  group_by(country, year) %>%
  summarise(Total = sum(value, na.rm = T)) %>%
  mutate(p_g = per_grow(lag(Total,1), Total),
         label = nums_to_label(p_g,"perc")) %>%
  ungroup() %>%
  filter(year == "2020") %>%
  filter(p_g != Inf) %>%
  mutate(country = fct_reorder(country, p_g),
         label_null = "   ")


bar_plot(db = spec2,
         x_var = p_g,
         y_var = country,
         label = label_null,
         scale = "perc",
         limits = c(-120,750),
         x_title = "Percentage change of RT specialists between 2000 and 2020",
         caption = caption_RT
)+
 geom_vline(xintercept = 0) +
geom_text(data = filter(spec2, p_g>0),
          aes(label = label),
          hjust =-0.1,
          color =gray_dark,
          size = 3,
          family = font_main) +
  geom_text(data = filter(spec2, p_g <0),
            aes(label = label),
            hjust =1.1,
            color =red,
            size = 3,
            family = font_main)


ggsave(exfile, device = cairo_pdf,
       last_plot(),
       width = width_bar_rt +2,
       height = height_bar_rt,
       units = "cm",
       dpi = dpi_report
)
           
