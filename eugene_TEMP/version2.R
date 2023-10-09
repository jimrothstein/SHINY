library(data.table)
# 1900 missing data
{
s="
year, count
1901, 6
1920, 8
1940, 14
1945, 20
1952, 20
1953, 11
1954, 0
1955, 7
1960, 17
1965, 17
1970, 29
1975, 9
1980, 9
1985, 19
1990, 25
1995, 16
2000, 11
2005, 18
2010, 15
2015, 29
2020, 22
2022, 25
2023, 31" 
}
x= fread(s)
# --------------
library(shiny)
    ui = fluidPage(
                   textOutput('version'),
                   plotOutput('temp'),
                   tableOutput('table')
                   
                   )
    server = function(input, output) {
      output$version  <- renderText("version 3")
      output$table <- renderTable(x)
      output$temp  <- renderPlot({
          plot(x$year, x$count, xlab="Year", 
               ylab="Days above 90F", 
               main="Days above 90F", sub="Is it getting hotter?")
          abline(h=20, col="red")
          abline(h=10, col="red")
      }, width=800)
      }
    
if (F) { 
  plot(dt$year, dt$count)
  abline(h=0)
  abline(h=20, col="red")
  abline(coef=c(5, .1))
}

shinyApp(ui, server)
# --------------
library(shiny)
    ui = fluidPage(
           tableOutput('table')
                   )
    server = function(input, output) {
      output$table  <- renderTable(x)
}
  shinyApp(ui, server)

# ----------------------
library(shiny)
    ui = fluidPage(
                   textOutput('version'),
                   tableOutput('table')
                   
                   )
    server = function(input, output) {
      output$version  <- renderText("version 2")
      output$table <- renderTable(x)
    }
shinyApp(ui, server)

# ----------------------

