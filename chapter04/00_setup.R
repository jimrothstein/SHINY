# file <- "00_setup.R"

# REF:    Mastering Shiny, Chapter 04, ER injuries
# REF:   https://www.cpsc.gov/Research--Statistics/NEISS-Injury-Data
#        cribs, shopping cart .... injuries
library(shiny)
library(vroom)
library(tidyr)
library(dplyr)
library(ggplot)

##  tries to install `BH`, which has errors (don't want to waste  time on this
##  now) -- see issues in httpgd
if (F) library(httpgd) # control plots easily 

dir.create("neiss")

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
injuries <- vroom::vroom("neiss/injuries.tsv.gz")
injuries


products <- vroom::vroom("neiss/products.tsv")
products
#> # A tibble: 38 × 2
#>   prod_code title                            
#>       <dbl> <chr>                            
#> 1       464 knives, not elsewhere classified 
#> 2       474 tableware and accessories        
#> 3       604 desks, chests, bureaus or buffets
#> 4       611 bathtubs or showers              
#> 5       649 toilets                          
#> 6       676 rugs or carpets, not specified   
#> # … with 32 more rows

population <- vroom::vroom("neiss/population.tsv")
population

selected <- injuries %>% dplyr::filter(prod_code == 649)
nrow(selected)

# weighted by location, body_part, diag, sex
  selected %>% count(location, wt = weight, sort = TRUE)
  selected %>% count(body_part, wt = weight, sort = TRUE)
  selected %>% count(diag, wt = weight, sort = TRUE)
  selected %>% count(sex, wt = weight, sort = TRUE)

summary <- selected %>% 
  count(age, sex, wt = weight)
summary

summary %>% 
  ggplot(aes(age, n, color = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")

summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

summary

summary %>% 
  ggplot(aes(age, rate, colour = sex)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

##  random sample of 10 
selected %>% 
  sample_n(10) %>% 
  dplyr::pull(narrative)      # same as selected$narrative





