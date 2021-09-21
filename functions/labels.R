nums_to_label <- function(x){
  
  case_when(x >= 1e3 ~ paste0(round(x/1e3,1),"K"),
            x < 1e3 ~ as.character(round(x,0)),
            T ~ "n/a"
  )
  
}

#--------------------------------------------------------------------------------

color_label <- function(likert){
  
  case_when(likert == "To a great extent" ~ "white",
            T ~ "black")
  
}