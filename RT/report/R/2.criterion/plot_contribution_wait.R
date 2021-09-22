
cli::cli_alert_success("Plot # contribution wait")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "2.criterion/contribuion_wait.png")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_plots_RT, "2.criterion/contribuion_wait.png")


less_10 <- import(file.path(dir_indicators_RT, "waiting_less_10days.rds")) %>%
  filter(year == "2020") %>%
  select(country, label)

#View(less_10)

#read data ====================================================================

wait <- import(file.path(param$dir_clean_s, "waiting.rds"))  %>%
    arrange(country, year) %>%
    #filter(indicator %in% c("Less than 5 days","Between 5 and 6 days", "Between 7 and 9 days")) %>%
    group_by(country) %>%
    summarise(perc = max(value, na.rm = T), .groups = 'drop') %>%
    mutate(perc = case_when(country %in% c("Australia", "India", "Laos", "Myanmar", "Palau") ~ NA_real_,
                            T ~ perc))
    


#join
cont <- import(infile) %>%
  select(country, wait_cont) %>%
  left_join(wait, by = "country") 
mutate(country = fct_reorder(country, spec_num)) 
#filter(spec_num >0 & !is.na(spec_num))




#Create indicators ==============================================================



spec2 <- cont %>% clean_likert_num(lkrt_var = wait_cont,
                                   var_num = perc,
                                   indicator_name = "Waiting time\nless than 10 days",
                                   text_not = "Did not report")




#format for plot===============================================================


cont_plot <- spec2 %>%
  group_by(country) %>%
  mutate(total = count_likert_not_established(likert, text_not = "Doesn't have specialists"),
         total = sum(total)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total)) %>%
  left_join(less_10, by = "country") %>%
  mutate(label = case_when(is.na(label) ~ "n/a",
                           T ~ label),
         color = color_label(likert))



#View(cont_plot)

#plot ==========================================================================
#View(cont_plot)
cont_plot %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = likert,
                    caption = glue("*The figures within the boxes show the proportion of patients that experienced less that 10 days of waiting time in 2020.\n\n{caption_RT}"),
                    pallete = c("white", color_inadequate, color_good, blue_navy),
                    legend = "Contribution of RCA to the decrease in the average waiting time for treatment") +
geom_text(aes(label = label,
              colour = color),
           family = font_main,
          show.legend = F,
          size = 5) +
  scale_color_manual(values = rev(c("white", "black")))




#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       height = height_plot,
       width = width_plot+20,
       units = "cm",
       dpi = dpi_report
)
