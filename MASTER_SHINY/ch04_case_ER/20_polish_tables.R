# file <- "20_polish_tables.R"
# --------------------------------------------------------------------
# REF:    Mastering Shiny, Chapter 04.5, ER injuries
# REF:    https://www.cpsc.gov/Research--Statistics/NEISS-Injury-Data
#        cribs, shopping cart .... injuries

# PURPOSE:  Polish tables, using forcats::
# USAGE:  (source("10_prototype.R"))
# --------------------------------------------------------------------
#
# PROBLEM:   for diag(nosis) find top 5 and freq.
library(shiny)
library(vroom)
library(tidyr)
library(dplyr)
library(ggplot2)
library(forcats)

##  tries to install `BH`, which has errors (don't want to waste  time on this
##  now) -- see issues in httpgd
if (F) library(httpgd) # control plots easily 






# change "master" to "main", then works 
  if (F) {
  download <- function(name) {
    url <- "https://github.com/hadley/mastering-shiny/raw/main/neiss/"
    cat(from  <- paste0(url, name), "\n")
    cat(to  <-  paste0("neiss/", name), "\n")
    utils::download.file(from,to,  quiet = TRUE)
  }
  download("injuries.tsv.gz")
  download("population.tsv")
  download("products.tsv")
  }

##  if already downloaded:
injuries <- vroom::vroom("./neiss/injuries.tsv.gz")
head(injuries, n=3)

products <- vroom::vroom("products.tsv")
population <- vroom::vroom("population.tsv")


nrow(injuries)  

# ------------------------------------------------------------------------------
##  documenation:  use fct_lump_n, not fct_lump,  
##  item 6 is all all "other"
##  fct_* must convert diag frm char to factor   (I like data.table!)
injuries %>%
  mutate(diag = forcats::fct_lump_n(fct_infreq(diag), n = 5)) %>%      ##  `in order of freq`, 
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)/1000))           # /1000 cases per 1000 people

# ------------------------------
library(data.table)
dt  <- as.data.table(injuries)
dt
##  x  <- dt[, list(diag,sex)]
dt[, by=diag, .N][order(-N)]
# ------------------------------

                                       ## injuries (by toliet) 
dt[prod_code==649,  .N] # [1] 2993
dt[prod_code==649, by=diag, .N][order(-N)]

# ------------------------------

##  What is `weight` ? STUCK 
## 
dt[, .(diag,location, body_part,   weight)]
## by location
dt[, by=.(location, body_part, diag, weight), .(location, body_part, diag, weight)]
# ------------------------------
#
# ------------------------------
## PRELIM:   before SHINY
# ------------------------------
selected <- injuries |> dplyr::filter(prod_code == 649) #toilet 

##
summary <- selected %>% 
  count(age, sex, wt = weight)
summary
#> # A tibble: 208 × 3
#>     age sex         n
#>   <dbl> <chr>   <dbl>
#> 1     0 female   4.76
#> 2     0 male    14.3 
#> 3     1 female 253.  
#> 4     1 male   231.  
#> 5     2 female 438.  
#> 6     2 male   632.  
#> # … with 202 more rows

summary %>% 
  ggplot(aes(age, n, colour = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")

