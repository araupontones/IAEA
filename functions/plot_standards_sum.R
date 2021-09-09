#'plot standards_sum

plot_standards_sum <- function(.data,
                               pallete = c("#e7e9ea", color_inadequate, color_good, blue_navy)){
  
  .data %>%
    ggplot(aes(x = country,
               y = indicator_label,
               fill = standard))+
    geom_tile(color = "white") +
    coord_equal() +
    scale_fill_manual(values = pallete,
                      name = "Performance Standard",
                      guide = guide_legend(title.position = 'top', title.hjust = .5)) +
    scale_x_discrete(position = 'top')+
    labs(y = "",
         x = "",
         caption = caption) +
    theme_iaea() +
    theme_standards_sum()
  
  
  
}
