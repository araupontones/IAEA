message("Welcome to IAEA's Social and Economic Impact Assessment of the RCA Programme")


##load libraries
library(dplyr) # for data carpinery
library(ggplot2) #to create charts and load country polygons
library(rio) #to read and export files
library(sf) #to map
library(stringr) # to manipulate strings




#define paths
#define dropbox directory (in case different users interact with the report)
user <- Sys.getenv("USERNAME")

if(user == "andre"){
  
  dropbox <- "C:/Users/andre/Dropbox/Kate and Julian IAEA 2019"
  
}

dropbox_NDT <- file.path(dropbox, "Non destructive testing/Survey")

#directory of the repositary
dir_master <- getwd() #directory of this evaluation

#copy files from dropbox into repo (because some files are used by the team in dropbox)
#file.copy(from = file.path(dropbox, "/."), to = dir_master, recursive = T)



#define directories
ndt_dir_reference <- file.path(dropbox_NDT, "data/0.reference")
ndt_dir_indicators <- file.path(dropbox_NDT, "indicators")
