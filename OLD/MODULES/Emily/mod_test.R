library(shiny)
library(nycflights13)
library(dplyr)
library(ggplot2)


# function to extract data, plot

ua_data <-
  nycflights13::flights %>%
  dplyr::filter(carrier == "UA") %>%
  mutate(ind_arr_delay = (arr_delay > 5)) %>%
  group_by(year, month, day) %>%
  summarize(
    n = n(),
    across(ends_with("delay"), \(x) mean(x, na.rm = TRUE))
  ) %>%
  ungroup()


# head(ua_data)
viz_monthly <- function(df, y_var, threshhold = NULL) {
  ggplot(df) +
    aes(
      x = .data[["day"]],
      y = .data[[y_var]]
    ) +
    geom_line() +
    geom_hline(yintercept = threshhold, color = "red", linetype = 2) +
    scale_x_continuous(breaks = seq(1, 29, by = 7)) +
    theme_minimal()
}
if (F) {
  ua_data %>%
    dplyr::filter(month == 3) %>%
    viz_monthly("arr_delay", threshhold = 10)
}



#   the module
# --------------
# --------------

# text module ----
text_ui <- function(id) {
  fluidRow(
    textOutput(NS(id, "text"))
  )
}

text_server <- function(id, df, vbl, threshhold) {
  moduleServer(id, function(input, output, session) {
    n <- reactive({
      sum(df()[[vbl]] > threshhold)
    })
    output$text <- renderText({
      paste(
        "In this month",
        vbl,
        "exceeded the average daily threshhold of",
        threshhold,
        "a total of",
        n(),
        "days"
      )
    })
  })
}

# --------------------------
# function to run the demo
# --------------------------
text_demo <- function() {
  df <- data.frame(day = 1:30, arr_delay = 1:30)
  ui <- fluidPage(text_ui("x"))
  server <- function(input, output, session) {
    text_server("x", reactive({
      df
    }), "arr_delay", 15)
  }
  shinyApp(ui, server)
}

# ------------
##  run demo
# ------------
text_demo()
