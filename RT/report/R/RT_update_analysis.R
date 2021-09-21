
gmdacr::load_functions("functions")
caption = "Data: IAEA's RT online survey, 2021"

#1. download the data ==========================================================

#source("R/download_interviews.R", encoding = "UTF-8")


#2. clean the data =============================================================
dir_Rclean_RT <- "RT/R/2.clean"

cleaning_scripts <- list.files(dir_Rclean_RT, full.names = T)


run_scripts(cleaning_scripts)


#3. indicatros Introduction ===================================================
dir_intro_RT <- file.path(dir_report_RT, "R/0.intro")



intro_scripts <- list.files(dir_intro_RT, full.names = T)
run_scripts(intro_scripts)


#4. Indicators  & plotscriterion 1 =====================================================

dir_c1_RT <- file.path(dir_report_RT, "R/1.criterion")
message("Criterion 1")

scripts_c1_RT <- list.files(dir_c1_RT, full.names = T)

run_scripts(scripts_c1_RT)

 
# 5. Indicators  & plotscriterion 2 =====================================================

 dir_c2_RT <- file.path(dir_report_RT, "R/2.criterion")
 message("Criterion 2")
 
 
 scripts_c2_RT <- list.files(dir_c2_RT, full.names = T)
 
 
 run_scripts(scripts_c2_RT)
# 
# 
# #4. Indicators  & plotscriterion 3 =====================================================
# 
# dir_c3_NDT <- file.path(dir_report_NDT, "R/3.criterion")
# message("Criterion 3")
# 
# scripts_c3_NDT <- list.files(dir_c3_NDT, full.names = T)
# 
# run_scripts(scripts_c3_NDT)
# 
# 
# #5. Impact =====================================================
# 
# dir_ip_NDT <- file.path(dir_report_NDT, "R/4.impact")
# message("Impact")
# 
# scripts_ip_NDT <- list.files(dir_ip_NDT, full.names = T)
# 
# run_scripts(scripts_ip_NDT)
# 
# 
