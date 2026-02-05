# Build your UI page here

source('functions.R')

ui <- fluidPage(
  ###################################################
  # Inspired by chatGPT "In R Shiny, how can we make the selectInput box bigger for multiple selections"
  # Final results came from google search and looking at tutorials.
  # url: ...
  tags$head(
    tags$style(HTML("
      .selectize-input {
        height: 100px;      /* taller box */
        width: 500px;        /* full width */
        font-size: 15px;
      }
    "))
  ),
  ################################################

  
  # Fill in your details here
  h1("Interactive Heatmap for Mouse RNA sequence data."),
  p(""),
  br(),
  column(12,
    inputPanel(
      numericInput("num_genes",
                   "Choose the number of top genes shown in the plot.",
                   value = 5,
                   min = 1,
                   max = 30),
      selectInput("mouse_samples",
                  "Select which mouse samples to include in the plot.",
                  choices = m_choices,
                  multiple = TRUE,
                  selected = m_choices)
    )
  ),
  br(),
  column(12,
    plotOutput("heatmap"),
    textOutput("test")
  )
  
  
  
  
)