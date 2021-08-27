#'create data for plotting standards
#'@param var_total variable that identifies the number of criteria met
#'@param var_standard variable that identifies the standard of this criteria
#'@param vars_criterion vector with the variables of the criterion
#'@param prefix prefix used to identify all the variables of this criteria

long_data_standards <- function(.data,
                                var_total,
                                var_standard,
                                vars_criterion,
                                prefix){
  
  .data %>%
    mutate(country = fct_reorder(country, {{var_total}})) %>%
    select(-matches("total")) %>%
    pivot_longer(-c(country, {{var_standard}}),
                 names_to = "indicator") %>%
    mutate(indicator = str_remove_all(indicator,prefix),
           indicator = factor(indicator,
                              levels = c(vars_criterion)),
           value = case_when(value ~ 1,
                             T ~ 0)
           
    )
  
  
}