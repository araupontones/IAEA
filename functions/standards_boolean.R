

#'creates indicadores for the standard
#' @param criterion suffix to identify the varibales of this criterion
#' @param vars_criterion vector with name of variables that define the criterion
#' @param vars_ set of variables that define the standard of each variable

standards_boolean <- function(.data,
                              criterion,          
                              vars_criterion,
                              vars_adequate,
                              vars_good,
                              vars_excellent){
  
  .data %>%
    select("country", all_of(names(vars_criterion))) %>%
    mutate(across(all_of(names(vars_criterion)), function(x){x == "Yes"| x == TRUE})) %>%
    rowwise()%>%
    #define standards
    mutate(adequate = all({{vars_adequate}}),
           good  = all({{vars_good}}),
           excellent =  all({{vars_excellent}}),
           total =  sum(c_across(all_of(names(vars_criterion))), na.rm = T)
           
           
    ) %>%
    ungroup() %>%
    mutate(
      
      #standard ---------------------------------------------------------
   criterion= factor(case_when(
        excellent ~ "Excellent",
        good ~ "Good",
        adequate ~ "Adequate",
        T ~ "Minor"
      ),
      levels = rev(c("Minor", "Adequate", "Good", "Excellent")),
      ordered = T),
      #To fix the sorting by total
      total = case_when(criterion ==  "Excellent" ~  total + 4,
                       criterion==  "Good" ~  total + 3,
                       criterion==  "Adequate" ~  total + 2,
                       criterion==  "Minor" ~  total + 0,
                         T ~  0)
      
    ) %>%
    select(-c(excellent, good, adequate)) %>%
    rename_at(vars(all_of(names(vars_criterion))), function(x){paste0(criterion,"_",vars_criterion[x])}) %>%
    rename('{criterion}_total' := total,
           '{criterion}_standard' := criterion)
  
  
  
  
}
