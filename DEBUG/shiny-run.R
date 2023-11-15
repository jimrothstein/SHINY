# This script is used to run the application defined in app.R in the background
options(shiny.autoreload = TRUE)
shiny::runApp(port=3828)# launch.browser = FALSE)