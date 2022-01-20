#    http://shiny.rstudio.com/

library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyverse)

shinyUI(fluidPage(
  navbarPage("Climate Change",
             
             tabPanel("Introductory Page",
                      titlePanel("Introduction"),
                      p("Climate change continues to be a pressing issue around the globe that has differential impacts on individuals based on where they live and their financial status. While climate change takes its course in our society, there are only some people willing to take action in researching how to adapt to and prevent some of its consequences. This being said, many fail to realize that there is a pattern among the most affected regions. This pattern being countries with lower economic standings, and less powerful governments being hit the hardest. Vulnerable. That is exactly what these poor countries are, and it's important to understand that they are in need of help. There are five relevant values of interest whithin the CO2 metrics data base collected by Our World Data. These values being:", style = "font-family: 'times'; font-size:18px"),
                      tags$ul(
                        tags$li("What country does the highest average annual production-based emissions of carbon dioxide (CO2), measured in million tonnes belong to?", style = "font-family: 'times'; font-size:18px", textOutput("value1")), 
                        tags$li("What country does the highest average annual production-based emissions of carbon dioxide (CO2), measured in million tonnes belong to?", style = "font-family: 'times'; font-size:18px", textOutput("value2")), 
                        tags$li("What country does the highest average total greenhouse gas emission including land use change and forestry, measured in million tonnes of carbon dioxide-equivalents belong to?", style = "font-family: 'times'; font-size:18px", textOutput("value3")),
                        tags$li("What country has the highest average GDP?", style = "font-family: 'times'; font-size:18px", textOutput("value4")),
                        tags$li("What country has the lowest average GDP?", style = "font-family: 'times'; font-size:18px", textOutput("value5"))
                      ),
                      p("With these values it seems interesting that the country with the highest annual Co2 production also has the highest average greenhouse gas emission, and also the highest GDP. Furthermore, the country with the lowest GDP is the 14th lowest country in terms of average Co2 emission annualy. All this, yet the poorest countries get the butt end of the stick while generating the least amount of issues.", style = "font-family: 'times'; font-size:18px")),
                      
             tabPanel("Visual Showcase",
                      titlePanel("Interactive World Map"),
                      sidebarLayout(
                        
                        sidebarPanel(
                          sliderInput(
                            inputId = "year",
                            label = "Choose year",
                            min = 1960,
                            max = 2020,
                            value = 2000,
                            sep = "")),
                        
                        mainPanel(
                          p("The interactive map below shows the average annual production-based emissions of carbon dioxide (CO2), measured in million tonnes. You're able to use the widget on the left to scrub through years ranging from 1960 to 2020. Obviously, some countries recorded their emissions at different times, so countries may pop up further along the timeline. This world map clearly visualizes the hotspots when it comes to Co2 emissions.", style = "font-family: 'times'; font-size:16px"),
                          plotlyOutput("final_graph"))
                      ))
             
  )))
