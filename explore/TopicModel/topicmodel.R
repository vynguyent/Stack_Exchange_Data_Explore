gc()
rm(list = ls())
library(topicmodels)

#Set parameters for Gibbs sampling
burnin <- 4000
iter <- 2000
thin <- 500
seed <-list(2003,5,63,100001,765)
nstart <- 5
best <- TRUE

#Number of topics
k <- 50
source('freq.R')#if update stopwords in 'clean.R'
load(file = 'dtm.RData')
 
# ldaOut <-LDA(dtm.td,k, method='Gibbs',
#              control=list(nstart=nstart, seed = seed, best=best
#                           , burnin = burnin, iter = iter, thin=thin))


ldaOut <-LDA(dtm,k)
print('finish LDA modeling')

#write out results
#docs to topics
ldaOut.topics <- as.matrix(topics(ldaOut))
write.csv(ldaOut.topics,file=paste("LDA",k,"DocsToTopics.csv"))
print('finish writing out docs to topics')

#top 6 terms in each topic
ldaOut.terms <- as.matrix(terms(ldaOut,60))

write.csv(ldaOut.terms,file=paste("LDA",k,"TopicsToTerms.csv"))

#probabilities for each doc associated with each topic assignment
topicProbabilities <- as.data.frame(ldaOut@gamma)
write.csv(topicProbabilities,file=paste("LDA",k,"TopicProbabilities.csv"))

#Find relative importance of top 2 topics
topic1ToTopic2 <- lapply(1:nrow(dtm),function(x)
  sort(topicProbabilities[x,])[k]/sort(topicProbabilities[x,])[k-1])

#Find relative importance of second and third most important topics
topic2ToTopic3 <- lapply(1:nrow(dtm),function(x)
  sort(topicProbabilities[x,])[k-1]/sort(topicProbabilities[x,])[k-2])

#write to file
write.csv(topic1ToTopic2,file=paste("LDA",k,"Topic1ToTopic2.csv"))
write.csv(topic2ToTopic3,file=paste("LDA",k,"Topic2ToTopic3.csv"))
