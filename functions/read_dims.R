#'to read all the indicators of the dimension

read_dims <- function(x){
  
  
  infile <- file.path(dir_indicators_NDT, glue("1.criterion/indicators_{x}.rds"))
  indi <- import(infile) %>%
    select(country, ends_with("standard"))
  return(indi)  
  
}
