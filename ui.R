#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


data("diamonds")

# Define UI for the application
shinyUI(fluidPage(titlePanel("Diamonds"),
                  
                  # Sidebar with a slider input for number of variables
                  sidebarLayout(sidebarPanel(h2("Please choose factors."),
                                             selectInput("cut", "Cut", (sort(unique(diamonds$cut), decreasing = T))),
                                             selectInput("clarity", "Clarity", (sort(unique(diamonds$clarity), decreasing = T))),
                                             selectInput("color", "Colour", (sort(unique(diamonds$color)))),
                                             sliderInput("lm", "Carat",
                                                         min = min(diamonds$carat), max = max(diamonds$carat),
                                                         value = max(diamonds$carat) / 2, step = 0.1),
                                             h2("Predicted Price"), verbatimTextOutput("predict"), width = 4),
                                

                                mainPanel(h4("Relationship between Price & Carat"), plotOutput("distPlot"))
                  )))