#text mining review app
library(xml2)
library(rvest)
review <- read_html("https://www.tokopedia.com/uneed-indonesia/uneed-hybrid-pro-anti-break-screen-protector-handphone-full-cover-front-and-back?src=topads")
review
r <- html_nodes(review, ".e1qvo2ff8")
text <- html_text(r)
text
write.csv(review, "D:/R Studio/review.csv")
write.csv(text, "D:/R Studio/review.csv")
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)
review <- readLines("D:/R Studio/review.csv")
review
review= VCorpus(VectorSource(review))
review
stopwordID <- "D:/R Studio/id.stopwords.02.01.2016.txt"
cstopwordID <- readLines(stopwordID)
cleanset <- tm_map(review, removeWords, cstopwordID)
inspect(review[1])
str(review)
reviewdtm <- 
  DocumentTermMatrix(review, control = list(tolower=TRUE,
                                            removeNumbers=TRUE,
                                            stopwords=TRUE,
                                            removePunctuation=TRUE,
                                            stemming=TRUE))
reviewdtm
inspect(reviewdtm)
reviewdtm$dimnames$Terms
reviewfreq <- findFreqTerms(reviewdtm,3)
reviewfreq
dokkudtm <- TermDocumentMatrix(review)
dokkudtm
matriks <- as.matrix(dokkudtm)
matriks
munculkata <- sort(rowSums(matriks), decreasing = TRUE)
munculkata

df <- data.frame(word = names(munculkata), freq=munculkata)
head(df, 15)
str(df)
df$word
df$freq

wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))
library(wordcloud2)
wordcloud2(words = df$word, freq = df$freq, maxRotation = 150)
