#'bar plot

bar_plot <- function(db,
                     x_var,
                     x_title,
                     y_var,
                     label,
                     scale = "int",
                     just = -.5,
                     limits = c(0,12),
                     fill = blue_navy,
                     caption = caption){
  
  
  
  db %>%
    ggplot(aes(x = {{x_var}},
               y = {{y_var}},
               label = {{label}}
    )) +
    geom_col(fill = fill,
             width = .7) +
    geom_text(hjust = just,
              color =gray_dark,
              size = 3,
              family = font_main) +
    #xlim(c(0,12))+
    scale_x_continuous(
      limits = limits,
      #labels = function(x)prettyNum(round(x), big.mark = ","),
      labels = function(x)nums_to_label(x, scale = scale),
      position = "top"
      ) +
    labs(y = "",
         x = x_title,
         caption = caption) +
    theme_iaea() +
    theme_bar()
  
  
  
  
}
