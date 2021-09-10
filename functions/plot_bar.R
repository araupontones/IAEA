#'bar plot

bar_plot <- function(db,
                     x_var,
                     x_title,
                     y_var,
                     label,
                     limits = c(0,12),
                     fill = blue_navy){
  
  db %>%
    ggplot(aes(x = {{x_var}},
               y = {{y_var}},
               label = prettyNum({{label}}, big.mark = ",")
    )) +
    geom_col(fill = fill,
             width = .7) +
    geom_text(hjust = -.5,
              color =gray_dark,
              size = 3,
              family = font_main) +
    #xlim(c(0,12))+
    scale_x_continuous(
      limits = limits,
      labels = function(x)prettyNum(round(x), big.mark = ",")
      ) +
    labs(y = "",
         x = x_title,
         caption = caption) +
    theme_iaea() +
    theme_bar()
  
  
  
  
}
