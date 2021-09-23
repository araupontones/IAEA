
cli::cli_alert_success("Plot # contribution specialists")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/contribuion_specialists.png")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_plots_RT, "1.criterion/contribuion_specialists.png")





#read data ====================================================================

spec <- import(file.path(param$dir_clean_s, "specialists.rds")) %>%
  group_by(country) %>%
  summarise(spec_num = sum(value, na.rm = T))


#join
cont <- import(infile) %>%
  select(country, spec_cont) %>%
  left_join(spec, by = "country") %>%
mutate(country = fct_reorder(country, spec_num)) 
#filter(spec_num >0 & !is.na(spec_num))




#Create indicators ==============================================================



spec2 <- cont %>% clean_likert_num(lkrt_var = spec_cont,
                                   var_num = spec_num,
                                   indicator_name = "RT Specialists",
                                   text_not = "Doesn't have specialists")


#format for plot===============================================================


cont_plot <- spec2 %>%
  group_by(country) %>%
  mutate(total = count_likert_not_established(likert, text_not = "Doesn't have specialists"),
         total = sum(total)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total))


#plot ==========================================================================
#View(cont_plot)
cont_plot %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = likert,
                    caption = caption_RT,
                    pallete = c("white","#e7e9ea", color_inadequate, color_good, blue_navy),
                    legend = "Contribution of RCA to increase of certified RT specialists between 2000 and 2020") +
  theme_standards_rt()

# geom_text(aes(label = label),
#           family = font_main)




#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       height = height_plot -1,
       width = width_plot+20,
       units = "cm",
       dpi = dpi_report
)
