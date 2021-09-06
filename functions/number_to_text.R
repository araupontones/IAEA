
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
            x == 10 ~ "ten",
            x == 11 ~ "eleven",
            x == 12 ~ "twelve",
            x == 13 ~ "thirteen",
            x == 14 ~ "fourteen",
            T ~ "Other"
  )
  
  
}
