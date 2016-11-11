library(tm)
load(file = 'postdata.RData')
documents<-postdata$Title 
# docs <- Corpus(VectorSource(documents))#create corpus from vector
load(file = 'docs.RData')
print('finished reading in documents')
source('clean.R')#tm_map()
print('finished cleaning documents')

dtm <- DocumentTermMatrix(docs)#Create document-term matrix
#convert rownames to question number
rownames(dtm) <- as.character(paste('Q',seq(length(documents))),sep='')

dtm.mat<-as.matrix(dtm)
dtm<-dtm[(rowSums(dtm.mat) > 0),]#for consideration of LDA errors
save(dtm,file = 'dtm.RData')
print('finish saving out dtm')

#collapse matrix by summing over columns
freq <- colSums(dtm.mat)
#create sort order (descending)
ord <- order(freq,decreasing=TRUE)
#List all terms in decreasing order of freq and write to disk
print(freq[ord][1:50])
write.csv(freq[ord],"word_freq.csv")





