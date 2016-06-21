#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  #Buswell coefficients
  h2o<-reactive((4*input$c-input$h-2*input$o+3*input$n+2*input$s)*0.25)
  ch4<-reactive((4*input$c+input$h-2*input$o-3*input$n-2*input$s)*0.125)
  co2<-reactive((4*input$c-input$h+2*input$o+3*input$n+2*input$s)*0.125)
  nh3=reactive(input$n)
  h2s=reactive(input$s )  
#  output$formula<-renderText({paste("C",[.(input$c)],"H",[.(input$h)],"O",[.(input$o)],"N",[.(input$n)],"S",[.(input$s)],sep="")})
  output$formulaPlot <- renderPlot({
  plot(c(0,1), c(0,1), type = 'n', ann = FALSE, xaxt = 'n', yaxt = 'n')
  text(0.2, 0.6, cex = 1.5, bquote(paste('C'[.(input$c)],'H'[.(input$h)],'O'[.(input$o)],'N'[.(input$n)],'S'[.(input$s)],sep="")))
    
 
  })
  
})
