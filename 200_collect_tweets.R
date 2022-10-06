library(rtweet)
library(tidyverse)
library(tm)
library(stringr)
library(dplyr)

#	POPUP:   Claim this will set up for thie ONE session
#
auth_setup_default()
auth_as("default")
rstats <- search_tweets("#rstats", n = 100, include_rts = FALSE)
head(rstats)



#	skip--------------------------------------------
appname <- "twitter_shiny"
## api key (example below is not a real key)
##
key <- Sys.getenv("consumer_key")

secret  <- Sys.getenv("consumer_secret")
access_token <- Sys.getenv("access_token") 
access_secret <- Sys.getenv("access_secret")

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)


#	---BEGIN here -----------------------------------------
#
username <- "jimrothstein"
craig_faves <- get_favorites(username, 3000) 
head(craig_faves)

craig_faves$lower_text <- tolower(craig_faves$full_text)
words_to_keep <- c("rstats", " r ", "rstudio", "tidyverse", 
                   "python", "sql", "excel ", 
                   "tableau", "power bi",
                   "nlp", "machine learning", 
                   "shiny", "data vi", "cloud", 
                   "data mining", "datamining", "web3", 
                   "crypto", "blockchain", "deeplearning", 
                   "neural", "neuralnetwork", "statistics",
                   "artificial", "artificial intelligence", "tensor")
craig_faves <- craig_faves %>% filter(str_detect(lower_text, str_c(words_to_keep, collapse = '|')))
head(craig_faves)
#	omit his URL prep
saveRDS(craig_faves, 'faves.rds')
