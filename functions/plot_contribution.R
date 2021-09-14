plot_contribution <- function(.data,
                              x = country,
                              y = indicator,
                              fill = likert,
                              legend = "Contribution of RCA to establish NCS or NCB",
                              pallete = c("#e7e9ea", color_inadequate, color_good, blue_navy)){
  
  .data %>%
    ggplot(aes(x = {{x}},
               y = {{y}},
               fill = {{fill}})) +
    geom_tile(color = "white") +
    labs(x = "",
         y = "",
         caption = caption) +
    scale_x_discrete(position = "top") +
    scale_fill_manual(name = legend,
                      values = pallete
    ) +
    guides(fill = guide_legend(title.position = "top",
                               title.hjust = .5)) +
    theme(axis.text.x.top = element_text(angle = 90),
          legend.position = "bottom") +
    theme_iaea() +
    theme_standards_sum() +
    theme(legend.title = element_text(color = "black"))
  
  
}