library(rpivotTable)
library(data.table)
library(shiny)

# canEldt <- fread(paste0("./inst/examples/", "canadaFctElections.csv"),header=T)
# save(canEldt,file="./inst/examples/canEldt.RData")
load(file="./inst/examples/canEldt.RData")

canEldt$votes <- round(runif(nrow(canEldt), min=500, max=15000))


ui = shinyUI(fluidPage(
  fluidRow(  column(2,sliderInput("integer", "Multiplier:",
                                  min=1, max=4, value=1)),
    column(8,
           rpivotTableOutput("pivot") )

)))

server = function(input, output, session) {

  ##
  output$pivot <- renderRpivotTable({
    if(!is.null(input$integer)) {
      mult <- input$integer
      val <- canEldt[[1, 6]]
      canEldt[[1, 6]] <- mult*val
    }
    rpivotTable(data =   canEldt   ,  rows = c( "Party",    "Province"),
                vals = "votes", aggregatorName = "Sum", rendererName = "Treemap")
  } )
}

shinyApp(ui = ui, server = server)
