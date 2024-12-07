
#  
# Backend of the application
server <- function(session, input, output) {
  # stored plot into reactiveValues
  values <- reactiveValues(plot = NULL)
  
  # Reactive data
  dt <- reactive({
    req(input$dt)
    if (input$dt == "mtcars") {
      dt <- mtcars
      # converts variables: cyl, qsec, vs, am, gear, carb from numeric to character
      dt[, c(2, 8:11)] <- lapply(dt[, c(2, 8:11)], as.character)
    } else{
      dt <- iris
    }
    return(dt)
  })
  
  
  # Select Variable for plot
  output$var <- renderUI({
    req(dt())
    selectInput(
      "var_plot",
      label = "Select Variable",
      choices = names(dt()),
      multiple = FALSE
    )
  })
  
  
  # Download the plot
  output$download <- downloadHandler(
    filename = function() {
      paste("plot_", input$var_plot, '.png', sep = '')
    },
    content = function(file) {
      ggsave(file, plot = values$plot)
    }
  )
}# end of server

