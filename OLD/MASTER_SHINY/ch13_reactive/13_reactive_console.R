

##  Reactive:   both lazy and uses cache
library(shiny)
reactiveConsole(TRUE)


temp_c <- reactiveVal(10) # create
temp_c()                  # get
# [1] 10
#

temp_c(20)                # set
temp_c()                  # get

temp_f <- reactive({
  message("Converting") 
  (temp_c() * 9 / 5) + 32
})

temp_f()
temp_f()    # note:  no re-calculation if no change to temp_c

