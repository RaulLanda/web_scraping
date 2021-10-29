# This script hallows the scraping of a website
#César Raúl Landa Aponte  oct/28/2021


library(jsonlite)
library(tidyverse)
library(dplyr)
library(httr)

#import the address to R
btc <- jsonlite::fromJSON("https://www.reddit.com/r/pedalboards/.json")

#Filter the names of the "children" directories
df1 <- btc$data$children$data

# Selecto desired columns
new <- df1[,c("ups", "title", "subreddit", "url")]

#Order by upvote
alldatasorted <- new[order(-new$up),]
