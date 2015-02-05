# tests/examples for rpivotTable
#   eventually make some of these official tests

# devtools::install_github("smartinsightswithdata/rpivotTable")
library(rpivotTable)

# use Titanic dataset provided in base R
titanic_df = as.data.frame(Titanic)

# simple creation with just data
rpivotTable( titanic_df )

# prepopulate a row
#   with one - need to make sure passed as array (auto_unbox = F)
rpivotTable( titanic_df, rows = "Class" )
# prepopulate multiple rows
rpivotTable( titanic_df, rows = c("Class","Sex" ) )
# prepopulate a column
rpivotTable( titanic_df, rows = "Class", columns = "Survived" )
