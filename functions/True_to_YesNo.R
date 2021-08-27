True_to_YesNo <- function(x){
  case_when(is.na(x) ~ "No",
            x ~ "Yes",
            !x ~ "No",
            T ~ "")
  
  
}