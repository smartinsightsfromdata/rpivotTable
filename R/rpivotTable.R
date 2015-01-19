#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
rpivotTable <- function(message = NULL, width = NULL, height = NULL) {

  # forward options using x
  x = message
#     list(
#     message = message
#   )

  # create widget
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
