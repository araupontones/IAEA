cli::cli_alert_success("Plot: contribution tech")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/contribution_tech.png")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "iaea_rt.rds")
exfile <- file.path(dir_plots_RT, "2.criterion/contribution_tech.png")



#import data -------------------------------------------------------------------

tech <- import(infile) %>%
  select(country, starts_with("tech__"))

techs <-c(
"3D-CRT"=1,
"IMRT"=2,
"Particle therapy" = 3,
"SRT"=4,
"3D-IGBT"=5
)



#prepare for plot --------------------------------------------------------------

t_p <- tech %>%
  mutate(across(starts_with("tech"), function(x)case_when(x == 1 ~ "Yes", x == 0 ~ "No", T ~ "n/a"))) %>%
  pivot_longer(-country,
               names_to = "tech",
               values_to = "cont") %>%
  mutate(tech = as.numeric(str_remove(tech, "tech__")),
         tech = names(techs)[tech],
        count = case_when(cont =="Yes" ~ 4,
                          cont == "No" ~ 1,
                          cont == "n/a" ~ 0)) %>%
  group_by(country) %>%
  mutate(tot = sum(count)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, tot)) %>%
  group_by(tech) %>%
  mutate(tot = sum(count)) %>%
  ungroup() %>%
  mutate(tech = fct_reorder(tech, tot),
         label = case_when(cont == "n/a" ~ cont,
                           T ~ ""))



View(t_p)

t_p %>%
  ggplot(aes(x = country,
             y = tech, 
             fill = cont))+
  geom_tile(color = "white") +
  geom_text(aes(label = label),
            family = font_main,
            hjust = .5) +
  scale_x_discrete(position = "top")+
  scale_fill_manual(values = c("white", "#e7e9ea", blue_navy),
                    name = 'RCA contributed to introduce this technology'
                    )+
  guides(fill = guide_legend(title.position = "top",
                             title.hjust = .5))+
  labs(y = "",
       x = "",
       caption = caption_RT)+
  #coord_equal() +
  theme_iaea() +
  theme_standards_sum() +
  theme(legend.title = element_text(color = "black")) +
  theme_standards_rt()



exfile
ggsave(exfile,
       last_plot(),
       height = height_plot +2,
       width = width_plot+20,
       units = "cm",
       dpi = dpi_report
)




