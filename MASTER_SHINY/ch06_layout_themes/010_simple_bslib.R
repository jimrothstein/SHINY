library(bslib)
library(shiny)

theme <- bslib::bs_theme(
    bg = "#0b3d91",
    fg = "white",
    base_font = "Source Sans Pro"
)

bslib::bs_theme_preview(theme)
shinyApp(ui, server)
