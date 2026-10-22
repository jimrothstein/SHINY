library(shiny)
library(ggplot2)

##  Works - Static
##
##   consumer of reactiveexpressions  + outputs 
##   producer:   inputs + reactive expressions 
freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )

  ggplot(df, aes(x, colour = g)) +
#    geom_freqpoly(binwidth = binwidth, size = 1) +
    geom_freqpoly(binwidth = binwidth, linewidth = 1) +
    coord_cartesian(xlim = xlim)
}

t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
  
  # use sprintf() to format t.test() results compactly
# # need cat() to get \n to work
  cat(sprintf(
    "p value: %0.3f\n[%0.2f, %0.2f]\n",
    test$p.value, test$conf.int[1], test$conf.int[2]
  ))
}

{
x1 <- rnorm(100, mean = 0, sd = 0.5)
x2 <- rnorm(200, mean = 0.15, sd = 0.9)

freqpoly(x1, x2)
cat(t_test(x1, x2))
}

# --------------------
