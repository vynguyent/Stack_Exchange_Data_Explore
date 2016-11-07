library(tm)
# #start preprocessing

docs <- tm_map(docs,content_transformer(tolower))# #Transform to lower case

# #remove potentially problematic symbols &quot
toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, "", x))})
docs <- tm_map(docs, toSpace, '-',lazy=TRUE)
docs <- tm_map(docs, toSpace, "'",lazy=TRUE)
docs <- tm_map(docs, toSpace, "`",lazy=TRUE)
docs <- tm_map(docs, toSpace, '“',lazy=TRUE)
docs <- tm_map(docs, toSpace, '”',lazy=TRUE)
docs <- tm_map(docs, toSpace, '?',lazy=TRUE) 
docs <- tm_map(docs, toSpace, '&quot;',lazy=TRUE) 


# #remove punctuation
docs <- tm_map(docs, removePunctuation,lazy = TRUE)
#Strip digits
docs <- tm_map(docs, removeNumbers,lazy = TRUE)
#remove whitespace
docs <- tm_map(docs, stripWhitespace,lazy = TRUE)
# Stem document
#docs <- tm_map(docs,stemDocument,lazy=TRUE)

#define and eliminate all custom stopwords
myStopwords <- c('the','for','how','and','with','what','from','are','can'
                 ,'that','use','why','to')
docs <- tm_map(docs, removeWords, myStopwords,lazy=TRUE)