library(grDevices)
library(extrafont)
library(ggplot2)
extrafont::loadfonts(dev = 'win', quiet = T)
extrafont::fonts()

#caption = "Data: IAEA's NDT online survey, 2021"
font_main <- "Calibri"
font_light <- "Calibri Light"

dpi_report <- 100

height_map <- 0
widt_map <- 0

height_plot <- 10
width_plot <- 13


width_bar_rt = 12.5
height_bar_rt = 9.7

#higer to fit countries
height_standards <- height_plot + 4
width_standards <- width_plot + 2

gmdacr::un_colors()

#colors
blue <- "#01558B" 
blue_navy <- '#183668'
blue_sky <- "#007DBC"
blue_light <- "#00AED9"
gray_dark <- "#4D4D4D" 
gray_light <- "#F2F2F2"
purple_bright <- "#E11484"
yellow <- "#FDB713"
green <- "#279B48"
green_light <- "#5DBB46"  
red <- "#EB1C2D" 


color_good <- blue_light
color_inadequate <- '#BDC2C6'
color_adequate <- '#7F99A5'

grid_color <- "#B7B7B7"




theme_iaea <- function(){
  
  theme(text = element_text(family = font_main, colour = gray_dark ),
        #axis
        axis.ticks = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.title.x.top =element_text(margin = margin(b = 10), size = 12),
        axis.title.x.bottom = element_text(margin = margin(t = 10), size = 12),
        axis.title.y = element_text(margin = margin(r = 10), size = 12),
        #background
        plot.background = element_rect(fill = 'white'),
        panel.background =  element_rect(fill = 'white'),
        
        #legend
        legend.text = element_text(size = 9),
        legend.key = element_rect(fill = NA)
        
        
        
  )
  
}


#===============================================================================

theme_stacked_bar <- function(){
  
  theme(
    axis.title.x.top =  element_text(size = 9, hjust = .5),
    panel.grid.major.x = element_line(color = grid_color, linetype = "dotted", size = .5),
    legend.position = 'bottom',
    legend.key.size = unit(.3,"cm")
  )
}




#===============================================================================
theme_map <- function(){
  
  theme(text = element_text(family = font_main),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        legend.position = 'none',
        plot.background = element_rect(fill = 'white'),
        panel.background = element_rect(fill = '#f7fafe'),
        panel.grid = element_blank()
  )
  
}

#==============================================================================

theme_strip <- function(){
  theme(
    
    panel.grid.major.x =  element_line(color = grid_color, linetype = "dotted"),
    panel.border = element_rect(colour = gray_light, fill=NA, size=.5),
    #legend
    legend.position = 'bottom',
    legend.text = element_text(size = 16),
    legend.title = element_blank(),
    legend.key.size = unit(.3,"cm"),
    #strip
    strip.text = element_text(hjust = 0, size = 16, face = "bold"),
    strip.background = element_rect(fill = gray_light),
    
    #text
    plot.title = element_text(hjust = .5, size = 16, margin = margin(b = 10)),
    plot.caption = element_text(size = 13),
    
    axis.text = element_text(size = 14),
    axis.text.x = element_text(hjust = .5),
    
  )
}


#===============================================================================
theme_standards_sum <- function(){
  
  theme(text = element_text(size = 14),
        #axis
        axis.text.x = element_text(angle = 90, hjust = 0),
        axis.text = element_text(size = 18),
        #legend
        legend.position = 'bottom',
        legend.margin = margin(t = -2, b = 10),
        legend.text = element_text(size = 18),
        legend.title = element_text(size = 16)
        #caption 
        #plot.caption = element_text(size = 14)
        
  )
  
  
}


theme_standards_rt <- function(){
  
  
  theme(plot.caption = element_text(size = 14))
}
#================================================================================
theme_bar <- function(){
  theme(panel.grid.major.x = element_line(linetype = "dotted", color = grid_color),
        panel.grid.minor.x = element_line(linetype = "dotted", color = grid_color),
        axis.title.x.bottom =  element_text(size = 9, hjust = 0),
        axis.title.x.top =  element_text(size = 9, hjust = .5),
        axis.text.y = element_text(size = 8),
        axis.text.x.top = element_text(size = 8),
        legend.key.size = unit(.3,"cm")
  )
}
