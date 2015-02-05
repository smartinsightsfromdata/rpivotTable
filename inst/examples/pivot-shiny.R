library(shiny)
require(magrittr)
require(dplyr)
library(rpivotTable)

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

# validate(jsontxt)

jsdf_ <- jsonlite::fromJSON(jsontxt)
jsdf_$votes <- round(runif(10, min=5000, max=15000))
jsdf_$avAge <- as.numeric(jsdf_$Age)
jsdf_$Age <- jsdf_$Name <- jsdf_$Gender <- NULL

ui = shinyUI(fluidPage(
  fluidRow(  column(2,sliderInput("integer", "Multiplier:",
                                  min=1, max=5, value=1)),
    column(8,
           rpivotTableOutput("pivot") )

)))

server = function(input, output, session) {

  ##
  output$pivot <- renderRpivotTable({
    if(!is.null(input$integer)) {
      mult <- input$integer
      val <- jsdf_[1, 3]
      jsdf_[1, 3] <- mult*val
    }

    rpivotTable(data = jsdf_, rows = "Party", cols = "Province", vals = "votes", aggregatorName = "Sum")
  } )
}

shinyApp(ui = ui, server = server)
