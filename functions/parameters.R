#'parameters of the analysis
#' @param mode survey (iaea_ndt or iaea_rt)
#' @param module moduele of the questionnaire 


parameters <- function(mode = "iaea_ndt",
                       module = "iaea_ndt"){
  
  dir_downloads_s <- file.path(dir_downloads, mode)
  dir_raw_s <- file.path(dir_raw, mode)
  dir_clean_s <- file.path(dir_clean, mode)
  
  
  if(!dir.exists(dir_clean_s)){
    dir.create(dir_clean_s)
    
  }
  
  
  #import and exit files
  
  file_raw <- file.path(dir_raw_s,paste0(module, ".dta"))
  file_clean <- file.path(dir_clean_s,paste0(module, ".rds"))
  
  
  
  params <- list(
    dir_downloads_s = dir_downloads_s,
    dir_raw_s = dir_raw_s,
    dir_clean_s = dir_clean_s,
    
    #paths to read and export file
    file_raw = file_raw,
    file_clean = file_clean
    
  )
  
  return(params)
  
}




