NA_to_cero <- function(x){
  case_when(is.na(x) ~ 0,
            T ~ x)
}


NA_to_no <- function(x){
  case_when(is.na(x) ~ "No",
            T ~ x)
}
