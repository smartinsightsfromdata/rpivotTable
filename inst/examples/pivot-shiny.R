library(shiny)
require(magrittr)
require(dplyr)
<<<<<<< HEAD
library(rpivotTable)
=======
>>>>>>> FETCH_HEAD
#

jsontxt <- '[ {"Province": "Quebec", "Party": "NDP", "Age": 22, "Name": "Liu, Laurin", "Gender": "Female"},
{"Province": "Quebec", "Party": "Bloc Quebecois", "Age": 43, "Name": "Mourani, Maria", "Gender": "Female"},
{"Province": "Quebec", "Party": "NDP", "Age": "", "Name": "Sellah, Djaouida", "Gender": "Female"},
{"Province": "Quebec", "Party": "NDP", "Age": 72, "Name": "St-Denis, Lise", "Gender": "Female"},
{"Province": "British Columbia", "Party": "Liberal", "Age": 71, "Name": "Fry, Hedy", "Gender": "Female"},
{"Province": "Quebec", "Party": "NDP", "Age": 70, "Name": "Turmel, Nycole", "Gender": "Female"},
{"Province": "Ontario", "Party": "Liberal", "Age": 68, "Name": "Sgro, Judy", "Gender": "Female"},
{"Province": "Quebec", "Party": "NDP", "Age": 67, "Name": "Raynault, Francine", "Gender": "Female"},
{"Province": "Ontario", "Party": "Conservative", "Age": 66, "Name": "Davidson, Patricia", "Gender": "Female"},
{"Province": "Manitoba", "Party": "Conservative", "Age": 65, "Name": "Smith, Joy", "Gender": "Female"}]'

<<<<<<< HEAD
validate(jsontxt)
jsdf_ <- jsonlite::fromJSON(jsontxt)
jsdf_$Age <- as.numeric(jsdf_$Age)

=======
# jsontxt <- '[ {"Province": "Quebec", "Party": "NDP", "Age": 22, "Name": "Liu, Laurin", "Gender": "Female"} ]'

validate(jsontxt)
jsdf_ <- jsonlite::fromJSON(jsontxt)
jsdf_$Age <- as.numeric(jsdf_$Age)
# jsdl1_ <- RJSONIO::fromJSON(jsontxt)
# jsdl1_[[1]]
>>>>>>> FETCH_HEAD




ui = shinyUI(fluidPage(
<<<<<<< HEAD
  fluidRow(  column(2,sliderInput("integer", "Multiplier:",
                                  min=1, max=5, value=1)),
    column(8,
           rpivotTableOutput("pivot") )
=======
  fluidRow(  column(3,sliderInput("integer", "Multiplier:",
                                  min=1, max=5, value=1)),
    column(6,
  rpivotTable::rpivotTableOutput('pie'))
>>>>>>> FETCH_HEAD

)))

server = function(input, output, session) {

##
<<<<<<< HEAD
  output$pivot <- renderRpivotTable({
=======
  output$pie <- renderRpivotTable({
>>>>>>> FETCH_HEAD
    if(!is.null(input$integer)) {
      mult <- input$integer
      val <- jsdf_[1, 3]
      jsdf_[1, 3] <- mult*val
    }
<<<<<<< HEAD

    rpivotTable(jsdf_)
=======
    jsdata <- lapply(1:nrow(jsdf_), function(i) {
      l_ <- as.list(jsdf_[i, ])
      return(l_)})

    rpivotTable(jsdata)
>>>>>>> FETCH_HEAD
 } )
}


shinyApp(ui = ui, server = server)
