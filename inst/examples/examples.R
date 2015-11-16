# tests/examples for rpivotTable
#   eventually make some of these official tests

# devtools::install_github("smartinsightswithdata/rpivotTable")
library(rpivotTable)

# use Titanic dataset provided in base R
# simple creation with just data
rpivotTable( Titanic )

# prepopulate a row
#   with one - need to make sure passed as array (auto_unbox = F)
rpivotTable( Titanic, rows = "Class" )
# prepopulate multiple rows
rpivotTable( Titanic, rows = c("Class","Sex" ) )
# prepopulate a column
rpivotTable( Titanic, rows = "Class", cols = "Survived" )
# prepopulate multiple columns and multiple rows
rpivotTable( Titanic, rows = c("Class","Sex"), cols = c("Age","Survived" ) )

# prepopulate aggregatorName and vals
rpivotTable(
  Titanic
  , rows = c("Class","Sex")
  , cols = "Survived"
  , aggregatorName = "Sum"
  , vals = "Freq"
)

#  prepopulate with an non-parameter (ie ...)
rpivotTable(
  Titanic
  , rows = c("Class","Sex","Age")
  , cols = "Survived"
  , aggregatorName = "Sum as Fraction of Rows"
  , vals = "Freq"

)

# just another neat example
rpivotTable(
  Titanic
  , rows = "Survived"
  , cols = c("Class","Sex")
  , aggregatorName = "Sum as Fraction of Columns"
  , vals = "Freq"
  , rendererName = "Table Barchart"
)


# let's use Titanic in frequency form now to test this
library(vcdExtra)

titanic_f <- expand.dft( Titanic )

# prepopulate a row
#   with one - need to make sure passed as array (auto_unbox = F)
rpivotTable( titanic_f, rows = "Class" )
# prepopulate multiple rows
rpivotTable( titanic_f, rows = c("Class","Sex" ) )
# prepopulate a column
rpivotTable( titanic_f, rows = "Class", cols = "Survived" )
# prepopulate multiple columns and multiple rows
rpivotTable( titanic_f, rows = c("Class","Sex"), cols = c("Age","Survived" ) )

# just another neat example
rpivotTable(
  titanic_f
  , rows = "Survived"
  , cols = c("Class","Sex")
  , aggregatorName = "Count"
  , rendererName = "Table Barchart"
)
# a check for above
structable(  Class + Sex~Survived, data = Titanic)

rpivotTable(
  titanic_f
  , rows = "Survived"
  , cols = c("Class","Sex")
  , aggregatorName = "Count as Fraction of Total"
  , rendererName = "Table Barchart"
)
prop.table(as.table(structable(  Survived~Class+Sex, data = Titanic)))


# try out d3 renderer
rpivotTable(
  titanic_f
  , rows = c("Survived","Class")
  # cols don't work with treemap
  , aggregatorName = "Count"
  , rendererName = "Treemap"
)


# change locale for non English use
ptbl <- rpivotTable(mtcars)
change_locale(ptbl, "pt")
