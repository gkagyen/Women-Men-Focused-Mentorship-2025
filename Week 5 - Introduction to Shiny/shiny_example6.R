library(shiny)
library(tidyverse)
library(DT)


# Define UI 
ui <- fluidPage(   
  titlePanel("Interactive Data Explorer"),   
  sidebarLayout(     
    sidebarPanel(       
      selectInput("dataset", "Choose Dataset:", 
                  choices = c("iris", "mtcars", "airquality")),       
      uiOutput("varSelect"),       
      sliderInput("filterValue", "Filter by selected variable:", 
                  min = 0, max = 100, value = c(10, 50))     
    ),     
    mainPanel(       
      DTOutput("dataTable"),       
      plotOutput("plot")     
    )   
  ) 
)  

# Define Server 
server <- function(input, output) {   
  # Reactive dataset selection   
  dataInput <- reactive({     
    if (input$dataset == "mtcars") {       
      mtcars     
    } else if (input$dataset == "iris") {       
      iris    
    } else {       
      airquality     
    }   
  })      
  
  # Update UI for variable selection   
  output$varSelect <- renderUI({     
    selectInput("var", "Choose Variable:", choices = names(dataInput()))   
  })      
  
  # Reactive filtered data   
  filteredData <- reactive({     
    df <- dataInput()     
    df <- df[df[[input$var]] >= input$filterValue[1] & df[[input$var]] <= input$filterValue[2], ]     
    df   
  })      
  
  # Render table   
  output$dataTable <- renderDT({     
    filteredData()   
  })      
  
  # Render plot   
  output$plot <- renderPlot({     
    ggplot(filteredData(), aes(x = !!sym(input$var))) +       
      geom_histogram(fill = "blue", colour = "black", bins = 10) +       
      labs(title = paste("Histogram of", input$var)) +
      theme_bw()
  }) 
}  

# Run App 
shinyApp(ui = ui, server = server)