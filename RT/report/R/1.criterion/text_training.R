
cli::cli_alert_success("Plot # trained personnel")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "1.criterion/txt_train.rds")}')


survey <- "iaea_rt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "iaea_rt.rds") #created in clean
exfile <- file.path(dir_text_RT, "1.criterion/txt_train.rds")





#read data ====================================================================

train <- import(infile) %>%
  select(country, train_num, dep_num)
  

#View(train)
#text ========================================================================

#training programmes ----------------------------------
tot_train <- sum(train$train_num, na.rm = T) 

train0 <- sort(train$country[train$train_num <=0 | is.na(train$train_num)]) %>% knitr::combine_words()
trainNA <- sort(train$country[is.na(train$train_num)])

# departments ------------------------------------------------------------------
tot_dep <- sum(train$dep_num, na.rm = T)
dep_china <- train$dep_num[train$country == "China"]
dep_china_per <- paste0(round(dep_china/tot_dep *100,1),"%")

dep_japan <- train$dep_num[train$country == "Japan"]
dep_japan_per <- paste0(round(dep_japan/tot_dep *100,1),"%")

dep_india <- train$dep_num[train$country == "India"]
dep_india_per <- paste0(round(dep_india/tot_dep *100,1),"%")



tot_dep <- prettyNum(tot_dep, big.mark = ",")

dep_india_per


#to define the limit
#max(train$train_num, na.rm = T)


#create list ==================================================================

txt <- list(
  
  tot_train = tot_train,
  train0 = train0,
  tot_dep = tot_dep,
  dep_china_per = dep_china_per,
  dep_japan_per = dep_japan_per,
  dep_india_per, dep_india_per
)



#export ========================================================================
exfile
export(txt, exfile)
