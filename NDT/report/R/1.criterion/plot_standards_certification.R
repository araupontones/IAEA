#create chart for standards of criterion 1 certification

infile <- file.path(dir_indicators_NDT, "1.criterion/indicators_cert.rds")
exfile <- file.path(dir_plots_NDT,"1.criterion/cert_standards.png" )

indicators_cert <- import(infile)
cert_vars<-criterion_1_vars()$cert_vars

#View(indicators_cert)
#plot certification ----------------------------------------------------------
long <- indicators_cert %>%
  mutate(country = fct_reorder(country, cert_total)) %>%
  select(-matches("total")) %>%
  pivot_longer(-c(country, cert_Standard),
               names_to = "indicator") %>%
  mutate(indicator = str_remove_all(indicator,"cert_"),
         indicator = factor(indicator,
                       levels = c(cert_vars)),
         value = case_when(value ~ 1,
                           T ~ 0)
         
  )





annotate_label <- long %>% get_standard_label(standard = cert_Standard)





ggplot(data = long,
       aes(y = country,
           x =indicator
       ))+
  geom_tile(color = "white",
            aes(fill = value)) +
  xlim(c(cert_vars, "RCA Standard", "")) +
  coord_equal(ratio = .3) +
  geom_text(data = annotate_label,
            aes(x = "RCA Standard",
                y = country,
                label = label,
                color = label
            ),
            hjust = 0,
            nudge_x = -.4,
            family ="Open Sans Light",
            size = 3
            #color = gmdacr::un_colors("gray_dark")
            
  )  +
  scale_fill_gradient(low = gray_light, high = blue_navy) +
  scale_color_manual(values = c("#7F99A5", blue_navy, blue_light, '#BDC2C6'))  +
  labs(caption = "Data: IAEA's NDT online survey, 2021") +
  theme_iaea() +
  theme(axis.text.x = element_text(angle = 40, vjust = 1, hjust = 1),
        legend.position = 'none',
        axis.title = element_blank(),
  )



#export
ggsave(exfile,
       last_plot(),
       height = height_plot,
       width = width_plot, 
       units = 'cm',
       dpi = 360)

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



