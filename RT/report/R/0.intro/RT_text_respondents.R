cli::cli_alert_success("Intro: text")
cli::cli_alert_info(glue::glue('Saved in: {file.path(dir_text_RT, "0.intro")}'))



survey <- "iaea_rt"
param <- parameters(mode = survey)
filemain <- file.path(param$dir_clean_s,paste0(survey, ".dta"))
importfile <- file.path(param$dir_clean_s,paste0(survey, ".rds"))


exfile <- file.path(dir_text_RT, "0.intro/txt_intro.rds")

importfile
#import data -------------------------------------------------------------------
clean_RT <- import(importfile)
countries <- sort(clean_RT$country)
countries
#create text for report
countries_number <- length(countries)
countries_text <- paste0(knitr::combine_words(countries, sep = ", "),".")
countries_number

#View(clean_RT)

respondents_info <- list(
  number = countries_number,
  names = countries_text
)

exfile
#export -----------------------------------------------------------------------
rio::export(respondents_info, exfile)

# texto_intro$number
# texto_intro$names


