# 01_simple.R
# 2 sources: slider and button

library(shiny)
ui <- bslib::page_fluid(
  sliderInput(
    'slider',
    'Slider',
    min = 1,
    max = 100,
    value = 50
  ),
  actionButton('button', 'Button'),
  textOutput('text')
)

# Every slider change, ALSO prints input$button - bad
server <- function(input, output, session) {
  output$text <- renderText({
    req(input$button >= 1)
    print(input$button) # to console
    input$slider
  })
}
shinyApp(ui, server) |> print()
