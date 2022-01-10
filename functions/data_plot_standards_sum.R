#'returnd a dataset ready to plot the standards of the dims 
#'@param ind_vct vector with name and new name of indicators


data_plot_standards_sum <- function(.data, ind_vct){
  
  
  .data %>%
    mutate(across(ends_with("standard"), function(x)case_when(x == "Excellent" ~ 5,
                                                              x == "Good" ~ 3,
                                                              x == "Adequate" ~ 2,
                                                              x == "Minor" ~ 1,
                                                              T ~ 0))) %>%
    rowwise()%>%
    mutate(total = sum(c_across(ends_with("standard")))) %>%
    ungroup() %>%
    mutate(country = fct_reorder(country, total)) %>%
    select(-total) %>%
    pivot_longer(-country,
                 names_to = "indicator") %>%
    mutate(standard = factor(value, 
                             levels = rev(c(5,3,2,1)),
                             labels = rev(c("Excellent", "Good", "Adequate", "Minor"))
    )
    ) %>%
    mutate(indicator_label =rename_ind(indicator),
           indicator_label = factor(indicator_label,
                                    levels = rev(ind_vct),
                                    ordered = T))
  
  
}
