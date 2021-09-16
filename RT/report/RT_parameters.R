#parameters of the report

library(rio)

user <- Sys.getenv("USERNAME")




#define dropbox directory ----------------------------------------------------
if(user == "andre"){
  
  dropbox <- "C:/Users/andre/Dropbox/Kate and Julian IAEA 2019"
}


dir_data_db <- file.path(dropbox, "Survey_NDT_RT/iaea_ndt") 




#directory of the repositary -----------------------------------------------
dir_text <- "text"
dir_plots <- "plots"
dir_indicators <- "indicators"

dir_subject <- dirname(getwd()) #directory of this evaluation




#copy files from dropbox into repo (because some files are used by the team in dropbox)
#file.copy(from = file.path(dropbox, "/."), to = dir_master, recursive = T)


#define directories

#dir_reference <- file.path(dir_db_subject, "data/0.reference")
dir_indicators <- file.path(dir_subject, "indicators")
dir_docs <- file.path(dir_subject, "docs")
dir_data <- file.path(dir_subject, "data")


#load tables from dropbox
tbl_acronym <- import(file.path(dir_docs, "acronyms.xlsx")) #acronims for the report

#bl_criterion1 <- import(file.path(dir_indicators, "indicatorsNDT_v5.xlsx"), sheet = "Criterion1") #list of indicators for criterons
#tbl_criterion2 <- import(file.path(dir_indicators, "indicatorsNDT_v5.xlsx"), sheet = "Criterion2")

#set up options of kable
opts <- options(knitr.kable.NA = "")