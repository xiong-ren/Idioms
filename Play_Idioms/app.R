library(shiny)
library(stringi)
library(shinythemes)
#setwd("E:/Idioms/Play_Idioms")
#read the idioms 
Idioms <- read.table(file = "A.txt",fileEncoding = "UTF-8")
#trans to vector
Vector_Idioms <- as.vector(as.matrix(Idioms))

#function read the last char 
getlastKey <- function(input_idioms)
{
  key <- stri_sub(input_idioms, from = -1)
  return(key)
}
#function read the first char 
getfirstKeys <- function(input_idioms)
{
  key <- stri_sub(input_idioms, from = 1,to = 1)
  return(key)
}
#get the fisrt char index 
keys <- getfirstKeys(Vector_Idioms)

lookupIdioms <- function (find_idioms,max_found = 5) {
  
  if(length(which(Vector_Idioms == find_idioms))==0) return("你输入的不是成语")
  #get the last char
  key <- getlastKey(find_idioms)
  found <- which(keys == key)
  if (length(found) > max_found) return(Vector_Idioms[found[1:max_found]])
  if (length(found) == 0) return("找不到可以接龙的成语")
  if (length(found) <= max_found) return(Vector_Idioms[found])
}

ui <- fluidPage(
  #shinythemes::themeSelector(), 
  theme = shinytheme("superhero"),
  # Application title
  titlePanel("成语接龙"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("idioms_id",label ="请输入查询的成语",value = "三心二意"),
      actionButton("update", "查询")
    ),
    # Show the result
    mainPanel(
      h3("查询结果:"),
      verbatimTextOutput("textPlot")
    )
  )
)

server <- function(input, output) {
  results <- eventReactive(input$update, {
    lookupIdioms(trimws(input$idioms_id),max_found = 5)
  })
  output$textPlot <- renderText(results())
}
# Run the application 
shinyApp(ui = ui, server = server)
