#Load Library yang relevan
library(tm)
library(twitteR)
library(rtweet)
library(wordcloud)

api_key <- 'YWNgbVoBHTeXg1SFpGr1ALgVJ'
api_secret <- 'huUHkgPynFph3Z9ZG7YUXpErljkCCqNhkQS8BBFfmYVcpmykuE'
Access_token <- '2490891704-uX4Soob6epdSw3xm2wxgkVnxDbM9ZkzOPsh5pxj'
Access_secret <- 'KXCrRQNWiEN3aFvkjAUMQQT6kMSAiKgpmMLzOZ2NavXha'


#Login/access ke Twitter

setup_twitter_oauth(api_key, api_secret, Access_token, Access_secret)

#Generate Tweet

tweet <- searchTwitter('biden', n=1000, lang='id' )
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

stopwordID <- "C:/Users/ASUS/Documents/ID-Stopwords-master/id.stopwords.02.01.2016.txt"
cStopwordID <- readLines(stopwordID)
