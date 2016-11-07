# source('postdata.R')
# save(postdata,file = 'postdata.RData')
setwd('/Users/CDX/Stack_Exchange_Data_Explore/stats.stackexchange.com/')
library(tm)
load(file = 'postdata.RData')
# documents<-postdata$Title 
# docs <- Corpus(VectorSource(documents))#create corpus from vector
load(file = 'docs.RData')
docs.backup = docs

source('clean.R')#tm_map()
writeLines(as.character(docs[[3000]]))#inspect

dtm <- DocumentTermMatrix(docs)#Create document-term matrix
dim(dtm)

#convert rownames to question number
rownames(dtm) <- as.character(paste('Q',seq(length(documents))),sep='')
colnames(dtm)#terms
inspect(dtm[1000:1005,100:105])
findFreqTerms(dtm, 2000)#Each of these words occurred more that 2000 times

dtm<-as.matrix(dtm)

#collapse matrix by summing over columns
freq <- colSums(dtm)
#length should be total number of terms
length(freq)
#create sort order (descending)
ord <- order(freq,decreasing=TRUE)
#List all terms in decreasing order of freq and write to disk
freq[ord]
write.csv(freq[ord],"word_freq.csv")




