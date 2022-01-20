# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library("tidyverse")
library("maps")
library("mapdata")
library("mapproj")

shinyServer(function(input, output) {
  
  observeEvent(input$burger, {
    Co2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
    d1 <- Co2_df %>%
      group_by(country) %>%
      summarise(bmean = mean(na.omit(co2))) 
    d1 <-d1[order(-d1$bmean),]
    d2<-d1[!(d1$country=="World" | d1$country=="Europe" | d1$country=="Asia" | d1$country=="North America" | d1$country=="Africa" | d1$country=="South America"),]
    highest_co2 <- na.omit(d2[which.max(d2$bmean),1]) 
    
    lowest_co2 <- na.omit(d2[which.min(d2$bmean),1])
    
    d4 <- Co2_df %>%
      group_by(country) %>%
      summarise(gmean = mean(na.omit(total_ghg))) 
    d4<-d4[!(d4$country=="World" | d4$country=="Europe" | d4$country=="Asia" | d4$country=="North America" | d4$country=="Africa" | d4$country=="South America"),]
    highest_ghg <- na.omit(d4[which.max(d4$gmean),1]) 
    
    d5 <- Co2_df %>%
      group_by(country) %>%
      summarise(gdpmean = mean(na.omit(gdp))) 
    d5<-d5[!(d5$country=="World" | d5$country=="Europe" | d5$country=="Asia" | d5$country=="North America" | d5$country=="Africa" | d5$country=="South America"),]
    highest_gdp <- na.omit(d5[which.max(d5$gdpmean),1])
    lowest_gdp <- na.omit(d5[which.min(d5$gdpmean),1])
    
    d6 <- Co2_df %>%
      group_by(year, country) %>%
      summarise(bmean = mean(na.omit(co2))) 
    d6<-d6[!(d6$country=="World" | d6$country=="Europe" | d6$country=="Asia" | d6$country=="North America" | d6$country=="Africa" | d6$country=="South America" | d6$country=="EU-28"| d6$country=="Europe (excl. EU-27)" | d6$country=="North America (excl. USA)" | d6$country=="EU-27" ),]
    })
  
  
  output$value1 <- renderText({
    paste("Answer: ", highest_co2)
  })
  output$value2 <- renderText({
    paste("Answer: ", lowest_co2)
  })
  output$value3 <- renderText({
    paste("Answer: ", highest_ghg)
  })
  output$value4 <- renderText({
    paste("Answer: ", highest_gdp)
  })
  output$value5 <- renderText({
    paste("Answer: ", lowest_gdp)
  })
  
  # Chart
  output$final_graph <- renderPlotly({
    blank_theme <- theme_bw() +
      theme(
        axis.line = element_blank(),       
        axis.text = element_blank(),        
        axis.ticks = element_blank(),     
        axis.title = element_blank(),       
        plot.background = element_blank(),  
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.border = element_blank()      
      )
    
    shape <- map_data("world")
    d6$country <- sub("United States", "USA", d6$country)
    d6$country <- sub("Democratic Republic of Congo", "Democratic Republic of the Congo", d6$country)
    shape <- shape %>%
      rename(country = region) %>%
      left_join(d6, by="country")
    
    shape <- shape %>% 
      filter(year == input$year)
    
    final_graph <- ggplot(shape) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = bmean),
        color = "white", 
        size = .1        
      ) +
      coord_quickmap() +
      scale_fill_continuous(low = "#132B43", high = "Red") +
      labs(fill = "Co2 Emission Levels") +
      ggtitle("Co2 Emissions Across the World") +
      blank_theme 
    
    return(final_graph)
    
  })
  
})