#' pivottable.js in R
#'
#' Use pivottable.js in R with the power and convenience of a
#' htmlwidget.
#'
#' @param data data.frame or data.table (R>=1.9.5 for safety) with data to use in the pivot table
#' @param rows String name of the column in the data.frame to prepopulate
#'              the \strong{rows} of the pivot table.
#' @param cols String name of the column in the data.frame to prepopulate
#'              the \strong{columns} of the pivot table.
#' @param aggregatorName String name of the pivottable.js aggregator (
#'              \href{https://github.com/nicolaskruchten/pivottable/wiki/Aggregators}{see Wiki for more details} )
#'              to prepopulate the pivot table.
#' @param vals String name of the column in the data.frame to use with \code{aggregatorName}. Must be additive (i.e a number)
#' @param rendererName String name specifying how the data will be rendered (e.g. Table, Treemap etc.) {see Wiki for more details}.
#' @param ... list other \href{https://github.com/nicolaskruchten/pivottable/wiki/Parameters}{parameters} that
#'              can be passed to \code{pivotUI}
#' @param width
#' @param height
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
    ...,
    width = NULL,
    height = NULL
) {

# check for data.frame, data.table. Array (and ftable) escluded as lacking proper column names
if( length(intersect(class(data),c("data.frame", "data.table" ))) == 0 ) {
stop( "data should be a data.frame or data.table", call.=F)
}


    params <- list(
      rows = rows,
      cols = cols,
      aggregatorName = aggregatorName,
      vals = vals,
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
#' @export
rpivotTableOutput <- function(outputId, width = '100%', height = '400px'){
    shinyWidgetOutput(outputId, 'rpivotTable', width, height, package = 'rpivotTable')
}

#' Widget render function for use in Shiny
#'
#' @export
renderRpivotTable <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) { expr <- substitute(expr) } # force quoted
    shinyRenderWidget(expr, rpivotTableOutput, env, quoted = TRUE)
}
