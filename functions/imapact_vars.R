#Variables of Criterion 1

#Identify variables=============================================================
impact_vars <- function(){

  
vars <- list(
#1certification
  ip_vars <- c("impact_speed" = "RCA NDT help speed up the adoption of NDT technologies since 2000", 
               "impact_speeddet" = "Years faster", 
               "impact_adopt" = "RCA NDT contribute to the adoption of NDT technologies by private businesses since 2000", 
               "impact_adoptdet" = "proportion of total activity in the NDT sector in 2020 can be attributed to the RCA NDT",
               "impact_product" = "RCA NDT programme increased the productivity of NDT inspections", 
               'impact_productdet' = "Impact on average inspection time", 
               "impact_assessment" ="Role of IAEA/RCA activities in achieving the general objectives and benefits")

)

names(vars) <- c("ip_vars")

return(vars)
  
}  






