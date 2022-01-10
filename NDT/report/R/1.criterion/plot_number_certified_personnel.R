cli::cli_alert_success("Plot # certifield personel")
cli::cli_alert_info('Saved:in {file.path(dir_plots_NDT, "1.criterion/number_certified_personel.png")}')


survey <- "iaea_ndt"
module <- "inspec"

#get parameters to import and export file

param <- parameters(mode = survey,
                    module = module)

infile <- file.path(param$dir_clean_s, "certified_personel.rds") #created in clean
exfile <- file.path(dir_plots_NDT, "1.criterion/number_certified_personel.png")



#prepare data for plot =========================================================

cert_pers <- import(infile) |>
  filter(cert_per > 0) %>%
  mutate(cert_total_20_men = cert_total_20 - cert_total_20_women,
         across(contains("total_20"), function(x)round(x,0))) |>
  select(country, accronym, cert_total_20_men, cert_total_20_women) |>
  pivot_longer(-c(country, accronym),
               names_to = "sex") %>%
  mutate(sex = case_when(str_detect(sex, "women") ~ "Female",
                         T ~ "Male"),
         log = log(value)) %>%
  filter(value >0) %>%
  group_by(country) %>%
  mutate(tot = sum(value)) %>%
  ungroup()%>%
  mutate(country= fct_reorder(country, -tot))

max(cert_pers$tot)

  
#View(cert_pers)
#View(cert_pers)
prettyNum(3e4, big.mark = ",")
log(27000)
#plot ==========================================================================
ggplot(data = cert_pers,
       aes(
       y = accronym,
       x = log(value),
       fill = sex)
       ) +
  geom_col(width = .7) +
  facet_wrap(~country, 
             #scales = "free_x", 
             shrink = F) +
  
  #define scales -----------------------------------------------------------
  scale_fill_manual(values = c(blue, purple_bright),
                    breaks = c("Male", "Female")
                    ) +
  scale_x_continuous(breaks = c(0,15),
                     labels = c("", "30K"))+
                    #labels = function(x)floor(x)^10) +
  # scale_x_continuous(breaks = function(x) seq(from = 0,to = max(x), length.out = 2),
  #                    labels = function(x) prettyNum(round(seq(from = 0,to = max(x), length.out = 2), 0),big.mark = ",")
  #                    #z = prettyNum(y,big.mark = ",")
  #                    #z[z=="0"] <- ""
  #                    #return(z)}
  #                      #function(x) prettyNum(seq(from = 0,to = max(x), length.out = 3), big.mark = ",")
  #                    )+
 
  
  #style ---------------------------------------------------------------------
  labs(caption = caption,
       y = "NDT certifications",
       x = "Logarithmic scale (labels in original scale)",
       title = "Approximate number of Certified personnel under RCA since 2000") +
  theme_iaea() +
  theme_strip() 
  


#save =========================================================================

ggsave(exfile,
  last_plot(),
  width = width_plot,
  height = height_plot,
  dpi = dpi_report
       )
