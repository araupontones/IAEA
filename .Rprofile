cli::cli_alert_success("Welcome to IAEA's Social and Economic Impact Assessment of the RCA Programme")

options("scipen"=100, digits = 2)



libraries <- c(
  
  #html
  "httr", "jsonlite", "susor",
  
  #ggplot
  "ggplot2",
  
  #maps
  "sf",
  
  #tidyverse
  "dplyr", "tidyr", "stringr",
  
  #carpintery
  "gmdacr", "lubridate", "janitor", "forcats",

  
  #other
  "rio", "glue"
  
)





#define paths -----------------------------------------------------------------
#define dropbox directory (in case different users interact with the report)
user <- Sys.getenv("USERNAME")

if(user == "andre"){
  
  dropbox <- "C:/Users/andre/Dropbox/Kate and Julian IAEA 2019"
  
}

dropbox_NDT <- file.path(dropbox, "Non destructive testing/Survey")
dropbox_RT <- file.path(dropbox, "Radiotherapy/Survey")
  
  

#directory of the repositary
dir_master <- getwd() #directory of this evaluation

#copy files from dropbox into repo (because some files are used by the team in dropbox)
#file.copy(from = file.path(dropbox, "/."), to = dir_master, recursive = T)



#define directories
ndt_dir_reference <- file.path(dropbox_NDT, "data/0.reference")
ndt_dir_indicators <- file.path(dropbox_NDT, "indicators")
ndt_dir_combobx <- file.path(dropbox_NDT, "data/1.ComboBoxes") #comboboxes of quesitionnaire
ndt_dir_ass <- file.path(dropbox_NDT, "data/2.Assignments") #Look Up questionnaires 


rt_dir_ass <- file.path(dropbox_RT, "data/2.Assignments") #Look Up questionnaires 
rt_dir_reference <- file.path(dropbox_RT, "data/0.reference")

dir_survey <- file.path(dropbox, "Survey_NDT_RT")
dir_reference <- file.path(dir_survey, "0.reference")
dir_downloads <- file.path(dir_survey, "1.downloads")
dir_raw <- file.path(dir_survey, "2.raw")
dir_clean <- file.path(dir_survey, "3.clean")
dir_docs <- file.path(dir_survey, "docs")


dir_report_NDT <- "NDT/report"
dir_plots_NDT <- file.path(dir_report_NDT, "plots")
dir_text_NDT <- file.path(dir_report_NDT, "text")
dir_indicators_NDT <- file.path(dir_report_NDT, "indicators")


################################################################################


#===============================================================================
#load packages (decide if pacman vs default pachages) -------------------------

gmdacr::check.installed(libraries)


suppressWarnings({
  options(defaultPackages=c(getOption("defaultPackages"),
                            
                            libraries
  )
  )
})



#load costumed functions
gmdacr::load_functions("functions")


