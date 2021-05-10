#Create combo boxes for questionnaire


create_combo <- function(file){
  
  
  dimension <- str_extract(file, '[^\\/]+(?=\\.[^\\/.]*$)') #name of the reference (countries, industry, experts, etc)
  message(dimension)
  
  exfile <- file.path(ndt_dir_combobx, paste0(dimension, ".tab")) #name of file.tab 
  
  #export ID and label
  import(file) %>%
    select(1,2) %>%
    write.table(., exfile, col.names = F, row.names = F,sep = "\t")
  
  return(dimension)
  
  
}

#list of reference files in reference directory
references <- list.files(ndt_dir_reference, full.names = T)


#create tab files
purrr::map(references, create_combo)


