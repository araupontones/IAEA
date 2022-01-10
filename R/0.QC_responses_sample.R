#check copleteness of the interviews
#input: downlaod data from server (created in R/download_interviews.R)
#output table with interview status by country


#deifne paths
dir_dwn_ndt <- file.path(dir_downloads,"iaea_ndt_4" )
dir_dwn_rt <- file.path(dir_downloads,"iaea_rt_5" )



#links 

links_ndt <- import(file.path(ndt_dir_ass, "Links.xlsx"))
links_rt <- import(file.path(rt_dir_ass, "Links.xlsx"))



#NDT ---------------------------------------------------------------------------

#interviews --
interviews_ndt <- import(file.path(dir_dwn_ndt, "iaea_ndt.dta")) %>%
  select(country, interview__key)


#diagnostics --
diagnostics_ndt <- import(file.path(dir_dwn_ndt, "interview__diagnostics.dta"))

#report --
interviews_ndt.1 <- clean_qc(df_diagnostics = diagnostics_ndt,
                             df_interviews = interviews_ndt)



interviews_ndt.2 <- links_ndt %>%
  left_join(interviews_ndt.1, by = "Country") %>%
  mutate(Link = "http://www.pulpodata.solutions/primary/WebInterview/ITJL4PRPSB/Start",
         Status = case_when(is.na(Status) ~ "Not Started",
                            T ~ Status)
         ) 

#rio::export(interviews_ndt.2, file.path(dir_docs, "links_ndt.xlsx"))


interviews_ndt.2 %>%
  tabyl(Status)

View(interviews_ndt.2)



#export(interviews_ndt.2, file.path(dir_docs, "survey_progress_NDT.xlsx"), overwrite = T)



##RT ----------------------------------------------------------------------------


#interviews --
interviews_rt <- import(file.path(dir_dwn_rt, "iaea_RT.dta")) %>%
  select(country, interview__key)



#diagnostics --
diagnostics_rt <- import(file.path(dir_dwn_rt, "interview__diagnostics.dta"))




#report --
interviews_rt.1 <- clean_qc(df_diagnostics = diagnostics_rt,
                             df_interviews = interviews_rt)

interviews_rt.2 <- links_rt %>%
  left_join(interviews_rt.1, by = "Country") %>%
  mutate(Link = "http://www.pulpodata.solutions/primary/WebInterview/IKKSC2LJ5X/Start",
         Status = case_when(is.na(Status) ~ "Not Started",
                            T ~ Status)
  ) 
  
interviews_rt.2 %>%
  tabyl(Status)


export(interviews_rt.2, file.path(dir_docs, "survey_progress_RT.xlsx"), overwrite = T)

















