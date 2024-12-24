#' @examplesShinyLive
#' interactive <- function() TRUE
#' {{ next_example }}
#' @examples
#' (...)
my_super_app <- function() {
  ...
source("basic_roxy_web/app.R")
  
  shiny::shinyApp(ui=ui, server=server)
}

my_super_app()
