##############################
## TOPIC MODELING USING LDA ##
##############################
## ------------------------------------------------------------------------
# Removing stop words
library(tidytext)
library(dplyr)
library(stringr)
load("postdata.Rdata")
reg = "&quot;|\\$|&lt;"
Title <- postdata %>% 
  select(Id, Title)# %>% 
#data_frame()
Title = data.frame(Title)
Title_clean <- Title %>% 
  mutate(text=str_replace_all(Title,pattern=reg, replacement = "")) %>% 
  unnest_tokens(word, text) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

save(Title_clean,file="Title_clean")

## ------------------------------------------------------------------------
wc_title <- Title_clean %>% 
  count(Id, word,sort=TRUE) %>%
  ungroup()
## ------------------------------------------------------------------------
#Extracting topics using LDA

library(topicmodels)

k=20 #number of topics
lda_title <- cast_dtm(wc_title, Id, word, n) %>%
  LDA( k = k, method = "VEM", control = list(seed = 11-11-2016))

save(lda_title, file="lda_title")

## ------------------------------------------------------------------------
# Top n terms for k topics sorted by beta
n=10
top_title <- lda_title %>%
  tidy("beta") %>%
  group_by(topic) %>%
  top_n(n=n, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)
