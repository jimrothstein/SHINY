##	file <- "app.R"
##	Lesson 2	

library(shiny)

# Define UI ----
ui <- fluidPage(
  titlePanel("Lesson 02: title panel"),

	#		default is left	
  sidebarLayout(position = "right",
    sidebarPanel("sidebar panel"),
    mainPanel("main panel",
		  h5("Fifth level title"),
			br(),
			code("This should be code"),
      h6("Sixth level title")
    )
   )
) 


# Define server logic ----
server <- function(input, output) {
  
}

if (F) {
	((source('app.R')))
	runApp('../lesson02')
}

# Run the app ---- 
shinyApp(ui = ui, server = server)


