
cli::cli_alert_success("Plot # trained personnel")
cli::cli_alert_info('Saved:in {file.path(dir_plots_RT, "1.criterion/number_trained.png")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_plots_RT, "1.criterion/number_trained.png")



infile
View(train)
#read data ====================================================================

train <- import(infile) %>%
  select(country, train_num) %>%
  mutate(country = fct_reorder(country, train_num)) %>%
  filter(!is.na(train_num))



#to define the limit
#max(train$train_num, na.rm = T)


bar_plot(db = train,
         x_var = train_num,
         y_var = country,
         label = train_num,
         limits = c(0,22),
         x_title = "Number of educational/training programmes on RT available",
         caption = caption_RT
         )



#export ========================================================================
exfile
ggsave(exfile,
       last_plot(),
       width = 12.5,
       height = 9.7,
       units = "cm",
       dpi = dpi_report
       )
