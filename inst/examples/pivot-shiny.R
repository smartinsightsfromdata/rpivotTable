library(shiny)
require(magrittr)
require(dplyr)
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

# jsontxt <- '[ {"Province": "Quebec", "Party": "NDP", "Age": 22, "Name": "Liu, Laurin", "Gender": "Female"} ]'

validate(jsontxt)
jsdf_ <- jsonlite::fromJSON(jsontxt)
jsdf_$Age <- as.numeric(jsdf_$Age)
# jsdl1_ <- RJSONIO::fromJSON(jsontxt)
# jsdl1_[[1]]




ui = shinyUI(fluidPage(
  fluidRow(  column(3,sliderInput("integer", "Multiplier:",
                                  min=1, max=5, value=1)),
    column(6,
  rpivotTable::rpivotTableOutput('pie'))

)))

server = function(input, output, session) {

##
  output$pie <- renderRpivotTable({
    if(!is.null(input$integer)) {
      mult <- input$integer
      val <- jsdf_[1, 3]
      jsdf_[1, 3] <- mult*val
    }
    jsdata <- lapply(1:nrow(jsdf_), function(i) {
      l_ <- as.list(jsdf_[i, ])
      return(l_)})

    rpivotTable(jsdata)
 } )
}


shinyApp(ui = ui, server = server)
