#'create a database to create standard label in plots
#'@param standard variabel to get the standard from
#'


get_standard_label <- function(.data,
                               standard) {
  
  .data %>%
    tabyl(country, {{standard}}) %>%
    pivot_longer(-country,
                 names_to = "label") %>%
    filter(value >0) %>%
    mutate(name = "")
  
}