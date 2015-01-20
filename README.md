### rpivotTable:  pivottable for R

The rpivotTable package is an R interface to the [pivottable](http://nicolas.kruchten.com/pivottable/examples/)  library.

PivotTable.js is a Javascript Pivot Table library with drag'n'drop functionality built on top of jQuery/jQueryUI and originally written in CoffeeScript by Nicolas Kruchten at Datacratic. It is available under an MIT license

#### Installation

The rpivotTable package depends on the development version of the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) package so you need to install both packages. You can do this using the **devtools** package as follows:

```S
devtools::install_github(c("ramnathv/htmlwidgets", "smartinsightsfromdata/rpivotTable"))
```

#### Usage

If you have a data.frame or data.table (e.g. dt), a mix of categorical and numeric columns will do (pivottable has off-the-shelf count and distinct count). It is as simple as this:

```R
rpivotTable(dt)
```

See the examples in ./inst/examples.
