library(extrafont)
library(ggplot2)
extrafont::loadfonts(dev = 'win')

extrafont::fonts()



height_map <- 0
widt_map <- 0

height_plot <- 10
width_plot <- 13



#colors
blue <- "#01558B" 
blue_navy <- '#183668'
blue_sky <- "#007DBC"
blue_light <- "#00AED9"
gray_dark <- "#4D4D4D" 
gray_light <- "#F2F2F2"

color_inadequate <- '#BDC2C6'
color_adequate <- '#7F99A5'




theme_iaea <- function(){
  
  theme(text = element_text(family = "Open Sans Light", colour = gray_dark ),
        #axis
        axis.ticks = element_blank(),
        #background
        plot.background = element_rect(fill = 'white'),
        panel.background =  element_rect(fill = 'white')
        
        
        )
        
}


#===============================================================================
theme_map <- function(){
  
  theme(text = element_text(family = "Open Sans Light"),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        legend.position = 'none',
        plot.background = element_rect(fill = 'white'),
        panel.background = element_rect(fill = '#f7fafe'),
        panel.grid = element_blank())
  
}
