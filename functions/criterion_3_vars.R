#Variables of Criterion 1

#Identify variables=============================================================
criterion_3_vars <- function(){

vars <- list(
#1certification
  hs_vars <- c("hs_awareness" = "More aware of benefits for safer operations", 
               "hs_applying" = "Apply NDT for safer operations", 
               "hs_injuries" = "Fewer injuries", 
               "hs_deaths" = "Fewer deaths",
               "hs_pollution" = "Reduced pollution"
               

)

)

names(vars) <- c("hs_vars")

return(vars)
  
}  







