plot_facet_specialists <- function(.data){
  
  .data%>%
    ggplot(aes(x = value,
               y = country,
               fill = indicator)) +
    geom_col() +
    scale_fill_manual(breaks = c("Certified", "Uncertified"),
                      values = c(blue_navy, blue_light)) +
    scale_x_continuous(limits = c(0,25e3),
                       breaks = function(x)seq(from = 0, to = 20e3, length.out = 5),
                       labels = function(x)str_replace(x, "000$", "K"),
                      position = 'top') +
    labs(y = "",
         x = "Number of RT specialist in 2020",
         caption = caption_RT) +
    facet_wrap(~method) +
    theme_iaea()+
    theme_strip() +
    theme(axis.text = element_text(size = 7),
          axis.title.x.top =  element_text(size = 9, hjust = .5),
          strip.text = element_text(hjust = 0, size = 9, face = "bold"),
          plot.caption = element_text(size = 7),
          axis.title = element_text(size = 7),
          legend.text = element_text(size = 10))
  
  
}
