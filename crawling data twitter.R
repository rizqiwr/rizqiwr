#Load Library yang relevan
library(tm)
library(twitteR)
library(rtweet)
library(wordcloud)

api_key <- "your api key"
api_secret <- "your api secret"
Access_token <- "your access token"
Access_secret <- "your access secret"


#Login/access ke Twitter

setup_twitter_oauth(api_key, api_secret, Access_token, Access_secret)

#Generate Tweet

tweet <- searchTwitter('Apple', n=1000, lang='id' )
tweet
tweetdf <- twListToDF(tweet)
write.csv(tweetdf, file = 'C:/Users/ASUS/Documents/tweet.csv', row.names=F)
#setwd()
head(biden)
#Load File CSV hasil dari twitter
biden <- read.csv((file.choose()), header=T)
str(biden)

#Build corpus of tweets
library(tm)
corpus <- iconv(biden$text, to="UTF-8")
corpus <- corpus(VectorSource(corpus))
inspect(corpus[1:5])

#cleaning text
corpus <- tm_map(corpus, tolower)
inspect(corpus[1:5])

corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])

stopwordID <- "insert stopword file from your computer"
cStopwordID <- readLines(stopwordID)
