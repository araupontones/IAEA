
#'plot standards and criterion
#'@param db data base to plot
#'@param data_label data with santadard by country



plot_standards <- function(db,
                           data_label,
                           x = indicator,
                           y = country,
                           fill = value,
                           color_fill, 
                           color_text = c('#BDC2C6',blue_navy, blue_light)) {
  
  ggplot(data = db,
         aes(y = {{y}},
             x ={{x}}
         )
  )+
    #tile ----------------------------------------------------------------------
  geom_tile(color = "white",
            aes(fill = {{fill}})
  ) +
    xlim(c(centre_vars, "RCA Standard", "")) +
    coord_equal(ratio = .3) +
    geom_text(data = data_label,
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
    scale_fill_gradient(low = gray_light, high = color_fill) +
    scale_color_manual(values = color_text)  +
    labs(caption = "Data: IAEA's NDT online survey, 2021") +
    theme_iaea() +
    theme(axis.text.x = element_text(angle = 40, vjust = 1, hjust = 1),
          legend.position = 'none',
          axis.title = element_blank(),
    )
  
  
}
