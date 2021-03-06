#####parse####
rm(list=ls())
library(plyr)
library(stringr)
# postdata = data.frame(Id=character(),
#                       PostTypeId=character(),
#                       ViewCount=numeric(),
#                       Body=character(),
#                       Title=character(),
#                       Tags=character())
temp = matrix(NA, nrow=200000, ncol=6)

post  <- file("Posts.xml", open = "r")
# read file line by line
i = 1
while (length(thisLine <- readLines(post, n = 1, warn = FALSE)) > 0) {
  # check whether "<row Id=" appears in this line
  if (!grepl("<row Id", thisLine)){next}
  
  # parse "Id"
  if (grepl("Id=\"", thisLine)){
    Id = str_match(thisLine, "Id=\"(\\d+)\"")[, 2]
  } else {Id = NA} 
  # parse "PostTypeId"
  if (grepl("PostTypeId=\"", thisLine)){
    PostTypeId = str_match(thisLine, "PostTypeId=\"(\\d+)\"")[, 2]
    if (PostTypeId !="1") {next}
  } else {PostTypeId = NA}
  # parse "ViewCount"
  if (grepl("ViewCount=\"", thisLine)){
    ViewCount = str_match(thisLine, "ViewCount=\"(\\d+)\"")[, 2]
  } else { ViewCount = NA}
  
  # parse "Body"
  if (grepl("Body=\"", thisLine)){
    Body = str_match(thisLine, "Body=\"(.+?)\" Owner")[, 2]
  } else {Body = NA}
  # parse "Title"
  if (grepl("Title=\"", thisLine)){
    Title = str_match(thisLine, "Title=\"(.+?)\"")[, 2]
  } else {Title = NA}
  # parse "Tags"
  if (grepl("Tags=\"", thisLine)){
    Tags = str_match(thisLine, "Tags=\"(.+?)\"")[, 2]
  } else {Tags = NA}
  
  temp[i,] = c(Id, PostTypeId, ViewCount, Body, Title, Tags)
  i = i + 1
}
close(post)
postdata = data.frame(temp)
postdata = postdata[apply(postdata, 1, function(x){!all(is.na(x))}), ]
names(postdata) = c("Id", "PostTypeId", "ViewCount", "Body", "Title", "Tags")
postdata$Id = as.character(postdata$Id)
postdata$PostTypeId = as.character(postdata$PostTypeId)
postdata$ViewCount = as.numeric(postdata$ViewCount)
postdata$Body = as.character(postdata$Body)
postdata$Title = as.character(postdata$Title)
postdata$Tags = as.character(postdata$Tags)

rm(list=c("Body", "Id", "post", "PostTypeId", "Tags", "thisLine", "Title", "ViewCount", "i", "temp"))

library(stringr)# arrange the data
postdata$Tags = lapply(postdata$Tags, function(x){str_replace_all(x, "&lt;", "<")})
postdata$Tags = lapply(postdata$Tags, function(x){str_replace_all(x, "&gt;", ">")})

postdata$Body = lapply(postdata$Body, function(x){str_replace_all(x, "&lt;p&gt;", "")})
postdata$Body = lapply(postdata$Body, function(x){str_replace_all(x, "&lt;/p&gt;&#xA;", "")})
postdata$Body = lapply(postdata$Body, function(x){str_replace_all(x, "&#xA;", "")})


