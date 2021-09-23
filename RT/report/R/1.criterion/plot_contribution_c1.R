
cli::cli_alert_success("Plot # contribution personnel")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/contribuion_c1.png")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_plots_RT, "1.criterion/contribuion_c1.png")





#read data ====================================================================

soc <- import(file.path(param$dir_clean_s, "societies.rds")) %>%
  group_by(country) %>%
  summarise(soc_num = sum(value, na.rm = T))

#join
cont <- import(infile) %>%
  select(country, train_num,train_cont, dep_num, dep_cont, soc_cont) %>%
  left_join(soc, by = "country")
  #mutate(country = fct_reorder(country, train_num)) 
  #filter(train_num >0 & !is.na(train_num))


  
#Create indicators (SR) ==============================================================
  
  

train <- cont %>% clean_likert_num(lkrt_var = train_cont,
                               var_num = train_num,
                               indicator_name = "Training Programmes",
                               text_not = "Doesn't have / Not established")


dep <- cont %>% clean_likert_num(lkrt_var = dep_cont,
                             var_num = dep_num,
                             indicator_name = "RO Departments",
                             text_not = "Doesn't have / Not established")


soc <-cont %>% clean_likert_num(lkrt_var = soc_cont,
                            var_num = soc_num,
                            indicator_name = "RO Societies",
                            text_not = "Doesn't have / Not established")



#Create indicators specialists ================================================



spec <- import(file.path(param$dir_clean_s, "specialists.rds")) %>%
  filter(year == "2020",
         indicator == "Total") %>%
  group_by(country) %>%
  summarise(spec_num = sum(value, na.rm = T))



#join with main questionnaire
cont_spec <- import(infile) %>%
  select(country, spec_cont) %>%
  left_join(spec, by = "country") %>%
  mutate(country = fct_reorder(country, spec_num)) 



spec2 <- cont_spec %>% clean_likert_num(lkrt_var = spec_cont,
                                   var_num = spec_num,
                                   indicator_name = "RT Specialists",
                                   text_not = "Doesn't have / Not established")


#format for plot===============================================================


cont_plot <- rbind(train, dep,soc,spec2 ) %>%
  mutate(label = nums_to_label(value),
         color = color_label(likert)) %>%
  group_by(country) %>%
  mutate(total = count_likert_not_established(likert),
         total = sum(total)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total),
         indicator = factor(indicator,
                            levels= rev(c("Training Programmes",
                                      "RO Departments",
                                      "RO Societies",
                                      "RT Specialists")))
  )
  

  



#plot ==========================================================================

cont_plot %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = likert,
                    caption = glue('The figures within the boxes show the total number reported for each dimension in 2020.\n\n{caption_RT}'),
                    pallete = c("white","#e7e9ea", color_inadequate, color_good, blue_navy),
                    legend = "Contribution of RCA to strength radiotherapy workforce") +
  geom_text(aes(label = label,
                color = color),
            family = font_main,
            show.legend = F,
            size = 5) +
  scale_color_manual(values = c("black", "white")) +
  theme_standards_rt()




#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       height = height_plot + 2,
       width = width_plot+20,
       units = "cm",
       dpi = dpi_report
       )
