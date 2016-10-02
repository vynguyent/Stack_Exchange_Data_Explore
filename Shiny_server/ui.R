library(shiny)  

shinyUI(fluidPage(
  titlePanel("Stack Tag Cloud"),
  sidebarPanel(
    dateRangeInput("daterange", label = h3("Date range"), start = '2015-09-01'
                   ,end = '2016-09-01',max = '2016-09-01' ,min ='2008-07-01' )
  ),
  mainPanel(tabsetPanel(
    tabPanel('plot',plotOutput("cloudplot")),
    tabPanel('table',dataTableOutput("record"))
  ))
)
)


#http://shiny.rstudio.com/tutorial/lesson3