#!/usr/bin/env Rscript


# USAGE: ./shiny_run_app.R, then manually open browser

options(shiny.autoreload = TRUE)
shiny::runApp(".")
