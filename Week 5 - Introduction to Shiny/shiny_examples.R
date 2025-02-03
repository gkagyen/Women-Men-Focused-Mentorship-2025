library(shiny)

# Define UI 
ui <- fluidPage(
  
  # Application title
  titlePanel("Basic Shiny App"),
  
  # Sidebar with a slider input
  sidebarLayout(     
    sidebarPanel(       
      textInput("text", "Write text here", value = 'R is Shiny')     
    ),     
    mainPanel(       
      textOutput("result")    
    )   
  ) 
)  

# Define Server 
server <- function(input, output) {   
  output$result <- renderText({     
    paste("Your message is:", input$text)   
  }) 
}  

# Run App 
shinyApp(ui = ui, server = server)







        




 