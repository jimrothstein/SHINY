## /home/jim/code/SHINY/PART_D/04_decisions_boxplot.R
## PURPOSE:   Display CMS Part D: Favorable - Unfavorable BOXPLOT

library(data.table)
library(shiny)

x <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
y <- x[, .N, by = decision]


# ------------------------------
boxplot_ui <- function(id) {
    fluidPage(
        fluidRow(
            h2("Row1"),
            tableOutput(NS(id, "table"))
        ),
        fluidRow(
            h2("Row2"),
            plotOutput(NS(id, "plot"), width = "600px")
        )
    )
}

# ------------------------------
boxplot_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        data <- reactive(x[, .N, by = decision])
        # x <- reactive(iris)
        output$table <- renderTable(data())
        output$plot <- renderPlot(
            barplot(data()$N,
                names.arg = data()$decision,
                main = "CMS Decisions: Part D, 01 OCT 2022 -- 30 SEPT 2023"
            ),
            res = 96
        )
    })
}

# ------------------------------
boxplot_demo <- function(id) {
    ui <- boxplot_ui("fake")

    server <- function(input, output, session) {
        boxplot_server("fake")
    }
    shinyApp(ui, server)
}
options(shiny.autoreload = TRUE)
boxplot_demo()
