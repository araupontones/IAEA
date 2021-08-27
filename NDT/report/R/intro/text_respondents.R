survey <- "iaea_ndt"
param <- parameters(mode = survey)
filemain <- file.path(param$dir_clean_s,paste0(survey, ".dta"))
importfile <- file.path(param$dir_clean_s,paste0(survey, ".dta"))

exfile <- file.path(dir_text_NDT, "intro/texto_intro.rds")

dir_text_NDT
#import data -------------------------------------------------------------------
clean_ndt <- import(importfile)
countries <- sort(clean_ndt$country)

#create text for report
countries_number <- length(countries)
countries_text <- paste0(knitr::combine_words(countries, sep = ", "),".")


respondents_info <- list(
  number = countries_number,
  names = countries_text
)


#export -----------------------------------------------------------------------
rio::export(respondents_info, exfile)

texto_intro$number
texto_intro$names

