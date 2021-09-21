
gmdacr::load_functions("functions")
caption = "Data: IAEA's NDT online survey, 2021"

#00. download the data ==========================================================

#source("R/download_interviews.R", encoding = "UTF-8")


#00. clean the data =============================================================
dir_Rclean_NDT <- "NDT/R/2.clean"

cleaning_scripts <- list.files(dir_Rclean_NDT, full.names = T)

run_scripts(cleaning_scripts)


#0 indicatros Introduction ===================================================
dir_intro_NDT <- file.path(dir_report_NDT, "R/0.intro")

intro_scripts <- list.files(dir_intro_NDT, full.names = T)
run_scripts(intro_scripts)


#1. Indicators  & plots criterion 1 =====================================================

dir_c1_NDT <- file.path(dir_report_NDT, "R/1.criterion")
message("Criterion 1")

scripts_c1_NDT <- list.files(dir_c1_NDT, full.names = T)

run_scripts(scripts_c1_NDT)


#2. Indicators  & plots criterion 2 =====================================================

dir_c2_NDT <- file.path(dir_report_NDT, "R/2.criterion")
message("Criterion 2")

scripts_c2_NDT <- list.files(dir_c2_NDT, full.names = T)

run_scripts(scripts_c2_NDT)


#3. Indicators  & plots criterion 3 =====================================================

dir_c3_NDT <- file.path(dir_report_NDT, "R/3.criterion")
message("Criterion 3")

scripts_c3_NDT <- list.files(dir_c3_NDT, full.names = T)

run_scripts(scripts_c3_NDT)


#5. Impact =====================================================

dir_ip_NDT <- file.path(dir_report_NDT, "R/4.impact")
message("Impact")

scripts_ip_NDT <- list.files(dir_ip_NDT, full.names = T)
#list.files("functions/imapact_vars.R")
source("functions/imapact_vars.R", encoding = "UTF-8")
run_scripts(scripts_ip_NDT)


