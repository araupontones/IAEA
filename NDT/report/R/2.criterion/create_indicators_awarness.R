cli::cli_alert_success("indicators awareness")
cli::cli_alert_info(glue('Saved: {file.path(dir_indicators_NDT, "2.criterion/awareness.rds")}'))

#clean main quesitonnaire
survey <- "iaea_ndt"
module <- "inspection_firms"
exfile <- file.path(dir_indicators_NDT, "2.criterion/awareness.rds")


#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


#inspection <- import(param$file_clean)
main_qn <- import(file.path(param$dir_clean_s, paste0(survey, ".rds"))) %>%
  select(country, awareness, concern) %>%
  mutate(awareness = awareness == "Yes",
         concern = concern != "Not at all")



#practice
practice <- import(file.path(param$dir_clean_s, "practice.rds")) %>%
  select(-c(industry, productivity_cost)) %>%
  group_by(country) %>%
  summarise_all(max) %>%
  mutate(across(where(is.numeric), function(x) case_when(x == 1 ~ TRUE,
                                                         T ~ FALSE))) 




#join main and practice
joint <- main_qn %>%
  left_join(practice, by = "country") %>%
  mutate(across(where(is.logical), function(x)case_when(is.na(x) ~ F,
                                                        T ~x))
  )




#crete standards ===============================================================
vars_criterion <- criterion_2_vars()$awareness_vars


standards_aws <- joint %>%
  rowwise() %>%
  mutate(adequate = any(awareness,concern),
         good  = all(awareness,concern),
         excellent =  all(c(controlled_manufacturing, lower_production_costs, ensuring_material_quality, greater_product_integrity), na.rm = T),
         total =sum(c_across(all_of(names(vars_criterion))), na.rm = T)) %>%
  
  ungroup() %>%
  mutate(
    
    #CORRECT JAPAN BECAUSE MEETS EXCELLENT BUT NOT GOOD 
    good = case_when(country == "Japan" ~ TRUE,
                          T ~ good),
    #standard ---------------------------------------------------------
    criterion= factor(case_when(
      excellent ~ "Excellent",
      good ~ "Good",
      adequate ~ "Adequate",
      T ~ "Inadequate"
    ),
    levels = rev(c("Inadequate", "Adequate", "Good", "Excellent")),
    ordered = T),
    
    
    #To fix the sorting by total
    total = case_when(criterion ==  "Excellent" ~  total + 4,
                      criterion==  "Good" ~  total + 3,
                      criterion==  "Adequate" ~  total + 2,
                      criterion==  "Inadequate" ~  total + 0,
                      T ~  0)
    
  ) %>%
  select(-c(excellent, good, adequate)) %>%
  rename_at(vars(all_of(names(vars_criterion))), function(x){paste0("aws_",vars_criterion[x])}) %>%
  rename(aws_total = total,
         aws_standard = criterion)
         

#View(standards_aws)

#View(ind_centres)

export(standards_aws, exfile)


#adequate
#GPs have training centres owned by foreign entities: traincen - train_local > 0 
#nd inspection companies owned by foreign entities, from inspection firms

#adequate = c(inspect_foreign, traincen_foreign)

#good 
#have local NDT training centres and inspection companies offering services to local industry. (local exists)
#good = c(inspect_local,traincen_local)

#excellent 
#excellent c(inspec_local_aborad, traincen_local_aborad)
#offering training and inspection activities to local industries as well as abroad. inspec_local_abroad traincen_local_abroad


