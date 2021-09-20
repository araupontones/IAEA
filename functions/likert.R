


count_likert <- function(likert){
  
  x = case_when(likert == "To a great extent" ~ 3,
                likert == "Little" ~ 2,
                likert == "Not at all" ~ 1,
                T ~ 0)
  
  return(x)
}

#------------------------------------------------------------------------------------
count_likert_not_established <- function(likert){
  
  x = case_when(likert == "To a great extent" ~ 5,
                likert == "Little" ~ 4,
                likert == "Not at all" ~ 3,
                likert == "Not established" ~ 2,
                
                T ~ 0)
  
  return(x)
}

#-------------------------------------------------------------------------------

likert_to_NA <- function(has,
                         likert){
  
  x = as.character(likert)
  
  y = case_when( 
    is.na(has) ~ "N/A",
    is.na(x) ~ "Has not established",
    
    
    T ~ x)
  
  z = factor(y,
             levels = rev(c("To a great extent", "Little", "Not at all", "Has not established", "N/A")))
  
  return(z)
}



clean_likert_num <- function(.data,
                             lkrt_var,
                             var_num,
                             indicator_name
){
  
  .data %>%
    select(country,
           {{var_num}}, 
           likert = {{lkrt_var}}) %>%
    mutate(indicator = indicator_name,
           likert = case_when({{var_num}} == 0 ~ "Has not established",
                              is.na({{var_num}}) ~ "N/A",
                              is.na(likert) ~ "N/A",
                              T ~ likert),
           #to factor 
           likert = factor(likert,
                           levels = rev(c("To a great extent",
                                          "Little",
                                          "Not at all",
                                          "Has not established",
                                          "N/A")))
    ) %>%
    select(-{{var_num}})
}
