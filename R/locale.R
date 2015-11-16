#' Localization
#' 
#' Change localization for \code{rpivotTable} to support non-English language.
#' For more discussion, see
#' \href{https://github.com/nicolaskruchten/pivottable/wiki/Localization}{pivottable Localization}.
#'
#' @param pivottable \code{rpivotTable} object to modify localization
#' @param locale \code{character} of locale to use.  Valid locale options are
#'         \itemize{
#'            \item{es}
#'            \item{fr}
#'            \item{nl}
#'            \item{pt}
#'            \item{tr}
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
  
  locale_dep <- htmltools::htmlDependency(
    name = sprintf("pivottable-%s",locale)
    ,version = "1.6.3"
    ,src = c(file=system.file("htmlwidgets/lib/pivottable/dist",package="rpivotTable"))
    ,script = sprintf("pivot.%s.min.js",locale)
  )
  
  if(length(pivottable$dependencies) == 0){
    pivottable$dependencies = list()
  }
  
  pivottable$dependencies[[length(pivottable$dependencies)+1]] <- locale_dep
  
  pivottable$x$locale <- locale
  
  return(pivottable)
}
