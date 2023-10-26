# THIS IS SHINY
# /home/jim/code/SHINY/PART_D/02_display_decisions.R

# Working ... make output$table look nicer
# interactive;  line-by-line renders HTML in browser

library(data.table)
library(shiny)

x  <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")

# one
query  <- c("View First 10", "View All Decisions")
 
# two
n  <- c("View First 10", "View All Decisions (~ 60 seconds)")
v  <- c("View First 10", "View All Decisions")
# -------------------------- UI -----------------------------
ui <- fluidPage(
  #radioButtons("queryId", "Choose 1", choices = query),
  radioButtons("queryId", "Choose 1", choiceNames = n, choiceValues = v),
  tableOutput("decisions")
)






# -------------------------- SERVER-----------------------------
    server = function(input, output) {
      ch  <- reactive(input$queryId)
      output$decisions  <- renderTable({
      if (ch() == "View First 5") {
        head(x)
    } else {
        x
      }
    }
  )
  }
# -------------------------------------------------------
shinyApp(ui, server)




