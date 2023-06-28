library(shiny)
library(tibble)


dt  <- tribble(
        ~shop, ~yelp_link, ~comments,
        "shop1", "<nytimes.com>", "my cooments",
        "shop2", "<nytimes.com>", "my cooments"
               )


ui <- fluidPage(
tableOutput("static"),
#  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  #output$static <- renderTable(dt)
#  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))

 output$static <- shiny::renderTable({
    data.frame(
    name = c("GOOGLE", "YAHOO"),
    url = c(
toString(tags$a(href="www.rstudio.com", "Click here!")),
toString(tags$a(href="www.rstudio.com", "Click here!"))
)
#    url  = c("<a href>http://nytimes.com</a>",
#             "<a href>http://nytimes.com</a>")
        )
 })
    
      #     url = c("<a href=\"http://www.google.com\">http://www.google.com</a>",
      #                            "http://www.yahoo.com")
      #                            )
 } 
shinyApp(ui, server)
tags$a(href="www.rstudio.com", "Click here!")
## <a href="www.rstudio.com">Click here!</a> 
