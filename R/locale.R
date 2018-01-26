#' Localization
#'
#' Change localization for \code{rpivotTable} to support non-English language.
#' For more discussion, see
#' \href{https://github.com/nicolaskruchten/pivottable/wiki/Localization}{pivottable Localization}.
#'
#' @param pivottable \code{rpivotTable} object to modify localization
#' @param locale \code{character} of locale to use.  Valid locale options are
#'         \itemize{
#'            \item{cs}
#'            \item{da}
#'            \item{de}
#'            \item{es}
#'            \item{fr}
#'            \item{it}
#'            \item{nl}
#'            \item{pl}
#'            \item{pt}
#'            \item{ru}
#'            \item{sq}
#'            \item{tr}
#'            \item{zh}
#'         }
#'
#'
#' @return \code{rpivotTable} object
#' @export
#' @examples
#'    library(rpivotTable)
#'    change_locale(rpivotTable(mtcars),"pt")


change_locale <- function(
  pivottable = NULL, locale = NULL
) {
  if(!inherits(pivottable,"rpivotTable")) stop("pivottable should be a rpivotTable.",call.=F)

  pivottable$x$locale <- locale

  return(pivottable)
}
