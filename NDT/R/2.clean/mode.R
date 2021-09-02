

mode <- "iaea_ndt"
dir_downloads_s <- file.path(dir_downloads, mode)
dir_clean_s <- file.path(dir_clean, mode)

dir_clean_s
if(!dir.exists(dir_clean_s)){
  dir.create(dir_clean_s)
  
}



