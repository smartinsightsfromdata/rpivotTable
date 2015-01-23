### rpivotTable:  pivottable for R

The rpivotTable package is an R interface to the [pivottable](http://nicolas.kruchten.com/pivottable/examples/)  library.

PivotTable.js is a Javascript Pivot Table library with drag'n'drop functionality built on top of jQuery/jQueryUI and originally written in CoffeeScript by Nicolas Kruchten at Datacratic. It is available under an MIT license

#### Installation

The rpivotTable package depends on the development version of the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) package so you need to install both packages. You can do this using the **devtools** package as follows:

```R
devtools::install_github(c("ramnathv/htmlwidgets", "smartinsightsfromdata/rpivotTable"))
```

#### Usage

If you have a data.frame or data.table (e.g. dt), a mix of categorical and numeric columns will do (pivottable has off-the-shelf count and distinct count, so only categorical variable will work). 

It is as simple as this:

```R
rpivotTable(data, rows, cols, vals, aggregatorName, width, height)
```
Please refer to the examples and explanations [here](https://github.com/nicolaskruchten/pivottable/wiki/Parameters). 

Simply put the parameters decide how the pivot table will look like the firs time it is open:

* data can be a data.frame or data.table. Nothing else is needed.  If only the data is selcted the pivot table opens with nothing on rows and columns (but you can at any time drag and drop any variable in rows and columns at your leasure)
* rows and cols allow the user to create a report, i.e. to indicate which elemnt will be on rows and columns.
* aggregatorName indicates the type of aggregation. It is associated to vals.  

For example, to display a data.table dt with election data (similar to the example on pivottable site), you can specify:

```R
rpivotTable(data = dt, rows = "Party", cols = "Province", vals = "votes", aggregatorName = "Sum")
```

This will display the sum of votes per Party and Province.
