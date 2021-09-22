cli::cli_alert_success("Plot: contribution tech")
cli::cli_alert_info('Saved:in {file.path(dir_text_RT, "2.criterion/contribution_tech.rds")}')

#clean main quesitonnaire
survey <- "iaea_rt"
module <- "mach"
#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)


infile <- file.path(param$dir_clean_s, "iaea_rt.rds")
exfile <- file.path(dir_text_RT, "2.criterion/contribution_tech.rds")



#import data -------------------------------------------------------------------

tech <- import(infile) %>%
  select(country, starts_with("tech__"))

techs <-c(
"3D-CRT"=1,
"IMRT"=2,
"Particle therapy" = 3,
"SRT"=4,
"3D-IGBT"=5
)



#prepare for text --------------------------------------------------------------

t_p <- tech %>%
  mutate(across(starts_with("tech"), function(x)case_when(x == 1 ~ "Yes", x == 0 ~ "No", T ~ "n/a"))) %>%
  pivot_longer(-country,
               names_to = "tech",
               values_to = "cont") %>%
  mutate(tech = as.numeric(str_remove(tech, "tech__")),
         tech = names(techs)[tech]
  )


get_countries <- function(t){
  
  d <- t_p %>%
    filter(tech == t,
           cont == "Yes") %>%
    .$country %>%
    sort %>%
    knitr::combine_words(", ")
  
  return(d)
  
  
}


imrt <- get_countries("IMRT")
crt <- get_countries("3D-CRT")


#machines -----------------------------------------------------------------------

mach <- import(infile) %>%
  select(country, mach_rca) %>%
  mutate(mach_rca = susor_get_stata_labels(mach_rca))


mach_c <- mach %>%
  filter(
         mach_rca == "Yes") %>%
  .$country %>%
  sort %>%
  knitr::combine_words(", ")



#quality -----------------------------------------------------------------------
qual <- import(infile) %>%
  select(country, qual_yn) %>%
  mutate(qual_yn = susor_get_stata_labels(qual_yn))


qual_perc <- paste0(round(mean(qual$qual_yn == "Yes",na.rm = T) *100, 1),"%")




#===============================================================================
txt <- list(
  imrt = imrt,
  crt = crt,
  mach_c = mach_c,
  qual_perc = qual_perc
)







export(txt, exfile)




