library(shiny)
library(tibble)

# Version 1


dt  <- tribble(
        ~shop, ~yelp_link, ~comments,
        "DC Auto Repair | FAR, but excellent ", "https://www.yelp.com/biz/dc-auto-repair-springfield?osq=Auto+Repair","no",
        "Prarie Road | FAR, only last 2  bad", "https://www.yelp.com/biz/prairie-road-automotive-eugene?osq=Auto+Repair","no",
        "Patrick Olsen |  very near", "https://www.yelp.com/biz/patrick-olsen-auto-repair-eugene?osq=Auto+Repair++Patrick+Olsen","no",
        "Oakmont Service Center | near", "https://www.yelp.com/biz/oakmont-service-center-eugene?osq=Auto+Repair","no",
        "Joe's | near","https://www.yelp.com/biz/joes-garage-eugene?osq=Auto+Repair" , "no",
        "Autohaus | very near", "https://www.yelp.com/biz/autohaus-eugene?osq=Auto+Repair", "no",
        #"shop1", "http://www.nytimes.com", "my cooments",,
        #"shop2", "<nytimes.com>", "my cooments"
               )


ui <- fluidPage(
                br(),
                shiny::a(href = toString(dt$yelp_link[[1]]), toString(dt$shop[[1]])),
                p(),
                shiny::a(href = toString(dt$yelp_link[[2]]), toString(dt$shop[[2]])),
                p(),
                shiny::a(href = toString(dt$yelp_link[[3]]), toString(dt$shop[[3]])),
                p(),
                shiny::a(href = toString(dt$yelp_link[[4]]), toString(dt$shop[[4]])),
                p(),
                shiny::a(href = toString(dt$yelp_link[[5]]), toString(dt$shop[[5]])),
                p(),
                shiny::a(href = toString(dt$yelp_link[[6]]), toString(dt$shop[[6]])),

                
                h3("What confuses me is when shop with steller ratings suddenly drops:  a fluke? did the guy retire?"),
)

