library(shiny)
library(RJSONIO)
require(wordcloud)

con <- file("tags_count.json",open = "r")
tag<-vector("list")
i=0
while(T){
  i<-i+1
  temp<-readLines(con,1)
  if(length(temp)==0){
    print("reach the end")
    break
  } else temp<-sub('.*\\t', '',temp, perl = TRUE)#get rid of the series ahead of json format
  tag[[i]]<-fromJSON(temp)
}
close(con)

shinyServer(function(input, output) {
  dataset <- reactive({
    countstat<-lapply(tag[[1]], function(x,start,end) {
      sapply(x, function(xx) {
        tm <- paste(names(xx[[2]]),'-01',sep = '')
        c(name=xx[[1]],freq=sum(xx[[2]][tm<=end & tm>=start]))}
      )
    }, start = input$daterange[1], end= input$daterange[2])
    
    len <- length(unlist(countstat))
    tags <- unlist(countstat)[2*(seq(len/2))-1]
    count <- as.integer(unlist(countstat)[2*seq(len/2)])
    countstat<-data.frame(tags= tags,count=count)
    countstat
  })#有交互的处理
  
  output$cloudplot <- renderPlot({
    colors=brewer.pal(8,"Dark2")
    d<-dataset()
    wordcloud(d$tags, d$count, max.words=100,
              scale=c(8,0.2),min.freq=-Inf,
              colors=colors,random.order=F,random.color=F,ordered.colors=F,
              main='Pop tags')
    }, height=600)
  output$record <- renderDataTable(
    dataset()
  )

})
