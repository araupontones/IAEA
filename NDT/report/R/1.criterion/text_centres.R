infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_centres.rds")
exfile <- file.path(dir_text_NDT,"1.criterion/centre_text.rds" )



centres <- import(infile)


countries_excellent <- centres$country[centres$centres_standard == "Excellent"]
countries_inadequate <- centres$country[centres$centres_standard == "Inadequate"]




countries_inadequate <- countries_inadequate[countries_inadequate != "Laos"]


count_excellent_num <- length(countries_excellent)
count_excellent_text <- knitr::combine_words(countries_excellent, sep = ", ")


inadequate_num <- to_text(length(countries_inadequate))
inadequate_num <- str_to_title(inadequate_num)
inadequate_text <- knitr::combine_words(countries_inadequate, sep = ", ")





list_texto <- list(
  
  excellent_num = count_excellent_num,
  excellent_text = count_excellent_text,
  inadequate_num = inadequate_num,
  inadequate_text =inadequate_text
  
)




export(list_texto,exfile)


