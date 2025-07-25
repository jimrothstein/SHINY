This small Shiny application demonstrates Shiny's automatic UI updates. 

Move the *Number of bins* slider and notice how the `renderPlot` expression is automatically re-evaluated when its dependant, `input$bins`, changes, causing a histogram with a new number of bins to be rendered.


"Shinylive is a new way to run Shiny entirely in the browser, without any need for a hosted server, using WebAssembly via the webR project."
READ:  https://posit-dev.github.io/r-shinylive/

more Shinylive examples: (code)
https://shinylive.io/r/examples/#hello-shiny

READ:  Shinylive docs:
https://posit-dev.github.io/r-shinylive/

More details;  including **embed shinylive** app (ie change a plot) within a **quarto** app
https://www.tidyverse.org/blog/2024/10/shinylive-0-8-0/

