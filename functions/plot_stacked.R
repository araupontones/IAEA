#'plot stacked

plot_stacked <- function(data = data_plot,
                         x,
                         y,
                         fill,
                         fill_palete= c(blue_sky, blue_navy),
                         limits = c(0,900),
                         xlab = "Number of inspection centres",
                         caption = caption,
                         breaks){
  
  #plot -------------------------------------------------------------------------
  ggplot(data = data,
         aes(x = {{x}},
             y = {{y}},
             fill = {{fill}})
  )+
    geom_col(width = .6) +
    #labs ---------------------------------------
  labs(y = "",
       x = xlab,
       caption = caption
  ) +
    #styles ----------------------------------------------------------------------
  scale_x_continuous(expand = c(0,0),
                     position = 'top',
                     limits = limits
  ) +
    scale_fill_manual(values = fill_palete,
                      name = "",
                      breaks = breaks) +
    #theme -----------------------------------------------------------------------
  theme_iaea() +
    theme_stacked_bar()
  
  
}
