### rpivotTable:  pivottable for R

The rpivotTable package is an R [htmlwidget](http://htmlwidgets.org)  built around the [pivottable](http://nicolas.kruchten.com/pivottable/examples/)  library.

PivotTable.js is a Javascript Pivot Table library with drag'n'drop functionality built on top of jQuery/jQueryUI and  written in CoffeeScript by Nicolas Kruchten at Datacratic. It is available under an MIT license

#### Installation

The rpivotTable package depends on the development version of the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) package so you need to install both packages. You can do this using the **devtools** package as follows:

```R
devtools::install_github(c("ramnathv/htmlwidgets", "smartinsightsfromdata/rpivotTable"))
```

#### Usage

Just plug in your `data.frame` or `data.table` (e.g. dt) to `rpivotTable()`.

It is as simple as this:

```R
data(mtcars)
rpivotTable(mtcars)
```
The pivot table should appear in your RStudio Viewer or your browser of choice.

Please refer to the examples and explanations [here](https://github.com/nicolaskruchten/pivottable/wiki/Parameters). 

`rpivotTable` parameters decide how the pivot table will look like the firs time it is opened:

* `data` can be a `data.frame` or `data.table`. Nothing else is needed.  If only the data is selected the pivot table opens with nothing on rows and columns (but you can at any time drag and drop any variable in rows or columns at your leasure)
* `rows` and `cols` allow the user to create a report, i.e. to indicate which element will be on rows and columns.
* `aggregatorName` indicates the type of aggregation. Options here are numerous: Count, Count Unique Values, List Unique Values, Sum, Integer Sum, Average, Sum over Sum, 80% Upper Bound, 80% Lower Bound, Sum as Fraction of Total, Sum as Fraction of Rows, Sum as Fraction of Columns, Count as Fraction of Total, Count as Fraction of Rows, Count as Fraction of Columns
* `vals` specifies the variable to use with `aggregatorName`. 
* `renderers` dictates the type of graphic element used for display, like Table, Treemap etc.
* `sorters` allow to implement a javascript function to specify the ad hoc sorting of certain values. See vignette for an example. It is especially useful with time divisions like days of the week or months of the year (where the alphabetical order does not work)

For example, to display a pivot table with frequency of colour combinations of eyes and hair, you can specify:

```
data(HairEyeColor)
rpivotTable(data = HairEyeColor, rows = "Hair",cols="Eye", vals = "Freq", aggregatorName = "Sum", rendererName = "Table", width="100%", height="400px")
```

This will display a cross tab with the frequency of eyes by hair colour. Dragging & dropping (slicing & dicing) categorical variables in rows and columns changes the shape of the table.

If you want to include it as part of your `dplyr` / `magrittr` pipeline, you can do that also:

```R
library(dplyr)
iris %>%
tbl_df %>%
filter( Sepal.Width > 3 ) %>%
rpivotTable
```
