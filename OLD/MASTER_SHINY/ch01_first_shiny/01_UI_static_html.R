library(shiny)
ui <- fluidPage(
    "Hello, world!",
    br(),
    shiny::a(href="www.nytimes.com", "link to paper" ),
    br(),
    shiny::a(href="www.nytimes.com", "link to paper2" ),

)
server <- function(input, output, session) {
}
shinyApp(ui, server)
