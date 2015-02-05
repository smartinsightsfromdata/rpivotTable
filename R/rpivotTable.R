#' pivottable.js in R
#'
#' Use pivottable.js in R with the power and convenience of a
#' htmlwidget.
#'
#' @param data data.frame with data to use in the pivot table
#' @param rows String name of the column in the data.frame to prepopulate
#'              the \strong{rows} of the pivot table.
#' @param cols String name of the column in the data.frame to prepopulate
#'              the \strong{columns} of the pivot table.
#' @param aggregatorName String name of the pivottable.js aggregator (
#'              \href{https://github.com/nicolaskruchten/pivottable/wiki/Aggregators}{see Wiki for more details} )
#'              to prepopulate the pivot table.
#' @param vals String name of the column in the data.frame to use with \code{aggregatorName}.
#' @param width
#' @param height
#'
#' @import htmlwidgets
#'
#' @export

rpivotTable <- function(
    data = NULL,
    rows = NULL,
    cols = NULL,
    aggregatorName = NULL,
    vals = NULL,
    width = NULL,
    height = NULL
) {

    params <-
        list(
            rows = list(rows),
            cols = list(cols),
            vals = list(vals),
            aggregatorName = list(aggregatorName)
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
