
gmdacr::load_functions("functions")
caption = "Data: IAEA's NDT online survey, 2021"

#1. download the data ==========================================================

#source("R/download_interviews.R", encoding = "UTF-8")


#2. clean the data =============================================================
dir_Rclean_NDT <- "NDT/R/2.clean"

cleaning_scripts <- list.files(dir_Rclean_NDT, full.names = T)

run_scripts(cleaning_scripts)


#3. indicatros Introduction ===================================================
dir_intro_NDT <- file.path(dir_report_NDT, "R/0.intro")

intro_scripts <- list.files(dir_intro_NDT, full.names = T)
run_scripts(cleaning_scripts)


#4. Indicators  & plotscriterion 1 =====================================================

dir_c1_NDT <- file.path(dir_report_NDT, "R/1.criterion")
message("Criterion 1")

scripts_c1_NDT <- list.files(dir_c1_NDT, full.names = T)

run_scripts(scripts_c1_NDT)


#4. Indicators  & plotscriterion 2 =====================================================

dir_c2_NDT <- file.path(dir_report_NDT, "R/2.criterion")
message("Criterion 2")

scripts_c2_NDT <- list.files(dir_c2_NDT, full.names = T)

run_scripts(scripts_c2_NDT)






# 
# 
# 
# 
# knitr::knit(file.path(dir_report_NDT, "NDT_report.Rmd"))
# 
# 
# knit