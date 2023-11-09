## /home/jim/code/SHINY/PART_D/04_decisions_boxplot.R
## PURPOSE:   Display CMS Part D: Favorable - Unfavorable BOXPLOT

##  STATUS:   Works!

library(data.table)
library(shiny)

x <- fread("cms_part_d_01OCT2022_30SEPT2023_data.csv")
y <- x[, .N, by = decision]


# ui <- fluidPage(
#     plotOutput("plot", width = "600px")
# )

boxplot_ui <- function(id) {
    #    tagList(
    h2("boxplot")
    # next line fails
    # plotOutput("plot", width = "600px")
    #    )
}

# server <- function(input, output, session) {
#     output$plot <- renderPlot(
#         barplot(y$N,
#             names.arg = y$decision,
#             main = "CMS Decisions: Part D, 01 OCT 2022 -- 30 SEPT 2023"
#         ),
#         res = 96
#     )
# }

boxplot_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        datax <- reactive(x)
        data <- reactive(datax()[, .N, by = decision])
        output$plot <- renderPlot(
            barplot(data()$N,
                names.arg = data()$decision,
                main = "CMS Decisions: Part D, 01 OCT 2022 -- 30 SEPT 2023"
            ),
            res = 96
        )
    })
}

boxplot_demo <- function(id) {
    ui <- fluidPage(fluidRow(boxplot_ui("fake")))

    server <- function(input, output, session) {
        boxplot_server("fake")
    }

    shinyApp(ui, server)
}
options(shiny.autoreload = TRUE)
boxplot_demo()
