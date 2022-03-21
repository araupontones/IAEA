#create chart for standards of criterion 1 certification

infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds")
exfile <- file.path(dir_plots_NDT,"1.criterion/cert_standards.pdf" )

indicators_cert <- import(infile)
cert_vars<-criterion_1_vars()$cert_vars



#View(indicators_cert)
#plot certification ----------------------------------------------------------
long <- indicators_cert %>%
  filter(!country %in% support_countries) %>%
  mutate(country = fct_reorder(country, cert_total)) %>%
  select(-matches("total")) %>%
  pivot_longer(-c(country, cert_standard),
               names_to = "indicator") %>%
  mutate(indicator = str_remove_all(indicator,"cert_"),
         indicator = factor(indicator,
                       levels = c(cert_vars)),
         value = case_when(value ~ 1,
                           T ~ 0)
         
  ) %>%
  mutate(p = value)





annotate_label <- long %>% get_standard_label(standard = cert_standard)

color_inadequate <- '#BDC2C6'
color_adequate <- '#7F99A5'



plot_standards(db = long,
               x = indicator,
               y = country,
               x_title = "Evaluation Criteria MRA",
               vars_dimension = cert_vars,
               caption = caption,
               fill = p,
               data_label = annotate_label,
               color_fill = blue_navy,
               color_text = c("#7F99A5", blue_navy, blue_light, '#BDC2C6'))



ggsave(exfile, device = cairo_pdf,
       last_plot(),
       height = height_standards,
       width = width_standards, 
       units = 'cm',
       dpi = dpi_report)

#adequate:---------------------------

## National certification scheme has been established
## cert_schm

#good ------------------------------
## NDT Society has been established: cert_society 

## National certification body on NDT has been established: cert_ncb
## The society is a signatory to ICNDT MRA: cert_society_ICNDT
## NCB for NDT accredited to ISO 17024: cert_ncb_iso17024
##NCB accepted for registration under the ICNDT: cert_ncb_ICNDT




# excellent------------------
##NDT Society is registered with APFNDT: cert_society_APPFNDT

## register: cert_ncb_ICNDT, cert_society_APPFNDT
## signatory: cert_society_ICNDT
## acredited: cert_ncb_iso17024
#accepted under: cert_ncb_ICNDT



