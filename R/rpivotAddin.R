getDataFrames = function()
{
    # ls(envir=.GlobalEnv)[sapply(ls(envir=.GlobalEnv), function(x){is.data.frame(get(x))})]
  if ((length(ls()) > 0) & (length(sapply(.GlobalEnv, is.data.frame)) > 0) & any(sapply(.GlobalEnv, is.data.frame)))
    return(names(which(sapply(.GlobalEnv, is.data.frame))))
  else
  {
    data(iris)
    return(names(which(sapply(.GlobalEnv, is.data.frame))))
  }
}

rpivotAddin <- function() {
  library(shiny)
  library(rpivotTable)
  library(miniUI)
  library(rstudioapi)

  ui <- miniPage(

    # css hack to provide space for a select input in the gadgetTitleBar
    tags$head(tags$style(HTML("
      .gadget-title .shiny-input-container {
        position: relative;
        height: 30px;
        margin: 6px 10px 0;
        z-index: 10;
      }"))),

    gadgetTitleBar("Pivot Table Gadget",
      left=miniTitleBarButton("done", "Done", primary=T),
      right=selectInput("dataset", NULL, choices = getDataFrames())),

    miniContentPanel(
      rpivotTableOutput("mypivot")
    )
  ) # minipage

  server <- function(input, output, session) {

    output$mypivot <- renderRpivotTable({
      rpivotTable(getSelectedDF())
    })

    observeEvent(input$done, {
      stopApp(TRUE)
    })

    getSelectedDF <- reactive({
      eval(parse(text = input$dataset))
    })

  } # server

  runGadget(shinyApp(ui, server), viewer = paneViewer())
}
