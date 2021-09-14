


count_likert <- function(likert){
  
  x = case_when(likert == "To a great extent" ~ 3,
                likert == "Little" ~ 2,
                likert == "Not at all" ~ 1,
                T ~ 0)
  
  return(x)
}


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
