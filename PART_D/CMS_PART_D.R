## /home/jim/code/SHINY/PART_D/CMS_PART_D.R 

## PURPOSE:   Display CMS Part D data

##  STATUS:   Works!

library(data.table)
library(shiny)

x  <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")


    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('table')
        )
      )
    )

    server = function(input, output) {
      output$table <- renderTable(head(x))
    }
  
shinyApp(ui, server)


