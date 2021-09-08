
cli::cli_alert_success("Plot number of industries")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "2.criterion/number_industries.rds")}'))

infile <- file.path(dir_clean_ndt, "practice.rds")
exfile <- file.path(dir_plots_NDT,"2.criterion/number_industries.png" )



#import data ------------------------------------------------------------------
prct <- import(infile)

#aws_vars <- criterion_2_vars()$awareness_vars

#View(prct)


#prepare data for plot ----------------------------------------------------------

prct_plot <- prct %>%
  group_by(country) %>%
  summarise(industries = n()) %>%
  mutate(country = fct_reorder(country, industries))




#plot ==========================================================================
prct_plot %>%
  ggplot(aes(x = industries,
             y = country,
             label = industries)
         ) +
  geom_col(fill = blue_navy,
           width = .7) +
  geom_text(hjust = -.5,
            color =gray_dark,
            size = 3) +
  #xlim(c(0,12))+
  scale_x_continuous(
    limits = c(0,12),
    labels = function(x)round(x)) +
  labs(y = "",
       x = "Number of industrial sectors in which NDT has been applied",
       caption = caption) +
  theme_iaea() +
  theme(panel.grid.major.x = element_line(linetype = "dotted", color = grid_color),
        axis.title.x.bottom =  element_text(size = 9, hjust = 0)
        )

#export(text_aws, exfile)
#exfile

ggsave(exfile,
       last_plot(),
       width = width_plot,
       height = height_plot,
       dpi = dpi_report,
       units = "cm")
