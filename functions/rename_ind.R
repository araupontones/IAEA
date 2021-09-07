#'function to rename indicator
#' @param ind_vct a vector with the name and new_name

rename_ind <- function(x){
  
  i = length(ind_vct)
  y = x
  
  for(ind in 1:i){
    
    y = case_when(y == names(ind_vct)[ind] ~ ind_vct[[ind]],
                  T ~ y)
    
  }
  
  return(y)
  
}

