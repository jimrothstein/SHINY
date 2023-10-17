library(shiny)

##  Same? No.  2nd always has 2 dependencies

observe({
  if(input$a=="good"){
    print("good")
  } else {    
    print(input$b)
  }
})

observe({
  a <- input$a
  b <- input$b
  if(a=="good"){
    print("good")
  } else {
    print(b)
  }
})
