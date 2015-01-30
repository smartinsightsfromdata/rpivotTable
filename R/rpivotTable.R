#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
##'
##' @title 
##' @param data 
##' @param rows 
##' @param cols 
##' @param vals 
##' @param aggregatorName 
##' @param width 
##' @param height 
##' @return 
##' @author Enzo Martoglio
rpivotTable <- function(
    data = NULL,
    rows = NULL,
    cols = NULL,
    vals = NULL,
    aggregatorName = NULL,
    width = NULL,
    height = NULL) {

    params <-
        list(
            rows = list(rows),
            cols = list(cols),
            vals = list(vals),
            aggregatorName = list(aggregatorName)
        )

    x <- list(
        data = data,
        param = params
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
