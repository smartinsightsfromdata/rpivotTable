#' pivottable.js in R
#'
#' Use pivottable.js in R with the power and convenience of a
#' htmlwidget.
#'
#' @param data data.frame or data.table (R>=1.9.6 for safety) with data to use in the pivot table
#' @param rows String name of the column in the data.frame to prepopulate
#'              the \strong{rows} of the pivot table.
#' @param cols String name of the column in the data.frame to prepopulate
#'              the \strong{columns} of the pivot table.
#' @param aggregatorName String name of the pivottable.js aggregator to prepopulate the pivot table.
#' @param vals String name of the column in the data.frame to use with \code{aggregatorName}. Must be additive (i.e a number).
#' @param rendererName List name of the renderer selected, e.g. Table, Heatmap, Treemap etc.
#' @param sorter String name this allows to implement a javascript function to specify the ad hoc sorting of certain values. See vignette for an example.
#'              It is especially useful with time divisions like days of the week or months of the year (where the alphabetical order does not work).
#' @param inclusions List this optional parameter allows to filter the members of a particular dimension "by inclusion". 
#'              Using the 'Titanic' example, to display only the "Crew" member in the "Class" dimension, it is convenient to filter by inclusion using `inclusions=list(Class="Crew")`.
#'              Please note that this only pre-selects the visible filter(s) on the pivot table: the other dimension members are still availabe for selection if needed.
#' @param exclusions String this optional parameter allows to filter the members of a particular dimension "by exclusion". 
#'              Using the 'Titanic' example, to display only the "1st", "2nd" and "3rd" members in the "Class" dimension, it is convenient to filter by exclusion using `exclusions=list(Class="Crew")`.
#'              Please note that this only pre-selects the visible filter(s) on the pivot table: the other dimension members are still availabe for selection if needed. 
#' @param width width parameter
#' @param height height parameter
#' 
#' @param ... list other \href{https://github.com/nicolaskruchten/pivottable/wiki/Parameters}{parameters} that
#'            can be passed to \code{pivotUI}. See Nicolas's Wiki for more details.
#'            A further example of parameter is onRefresh. This parameters (shiny-only) introduces a JS function that allows to get back server side the list of parameters selected by the user.
#'            An example is: onRefresh=htmlwidgets::JS("function(config) { Shiny.onInputChange('myPivotData', config); }")
#'            This setting makes available server-side a function input$myPivotData that gives back a list (of lists) with all the slice & dice parameters offered by pivottable.
#'            See the example onRefresh-shiny.R for an example of how to use this feature.  
#'            Example of usage could be:
#'            These parameters could be saved and re-sent to the user.
#'            Alternative they could be used to subset the data item for saving as csv.
#'              
#' @examples 
#' 
#'  # use Titanic dataset provided in base R - simple creation with just data
#'
#'  rpivotTable( Titanic ) 
#'
#'  # prepopulate multiple columns and multiple rows
#'  
#'  rpivotTable( Titanic, rows = c("Class","Sex"), cols = c("Age","Survived" ) )
#'  
#'  
#'  # A more complete example:
#'  
#'  rpivotTable(
#'  Titanic,
#'  rows = "Survived",
#'  cols = c("Class","Sex"),
#'  aggregatorName = "Sum as Fraction of Columns",
#'  vals = "Freq",
#'  rendererName = "Table Barchart"
#'  )
#'
#' # An example with inclusions and exclusions filters:
#' 
#' rpivotTable(
#' Titanic,
#' rows = "Survived",
#' cols = c("Class","Sex"),
#' aggregatorName = "Sum as Fraction of Columns",
#' inclusions = list( Survived = list("Yes")),
#' exclusions= list( Class = list( "Crew")),
#' vals = "Freq",
#' rendererName = "Table Barchart"
#' )
#'
#'
#'
#'
#' @import htmlwidgets
#'
#' @export

rpivotTable <- function(
    data,
    rows = NULL,
    cols = NULL,
    aggregatorName = NULL,
    vals = NULL,
    rendererName = NULL,
    sorter = NULL,
    exclusions = NULL,
    inclusions = NULL,
    ...,
    width = NULL,
    height = NULL
) {
  # check for data.frame, data.table, or array
  if( length(intersect(class(data),c("data.frame", "data.table", "table","structable", "ftable" ))) == 0 ) {
    stop( "data should be a data.frame, data.table, or table", call.=F)
  }
  
  #convert table to data.frame
  if( length(intersect(c("table","structable", "ftable"), class(data))) > 0 ) data <- as.data.frame( data )

    params <- list(
      rows = rows,
      cols = cols,
      aggregatorName = aggregatorName,
      vals = vals,
      rendererName = rendererName,
      sorter = sorter,
      ...
    )

 #   auto_box vectors of length 1
    params <- Map( function(p){
        if(length(p) == 1 ){
          p = list(p)
        }
        return(p)
      }
      , params
    )
    # exlusions & inclusions need to be "excluded" from auto_boxing
  par <- list(
           exclusions = exclusions,
           inclusions = inclusions 
         )

params <- c(params, par)

    # remove NULL parameters
    params <- Filter(Negate(is.null), params)
    
    x <- list(
      data = data,
      params = params
    )

    htmlwidgets::createWidget(
      name = 'rpivotTable',
      x,
      width = width,
      height = height,
      package = 'rpivotTable'
    )
}

#' Widget output function for use in Shiny
#'
#' @param outputId Shiny output ID
#' @param width width default '100\%'
#' @param height height default '500px'
#' 
#' @examples 
#' 
#'   # A simple example - this goes in the ui part of a shiny application
#'   
#'   # rpivotTableOutput("pivot")
#' 
#' 
#' @export
rpivotTableOutput <- function(outputId, width = '100%', height = '500px'){
    shinyWidgetOutput(outputId, 'rpivotTable', width, height, package = 'rpivotTable')
}

#' Widget render function for use in Shiny
#'
#' @param expr rpivotTable expression
#' @param env environment
#' @param quoted logical, default = FALSE
#' 
#' @examples 
#' 
#'   # A simple example - this goes in the server part of a shiny application
#'   
#'   # output$pivot <- renderRpivotTable({
#'   #          rpivotTable(data =   canadianElections   ,  rows = c( "Province"),cols="Party",
#'   #          vals = "votes", aggregatorName = "Sum", rendererName = "Table",
#'   #          width="100%", height="500px")
#'   # })
#' 
#' 
#' 
#' @export
renderRpivotTable <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) { expr <- substitute(expr) } # force quoted
    shinyRenderWidget(expr, rpivotTableOutput, env, quoted = TRUE)
}


NULL
