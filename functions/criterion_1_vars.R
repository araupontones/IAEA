#Variables of Criterion 1

#Identify variables=============================================================
criterion_1_vars <- function(){

  
vars <- list(
#1certification
cert_vars <- c(
  #aequate
  "cert_schm" = "Nat. Certification scheme", 
  #good
  "cert_society" = "Established NDT Society",
  "cert_ncb" = "Established NCB",
  #excellent
  "cert_society_APPFNDT" = "NDT Society in APFNDT", 
  "cert_society_ICNDT" = "Society signatory to ICNDT",
  "cert_ncb_iso17024" = "NCB accredited ISO 17024",
  "cert_ncb_ICNDT" = "NCB registered in ICNDT"
),

centres_vars <- c(
  
  "inspect_foreign" = "Inspection companies (foreign)",
  "inspect_local" = "Inspection companies (local)",
  "traincen_foreign" = "Training centres (foreign)",
  "traincen_local" = "Training centres (local)",
  "inspec_local_abroad" = "Offers inspection abroad",
  "traincen_local_abroad" = "Offers training abroad"
  
  
)

)

names(vars) <- c("cert_vars", "centres_vars")

return(vars)
  
}  






