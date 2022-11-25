
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(curl)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  data("diamonds")
  
  output$distPlot <- renderPlot({
    data_input <- subset(diamonds, cut == input$cut &
                           clarity == input$clarity &
                           color == input$color)
    
    plot_output <- ggplot(data = data_input, aes(x = carat, y = price)) + geom_point()
    plot_output <- plot_output + geom_smooth(method = "lm") + xlab("Diamonds_Carat") + ylab("Diamonds_Price")
    plot_output <- plot_output + xlim(0, 6) + ylim (0, 20000)
    
    plot_output
  }, height = 800)
  
  
  
  output$predict <- renderPrint({
    data_input <- subset(diamonds, cut == input$cut &
                           clarity == input$clarity &
                           color == input$color)
    
    fit <- lm(price~carat, data = data_input)
    unname(predict(fit, data.frame(carat = input$lm)))}) 
  
  
  observeEvent(input$predict, {distPlot <<- NULL
  
  output$distPlot <- renderPlot({p <- ggplot(data = data_input, aes(x = carat, y = price)) + geom_point()
  p <- p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
  p <- p + xlim(0, 6) + ylim (0, 20000)
  p
  }, height = 800)})})
