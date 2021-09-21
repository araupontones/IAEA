
cli::cli_alert_success("Plot # contribution personnel")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/contribuion_trained.png")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_plots_RT, "1.criterion/contribuion_trained.png")





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


  
#Create indicators ==============================================================
  
  

train <- cont %>% clean_likert_num(lkrt_var = train_cont,
                               var_num = train_num,
                               indicator_name = "Training Programmes")


dep <- cont %>% clean_likert_num(lkrt_var = dep_cont,
                             var_num = dep_num,
                             indicator_name = "RO Departments")


soc <-cont %>% clean_likert_num(lkrt_var = soc_cont,
                            var_num = soc_num,
                            indicator_name = "RO Societies")


#format for plot===============================================================


cont_plot <- rbind(train, dep,soc ) %>%
  group_by(country) %>%
  mutate(total = count_likert_not_established(likert),
         total = sum(total)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total),
         indicator = factor(indicator,
                            levels= rev(c("Training Programmes",
                                      "RO Departments",
                                      "RO Societies")))
  )
  


#plot ==========================================================================

cont_plot %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = likert,
                    caption = caption_RT,
                    pallete = c("white","#e7e9ea", color_inadequate, color_good, blue_navy),
                    legend = "Contribution of RCA to achieve self-reliance in RT")
  geom_text(aes(label = label),
            family = font_main)




#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       height = height_plot,
       width = width_plot+20,
       units = "cm",
       dpi = dpi_report
       )
