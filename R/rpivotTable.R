#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export

rpivotTable <- function(data = NULL, rows = NULL, cols = NULL, vals = NULL, aggregatorName = NULL,
                        width = NULL, height = NULL) {

  # df_ <- iris[1:2,]
  # forward options using x
#   Data <- lapply(1:nrow(df_), function(i) {
#     l_ <- as.list(df_[i, ])
#     return(l_)})


params <- list( rows = list(rows),
                cols = list(cols),
                vals = list(vals),
                aggregatorName = list(aggregatorName))

x <- list(data = data,param = params)

# RJSONIO::toJSON(x)




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
