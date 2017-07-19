#' @keywords internal
subtotal_dep <- function() {
  htmltools::htmlDependency(
    name = "pivottable-subtotal-renderer",
    version = "1.9.0",
    src = c(
      file = system.file(
        "./htmlwidgets/lib/pivottable-subtotal-renderer",
        package = "rpivotTable"
      )
    ),
    script = "subtotal.min.js",
    stylesheet = "subtotal.min.css"
  )
}
