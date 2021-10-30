# This script hallows the scraping of a website
#César Raúl Landa Aponte  oct/28/2021


library(jsonlite)
library(tidyverse)
library(dplyr)
library(httr)
library(ggplot2)

#import the address to R
#btc <- jsonlite::fromJSON("https://www.reddit.com/r/pedalboards/.json")


politics <- jsonlite::fromJSON("https://www.reddit.com/r/politics/.json")
pol_disc <- jsonlite::fromJSON("https://www.reddit.com/r/PoliticalDiscussion/.json")

#Filter the names of the "children" directories
#df1 <- btc$data$children$data


df_politics <- politics$data$children$data
df_pol_disc <- pol_disc$data$children$data

# Selecto desired columns
#new <- df1[,c("ups", "title", "subreddit", "url")]
prune_df_politics <- df_politics[,c("ups", "title", "subreddit", "url", "author_fullname")]
prune_df_pol_disc <- df_pol_disc[,c("ups", "title", "subreddit", "url", "author_fullname")]

#merge all the data frames
alldata <- rbind(prune_df_pol_disc, prune_df_politics)

#Order by upvote
alldatasorted <- alldata[order(-alldata$up),]

#normalize data

scaled.dat <- clusterSim::data.Normalization(alldatasorted[,1], type = "n5", normalization = "column") 
alldatasorted[,1] <- scaled.dat

#filter all the ups less than 0

alldatasorted <- filter(alldatasorted, ups >= 0)

#Filtering all ups less than 0 we get the most upvoted topics 
jpeg(filename = "Most_upvoted_threads.jpg", width = 900, height = 600)
g <- ggplot(data = alldatasorted, aes(x = ups, y = title))
graph <- g + geom_bar(stat = "identity") +labs(title  = "Most upvoted threads in politics and PoliticalDiscusion subredits. Oct/29/2021")
graph + aes(stringr::str_wrap(title,15), ups) + ylab(NULL)
dev.off()
