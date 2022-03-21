cli::cli_alert_success("Plot RCA contribution certification")
cli::cli_alert_info(glue('Saved: {file.path(dir_plots_NDT, "1.criterion/contribution_centres.pdf")}'))



#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")
exfile <- file.path(dir_plots_NDT, "1.criterion/contribution_centres.pdf")

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)



#get parameters to import and export file



#define impact vars
impact_vars <- c(
  # "cert_body_lkrt",
  # "cert_society_lkrt"
  "traincen_local_lkrt",
  "impact_inspection",
  "impact_inspinvest"
  
)


#"centres_Inspection companies (local)" 
#impact_inspection : contributed to the establishment of local centres
#impact_inspinvest : RCA NDT facilitate local investment in NDT inspection facilities
#centres_Training centres (local)
#traincen_local_lkrt " etablishment of local training centres

#read main table ---------------------------------------------------------------
main <- import(file.path(param$dir_clean_s, "iaea_ndt.rds")) %>%
  select(country, all_of(impact_vars))

#View(main)

names(cert_ind)
#create table to vis the contribution of RCA in certification -----------------
cert_ind <- import(infile) %>%
  select(country,
         training_centres = `centres_Training centres (local)`,
         inspe_centres = `centres_Inspection companies (local)`) %>%
  left_join(main, Joining, by = "country") %>%
  mutate(across(c(training_centres, inspe_centres), function(x)case_when(x ~ "Yes",
                                                                         T ~ "No")))




#pivor longer tables ==========================================================
#indicators for training centres
train <- cert_ind %>%
  #rename to be able to bind later
  select(country, 
         has = training_centres,
         likert = traincen_local_lkrt) %>%
  mutate(indicator = "Local training centres",
         #count great extent = 4, etc
         total = count_likert(likert),
         #convert to NA if country did not report
         likert = likert_to_NA(has, likert),
         invest = ""
  )





#indicators for inspection centres
inspe <- cert_ind %>%
  select(country, 
         has = inspe_centres, 
         likert = impact_inspection,
         invest = impact_inspinvest) %>%
  mutate(indicator = "Local inspection companies",
         total = count_likert(likert),
         likert = likert_to_NA(has, likert),
         invest = case_when(invest == "Yes" ~ "*",
                            T ~ "")) 

#bind and transform country to factor
both <- train %>%
  rbind(inspe) %>%
  select(-has) %>%
  group_by(country) %>%
  mutate(total = sum(total)) %>%
  ungroup() %>%
  mutate(country = fct_reorder(country, total)) %>%
  select(-total)



#View(both)

#plot ============================================================================

both %>%
  plot_contribution(x = country,
                    y = indicator,
                    fill = likert,
                    caption = caption_NDT,
                    legend = "Contribution of RCA to establish local training and inspection centres") +
  geom_text(aes(label = invest),
            color = "white",
            size = 8)+
  labs(title = '"*" indicates that RCA has facilitated the investment in local inspection centres in those GPs.') +
  theme(plot.title.position = "plot",
        plot.title = element_text(family = font_main))


#export ========================================================================
exfile

ggsave(exfile, device = cairo_pdf,
       last_plot(),
       height = height_plot - 6,
       width = width_plot,
       dpi = dpi_report)

