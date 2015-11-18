library(rpivotTable)
library(shiny)

list_to_string <- function(obj, listname) {
  if (is.null(names(obj))) {
    paste(listname, "[[", seq_along(obj), "]] = ", obj,
          sep = "", collapse = "\n")
  } else {
    paste(listname, "$", names(obj), " = ", obj,
          sep = "", collapse = "\n")
  }
}

server <- function(input, output) {
  
output$pivotRefresh <- renderText({

cnames <- list("cols","rows","vals", "exclusions","inclusions", "aggregatorName", "rendererName")
# Apply a function to all keys, to get corresponding values
allvalues <- lapply(cnames, function(name) {
  item <- input$myPivotData[[name]]
  if (is.list(item)) {
    list_to_string(item, name)
  } else {
    paste(name, item, sep=" = ")
  }
})
paste(allvalues, collapse = "\n")
})

output$mypivot = renderRpivotTable({
    rpivotTable(
      Titanic,
      rows = "Survived",
      cols = c("Class","Sex"),
      aggregatorName = "Sum as Fraction of Columns",
      exclusions = list(
        Survived = list("No")
        # ,
        # Class = list("1st")
      ),
      vals = "Freq",
      rendererName = "Table Barchart",
      onRefresh=htmlwidgets::JS("function(config) { Shiny.onInputChange('myPivotData', config); }")
      )
  })
}

ui <- shinyUI(fluidPage(
  fluidRow(column(6,   verbatimTextOutput("pivotRefresh")),
           column(6, rpivotTableOutput("mypivot") ))
)
)

shinyApp(ui = ui, server = server)  
