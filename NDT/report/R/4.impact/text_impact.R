cli::cli_alert_info("Indicators impact")
cli::cli_alert_success(glue::glue('saved in {file.path(dir_text_NDT, "4.impact/impact_tx.rds")}'))


exfile <- file.path(dir_text_NDT, "4.impact/impact_tx.rds")
infile <- file.path(dir_clean_ndt, "iaea_ndt.rds")

ip_vars <- impact_vars()$ip_vars



ip <- import(infile) %>%
  arrange(country) %>%
  select(country, init_year,all_of(names(ip_vars)))

#View(ipct)


speed_y <- ip$country[ip$impact_speed == "Yes"]
speed_y<- speed_y[!is.na(speed_y)]
speed_y_perc <- paste0(length(speed_y)/20 *100, "%")



ft_1 <- ip$country[ip$impact_speeddet == "1-3 years faster"]
ft_1<- ft_1[!is.na(ft_1)]

ft_2 <- ip$country[ip$impact_speeddet == "4-5 years faster"]
ft_2<- ft_2[!is.na(ft_2)]


ft_3 <- ip$country[ip$impact_speeddet == "6-10 years faster"]
ft_3<- ft_3[!is.na(ft_3)]


#have adopted
adopt <- ip$country[ip$impact_adopt == "Yes" & !is.na(ip$impact_adopt)]
adopt_n <- length(adopt)
adopt_perc <- paste0(adopt_n / 20 * 100, "%")

a_25_m_c <- ip$country[ip$impact_adoptdet == "Between 25% - 50%" & !is.na(ip$impact_adoptdet)]
a_50_m_c <- ip$country[ip$impact_adoptdet == "Between 51% - 75%" & !is.na(ip$impact_adoptdet)]

a25_n <- length(a_25_m_c)
a50_n <- length(a_50_m_c)



a_perc <- paste0((a25_n + a50_n) / adopt_n * 100, "%")
a_perc


a_perc <- (length(a_25_m_c) + length(a_50_m_c) / adopt_n)


c_25 <- knitr::combine_words(sort(a_25_m_c))
c_50 <- knitr::combine_words(sort(a_50_m_c))
c_50

cts_y1 <- knitr::combine_words(sort(ft_1))
cts_y2 <- knitr::combine_words(sort(ft_2))
cts_y3 <- knitr::combine_words(sort(ft_3))



text_impact <- list(
  speed_y_perc =speed_y_perc,
  cts_y1 = cts_y1,
  cts_y2 = cts_y2,
  cts_y3 = cts_y3,
  adopt_perc = adopt_perc,
  a_perc = a_perc,
  c_25 = c_25,
  c_50 = c_50
  
)



#exfile

export(text_impact, exfile)


