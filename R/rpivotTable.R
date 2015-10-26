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
#' @param rendererName String name of the renderer selected, e.g. Table, Heatmap, Treemap etc.
#' @param sorter String name this allows to implement a javascript function to specify the ad hoc sorting of certain values. See vignette for an example.
#'              It is especially useful with time divisions like days of the week or months of the year (where the alphabetical order does not work).
#' @param width width parameter
#' @param height height parameter
#' 
#' @param ... list other \href{https://github.com/nicolaskruchten/pivottable/wiki/Parameters}{parameters} that
#'              can be passed to \code{pivotUI}. See Nicolas's Wiki for more details.
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
    sorter = NULL,
    rendererName = NULL,
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
      sorter = NULL,
      rendererName = NULL,
      ...
    )

    # remove NULL parameters
    params <- Filter(Negate(is.null), params)

    # auto_box vectors of length 1
    params <- Map( function(p){
        if(length(p) == 1){
          p = list(p)
        }
        return(p)
      }
      , params
    )

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
#' @export
rpivotTableOutput <- function(outputId, width = '100%', height = '500px'){
    shinyWidgetOutput(outputId, 'rpivotTable', width, height, package = 'rpivotTable')
}

#' Widget render function for use in Shiny
#'
#' @param expr rpivotTable expression
#' @param env environment
#' @param quoted logical, default = FALSE
#' @export
renderRpivotTable <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) { expr <- substitute(expr) } # force quoted
    shinyRenderWidget(expr, rpivotTableOutput, env, quoted = TRUE)
}


NULL
