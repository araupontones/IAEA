#'cleans data to report completness of interviews
#'@param df_diagnostics A data frame with the interview__diagnistics
#'@param df_interviews A data of the interviews 


#function to create link
create_link <- function(id){
  
  glue::glue("http://www.pulpodata.solutions/primary/Interview/Review/{id}/")
  
}


#to clean downloads
clean_qc <- function(df_diagnostics,
                     df_interviews){
  
  interviews <- df_diagnostics %>%
    mutate(St = as.character(susor::susor_get_stata_labels(interview__status)),
           Status = case_when(St == "InterviewerAssigned" & is.na(n_questions_unanswered) ~ "Not Started",
                              St == "InterviewerAssigned" ~ "Partially completed",
                              T ~ St),
           qc_link = create_link(interview__id)) %>%
    left_join(df_interviews, by = "interview__key") %>%
    mutate(country = susor::susor_get_stata_labels(country)) %>%
    select(Country = country,
           Status,
           Duration = interview__duration,
           Unanswered = n_questions_unanswered,
           has_errors = entities__errors,
           qc_link
           
    )  %>%
    arrange(desc(Country))
  
  
  return(interviews)
  
}
