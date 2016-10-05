library(mongolite)
library(dplyr)
library(stringr)
library(reshape2)
library(igraph)  

splitTags = function(x){
  tags = str_match_all(x, "<(.+?)>")[[1]][,2]
  if(length(tags)<=1){
    return()
  }
  edges_list = combn(tags, 2)
  return(edges_list)
}

cummunimty_igraph<-function(db){
  client <- mongo(collection="Posts", db=db, url="mongodb://yida:yida@0.tcp.ngrok.io:14162/admin")
  posts = client$find('{"@PostTypeId": "1"}', limit=4000)
  tags = posts$`@Tags`
  tags = lapply(tags, splitTags)
  el = matrix(unlist(tags), ncol=2, byrow=T)
  g = make_graph(t(el), directed=F)
  
  
  
  adj_matrix = get.adjacency(g,sparse=FALSE)
  del = c()
  for(i in 1:dim(adj_matrix)[1]){
    if (sum(adj_matrix[i,])<200){
      del = c(del, i)
    }
  }
  adj_matrix = adj_matrix[-del, -del]
  g = graph_from_adjacency_matrix(adj_matrix, mode = c("undirected"), weighted=TRUE)
  E(g)$width <- E(g)$weight/max(E(g)$weight) * 10
  d = sna::degree(adj_matrix)
  V(g)$size = d / max(d) * 50
  return(g)
  
}

stat_g<-cummunimty_igraph('stats_stackexchange_com')
stack_g <- cummunimty_igraph('stackoverflow_com')
union_g<-stat_g %u% stack_g


# ------------
plot(union_g,
     vertex.size = V(union_g)$size,
     edge.curved = T,
     vertex.label.font=2	,
     vertex.label.dist = 0.3	,
     vertex.label.cex	= 2
)








