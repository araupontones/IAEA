cli::cli_alert_success("Plot RT machines growth")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "2.criterion/growth_machines.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "spec2000"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


exfile <- file.path(dir_text_RT, "2.criterion/growth_machines.rds")
infile <- file.path(param$dir_clean_s, "machines.rds")

list.files(param$dir_clean_s)

#View(spec)




#read file --------------------------------------------------------------------
mach <- import(infile) %>%
  group_by(country) %>%
  mutate(g_10 = grow_fn(init = lag(mach_num,1), final = mach_num),
          g_perc10 = per_grow(init = lag(mach_num,1), final = mach_num),
         g_20 = grow_fn(init = lag(mach_num,2), final = mach_num),
         g_perc20 = per_grow(init = lag(mach_num,2), final = mach_num)
         )
 



#BY YEAR TOTAL ---------------------------------------------------------------
byear <- mach %>%
  group_by(year) %>%
  summarise(total = sum(mach_num, na.rm = T))

#View(byear)

tot_0 <- byear[1,2] %>% as.numeric()
tot_20 <- byear[3,2] %>% as.numeric()

g_mach <- tot_20 - tot_0 
g_mach <- prettyNum(g_mach, big.mark = ",")
g_grow <- paste0(round((tot_20 - tot_0) / tot_0 * 100, 1),"%")


tot_20 <- prettyNum(tot_20, big.mark = ',')
tot_0 <- prettyNum(tot_0, big.mark = ',')


#by country --------------------------------------------------------------------

bc <- mach %>%
  filter(year == "2020") %>%
  arrange(desc(mach_num))
 


count1 <- bc[1,1] %>% as.character()
count1_num <- bc[1,3] %>% as.numeric() %>% prettyNum(big.mark = ",")

count2 <- bc[2,1] %>% as.character()
count2_num <- bc[2,3] %>% as.numeric() %>% prettyNum(big.mark = ",")

count3 <- bc[3,1] %>% as.character()
count3_num <- bc[3,3] %>% as.numeric() %>% prettyNum(big.mark = ",")


#by toal growth ----------------------------------------------------------------



grow <- mach %>%
  filter(year == "2020") %>%
  arrange(desc(g_20))




grow1 <- grow[1,1] %>% as.character()
grow1_num <- grow[1,6] %>% as.numeric() %>% prettyNum(",")


#by trelative ----------------------------------------------------------------



perc <- mach %>%
  filter(year == "2020",
         g_perc20 != Inf) %>%
  arrange(desc(g_perc20)) %>%
  mutate(g_perc20 = paste0(round(g_perc20,1), "%"))




perc1 <- perc[1,1] %>% as.character()
perc1_num <- perc[1,7] %>% as.character()


perc2 <- perc[2,1] %>% as.character()
perc2_num <- perc[2,7] %>% as.character()




g_perc1 <- paste0(as.character(round(perc[1,4],1)), "%")



txt <- list(
  tot_20 = tot_20,
  tot_0 = tot_0,
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
