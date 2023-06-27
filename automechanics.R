library(shiny)
library(tibble)


dt  <- tribble(
        ~shop, ~yelp_link, ~comments,
        "shop1", "<nytimes.com>", "my cooments",
        "shop2", "<nytimes.com>", "my cooments"
               )


ui <- fluidPage(
                 dataTableOutput("static")
tableOutput("static"),
#  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  #output$static <- renderTable(dt)
#  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))

 output$static <- shiny::renderTable({
    data.frame(
    name = c("GOOGLE", "YAHOO"),
    url = c(toString(tags$a("http://nytimes.com")),
             toString(tags$a("http://nytimes.com"))
        )
    )
    
      #     url = c("<a href=\"http://www.google.com\">http://www.google.com</a>",
      #                            "http://www.yahoo.com")
      #                            )
    })
 } 
shinyApp(ui, server)

tags$a("http://" + paste0(k))
