# Build your UI page here

source('functions.R')

ui <- fluidPage(

  ###################################################
  # Fill in your details here
  h1("Interactive Heatmap for Mouse RNA sequence data."),
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
                  selected = m_choices,
                  width = "100%")
    )
  ),
  br(),
  column(12,
    plotOutput("heatmap")
  )
  
  
  
  
)