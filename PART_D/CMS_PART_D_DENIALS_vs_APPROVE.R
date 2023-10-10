##/home/jim/code/SHINY/PART_D/CMS_PART_D_DENIALS_vs_APPROVE.R
## PURPOSE:   Display CMS Part D: Favorable - Unfavorable

##  STATUS:   Works!
## Out of 32.7k appeals in year ending SEP 30, 2023; 15/16 were rejected
library(data.table)
library(shiny)

x  <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")


    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('decisions')
        )
      )
    )

    server = function(input, output) {
      output$decisions  <- renderTable(table(x$decision))
    }
  
shinyApp(ui, server)



