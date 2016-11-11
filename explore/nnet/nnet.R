library(RTextTools)
data(USCongress)
doc_matrix <- create_matrix(USCongress$text, language="english", removeNumbers=TRUE,
                            stemWords=TRUE, removeSparseTerms=.998)

container <- create_container(doc_matrix, USCongress$major, trainSize=1:4000,
                              testSize=4001:4449, virgin=FALSE)

NNET <- train_model(container,"NNET")

NNET_CLASSIFY <- classify_model(container, NNET)

head(NNET_CLASSIFY)
