
to_text <- function(x){
  
  case_when(x == 1 ~ "one",
            x == 2 ~ "two",
            x == 3 ~ "three",
            x == 4 ~ "four",
            x == 5 ~ "five",
            x == 6 ~ "six",
            x == 7 ~ "seve",
            x == 8 ~ "eight",
            x == 9 ~ "nine",
            T ~ "Other"
  )
  
  
}
