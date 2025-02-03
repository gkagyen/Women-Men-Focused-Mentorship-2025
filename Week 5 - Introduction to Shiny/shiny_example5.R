library(shiny)
library(dplyr)
library(DT)

# Define UI 
ui <- fluidPage(   
  titlePanel("Filtered Dataset Viewer"),   
  sidebarLayout(     
    sidebarPanel(       
      sliderInput("mpgFilter", "Filter by MPG:", 
                  min = min(mtcars$mpg), 
                  max = max(mtcars$mpg), 
                  value = c(15, 25))     ),     
    mainPanel(       
      DTOutput("filteredTable")     
    )   
  ) 
)  

# Define Server 
server <- function(input, output) {   
  output$filteredTable <- renderDT({    
    mtcars |>        
      filter(mpg >= input$mpgFilter[1] & mpg <= input$mpgFilter[2])   
  }) 
}  

# Run App 
shinyApp(ui = ui, server = server) 