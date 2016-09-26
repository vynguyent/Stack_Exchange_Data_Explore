library(shiny)  

shinyUI(fluidPage(
  #titlePanel(""),#标题
  sidebarPanel(
    dateRangeInput("daterange", label = h3("Date range"), start = '2016-05-01'
                   ,end = '2016-09-01',max = '2016-09-01' ,min ='2008-09-01' ),
    fluidRow(column(4, verbatimTextOutput("value")))
    ),
  mainPanel(tabsetPanel(
    tabPanel('plot',plotOutput('cloudplot')),
    tabPanel('table',dataTableOutput("record"))
    ))
)
)


#http://shiny.rstudio.com/tutorial/lesson3