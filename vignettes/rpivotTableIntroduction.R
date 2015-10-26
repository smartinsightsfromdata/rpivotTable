## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- fig.show='hold'----------------------------------------------------
# devtools::install_github(c("ramnathv/htmlwidgets", "smartinsightsfromdata/rpivotTable"))

## ---- fig.show='hold'----------------------------------------------------
library(rpivotTable)

## ---- fig.show='hold'----------------------------------------------------
data(mtcars)
rpivotTable(mtcars,rows="gear", cols=c("cyl","carb"),width="100%", height="400px")

## ------------------------------------------------------------------------
library(rpivotTable)
data(HairEyeColor)
rpivotTable(data = HairEyeColor, rows = "Hair",cols="Eye", vals = "Freq", aggregatorName = "Sum", rendererName = "Table", width="100%", height="400px")

## ------------------------------------------------------------------------
library(rpivotTable)
data(HairEyeColor)
rpivotTable(data = HairEyeColor, rows = "Hair",cols="Eye", vals = "Freq", aggregatorName = "Sum", rendererName = "Table", sorters = "
function(attr) { 
var sortAs = $.pivotUtilities.sortAs;
if (attr == \"Hair\") { return sortAs([\"Red\", \"Brown\", \"Blond\", \"Black\"]); }
}", width="100%", height="400px")

## ---- fig.show='hold'----------------------------------------------------
suppressMessages(library(dplyr))
iris %>%
tbl_df %>%
filter( Sepal.Width > 3 & Sepal.Length > 5 ) %>%
rpivotTable(rows="Sepal.Width",  rendererName="Treemap")

