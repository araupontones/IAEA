plot_by_year <- function(.data,
                         data_prev,
                         var_x,
                         var_y = country,
                         var_label = label,
                         breaks = c("2000", "2010"),
                         pallete = c(blue_light,yellow ),
                         limits = c(0,2200),
                         x_title = "Total number of operational RT equipment",
                         scale = "int"
) {
  
  
  
  if(scale == "int"){
    
    fn_labels <- nums_to_label
    
  } else {
    
    
    fn_labels <- function(x){paste0(x,"%")}
    
  }
  
  
  .data %>%
    ggplot(aes(x = {{var_x}},
               y = {{var_y}},
               label = {{var_label}}
    )) +
    geom_col(width = .7,
             aes(fill = "2020")
    ) +
    geom_point(data = data_prev,
               aes(color = year),
               size = 1.8
    ) +
    geom_text(hjust = -.35,
              family = font_main,
              color = blue_navy,
              size = 3)+
    scale_color_manual(values = pallete,
                       name = "Year",
                       breaks = breaks
    ) +
    scale_fill_manual(values = blue_navy,
                      name = "") +
    scale_x_continuous(position = "top",
                       labels = function(x)fn_labels(x),
                       limits = limits) +
    guides(color = guide_legend(override.aes = list(size = 3) )) +
    labs(y = "",
         x = x_title,
         caption = caption_RT) +
    
    theme(legend.position = "bottom",
          legend.key = element_rect(fill = NA)
    ) +
    theme_iaea() +
    theme_bar()
  
  
}
