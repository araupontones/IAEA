dir_clean_ndt
dir_clean_rt
list.files(dir_clean_rt)

to_excel <- function(dir){
  
  old <- list.files(dir, full.names = T)
  
  for(o in old){
    
    new <- str_replace(o, "rds|dta", "xlsx")
    dat <- import(o)
    export(dat, new, overwrite = T)
    message(new)

  }
  
}


to_excel(dir_clean_ndt)
to_excel(dir_clean_rt)
