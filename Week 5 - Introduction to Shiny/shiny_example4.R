library(shiny)
library(ggplot2)

# Define UI 
ui <- fluidPage(   
  titlePanel("Shiny Scatter Plot"),   
  sidebarLayout(     
    sidebarPanel(       
      selectInput("xvar", "Choose X-axis:", choices = names(mtcars), selected = "wt"),       
      selectInput("yvar", "Choose Y-axis:", choices = names(mtcars), selected = "mpg"),
      selectInput("col", "Select plot colour", choices = rainbow(5))
    ),     
    mainPanel(       
      plotOutput("scatterPlot")     
    )   
  ) 
)  

# Define Server 
server <- function(input, output) {   
  output$scatterPlot <- renderPlot({     
    ggplot(mtcars, aes(x = !!sym(input$xvar), y = !!sym(input$yvar))) +       
      geom_point(colour = input$col, size = 3) +       
      labs(title = paste("Scatter Plot of", input$xvar, "vs", input$yvar)) +
      theme_bw()
  }) 
}  

# Run App 
shinyApp(ui = ui, server = server)