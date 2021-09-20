cli::cli_alert_success("Plot RO specialists growth")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "1.criterion/growth_specialists.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_text_RT, "1.criterion/growth_specialists.rds")
infile <- file.path(param$dir_clean_s, "specialists.rds")

#View(spec)



#read file --------------------------------------------------------------------
spec <- import(infile) %>%
  filter(indicator == "Total") %>%
  #filter(!is.na(value)) %>%
  group_by(country, year) %>%
  summarise(total = sum(value, na.rm = T),.groups = 'drop')



#BY YEAR TOTAL ---------------------------------------------------------------
byear <- spec %>%
  group_by(year) %>%
  summarise(total = sum(total))


tot_0 <- byear[1,2] %>% as.numeric()
tot_20 <- byear[2,2] %>% as.numeric()
g_spec <- tot_20 - tot_0 
g_spec <- prettyNum(g_spec, big.mark = ",")
g_grow <- paste0(round((tot_20 - tot_0) / tot_0 * 100, 1),"%")


#by country --------------------------------------------------------------------

bc <- spec %>%
  group_by(country, year) %>%
  summarise(total = sum(total, na.rm = T)) %>%
  mutate(g = total - lag(total, 1),
         perc = (total - lag(total,1) ) / lag(total,1) * 100
         ) %>%
  filter(year == "2020") %>%
  ungroup()

#View(bc)

g <- bc %>%
  arrange(desc(g))


count1 <- g[1,1] %>% as.character()
count1_num <- g[1,4] %>% as.numeric() %>% prettyNum(big.mark = ",")


perc <- bc %>%
  filter(perc != Inf) %>%
  arrange(desc(perc))

grow1 <- perc[1,1] %>% as.character()

g_perc1 <- paste0(as.character(round(perc[1,5],1)), "%")

txt <- list(
  g_spec = g_spec,
  g_grow = g_grow,
  count1 = count1,
  grow1 = grow1,
  g_perc1 = g_perc1,
  count1_num = count1_num
  
)

exfile

export(txt, exfile)
