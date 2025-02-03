library(shiny)
library(dplyr)

shinyApp(
  ui = fluidPage(
    varSelectInput("variables", "Variable:", mtcars, multiple = TRUE),
    tableOutput("data")
  ),
  server = function(input, output) {
    output$data <- renderTable({
      if (length(input$variables) == 0) return(mtcars)
      mtcars |> dplyr::select(!!!input$variables)
    }, rownames = TRUE)
  }
)

