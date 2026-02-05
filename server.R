# load necessary packages
# and source your functions.R file

library(shiny)
library(tidyverse)

source('functions.R')

# this function defines your server logic
server <- function(input, output){
  # you will put your interactions here
  output$heatmap <- renderPlot({
    if (is.na(input$num_genes)){
      NULL
    } else {
      make_plot(input$num_genes, input$mouse_samples)
    }
  },
  height = 600
  )
  
}
