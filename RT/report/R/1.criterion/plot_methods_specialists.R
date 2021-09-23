cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/method_specialists.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_plots_RT, "1.criterion/method_specialists.png")
infile <- file.path(param$dir_clean_s, "specialists.rds")

#View(spec)

#View(spec)

#read file --------------------------------------------------------------------
spec <- import(infile) %>%
  filter(indicator == "Certified",
         year == "2020",
         country != "China") %>%
  group_by(country) %>%
  mutate(total = sum(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total)) %>%
  group_by(method) %>%
  mutate(total = sum(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(method = fct_reorder(method, total),
         label = case_when(value >= 1000 ~ paste0(round(value/1000,1), "K"),
                           T ~ as.character(value)
         ),
         color = case_when(value >=350 ~ "white",
                           T ~ "black")
  )
  





max(spec$value, na.rm = T)

#plot -------------------------------------------------------------------------
spec %>%
  ggplot(aes(x = country,
             y = method,
             fill = value,
             label = label,
             color = color)) +
  geom_tile(color = "white") +
  geom_text(size = 2.5,
            show.legend = F)+
  scale_fill_gradient(low = "#a6ffff", high = '#132b53',
                      na.value = "#e7e9ea",
                      limits = c(0, 2e3),
                      name = "Number of RT CERTIFIED specialist by method in 2020.",
                      labels = function(x){y = str_replace(x, "000$", "K")
                      z = str_replace(y,"1500", "1.5K")
                      }
                      ) +
  scale_x_discrete(position = "top") +
  scale_color_manual(values= c("black", "white")) +
  guides(fill = guide_colorbar(title.position = "top",
                             title.hjust = .5)) +
  coord_equal() +
  labs(x = "",
       y = "",
       caption = caption_RT)+
  theme_iaea()+
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 90, hjust = 0),
        legend.key.width =  unit(2, "cm"),
        legend.key.height = unit(.4, 'cm'),
        axis.ticks = element_blank()
        #plot.background = element_blank(),
        #panel.background = element_rect(fill = "white")
        ) 


#export -----------------------------------------------------------------------


#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       height = height_plot - 2,
       width = width_plot+4,
       units = "cm",
       dpi = dpi_report
)
