cli::cli_alert_success("Plot RT patients growth")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "2.criterion/growth_patients.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_text_RT, "2.criterion/growth_patients.rds")
infile <- file.path(param$dir_clean_s, "patients.rds")

list.files(param$dir_clean_s)

#View(spec)




#read file --------------------------------------------------------------------
pat <- import(infile) %>%
  group_by(country) %>%
  mutate(g_10 = grow_fn(init = lag(pat_num,1), final = pat_num),
          g_perc10 = per_grow(init = lag(pat_num,1), final = pat_num)
         )
 


#BY YEAR TOTAL ---------------------------------------------------------------
byear <- pat %>%
  group_by(year) %>%
  summarise(total = sum(pat_num, na.rm = T))

#View(byear)

tot_0 <- byear[1,2] %>% as.numeric()
tot_20 <- byear[2,2] %>% as.numeric()

g_pat <- tot_20 - tot_0 
g_pat <- prettyNum(g_pat, big.mark = ",")
g_grow <- paste0(round((tot_20 - tot_0) / tot_0 * 100, 1),"%")

tot_20 <- prettyNum(tot_20, big.mark = ',')
tot_0 <- prettyNum(tot_0, big.mark = ',')


#by country --------------------------------------------------------------------

bc <- pat %>%
  filter(year == "2020") %>%
  arrange(desc(pat_num))
 


count1 <- bc[1,1] %>% as.character()
count1_num <- bc[1,3] %>% as.numeric() %>% prettyNum(big.mark = ",")

count2 <- bc[2,1] %>% as.character()
count2_num <- bc[2,3] %>% as.numeric() %>% prettyNum(big.mark = ",")

count3 <- bc[3,1] %>% as.character()
count3_num <- bc[3,3] %>% as.numeric() %>% prettyNum(big.mark = ",")



#by toal growth ----------------------------------------------------------------



grow <- pat %>%
  filter(year == "2020") %>%
  arrange(desc(g_10))




grow1 <- grow[1,1] %>% as.character()
grow1_num <- grow[1,4] %>% as.numeric() %>% prettyNum(",")

#by trelative ----------------------------------------------------------------



perc <- pat %>%
  filter(year == "2020",
         g_perc10 != Inf) %>%
  arrange(desc(g_perc10)) %>%
  mutate(g_perc10 = paste0(round(g_perc10,1), "%"))




perc1 <- perc[1,1] %>% as.character()
perc1_num <- perc[1,5] %>% as.character()


perc2 <- perc[2,1] %>% as.character()
perc2_num <- perc[2,5] %>% as.character()




txt <- list(
  tot_20 = tot_20,
  tot_0 = tot_0,
  g_pat = g_pat,
  g_grow = g_grow,
  count1 = count1,
  count1_num = count1_num,
  count2 = count2,
  count2_num = count2_num,
  count3 = count3,
  count3_num = count3_num,
  grow1_num = grow1_num,
  grow1 = grow1,
  perc1 = perc1,
  perc1_num = perc1_num
  
 )

exfile

export(txt, exfile)
