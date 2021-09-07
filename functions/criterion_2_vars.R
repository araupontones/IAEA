#Variables of Criterion 1

#Identify variables=============================================================
criterion_2_vars <- function(){

  
vars <- list(
#1certification
awareness_vars <- c(
  #aequate
  "awareness" = "Awareness about NDT tech.", 
  #good
  "concern" = "Interested to apply NDT tech.",
  "controlled_manufacturing" = "Better controlled manufacturing",
  #excellent
  "lower_production_costs" = "Lower production costs", 
  "ensuring_material_quality" = "Ensuring material quality",
  "greater_product_integrity" = "Greater product integrity"

)

)

names(vars) <- c("awareness_vars")

return(vars)
  
}  






