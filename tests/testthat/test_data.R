context("Data")

library(dplyr)
library(data.table)

test_that("data is checked",{
  expect_error(rpivotTable( data= NULL ) )
  expect_error(rpivotTable( 1:20 ))
  expect_error(rpivotTable( matrix(1:20,ncol=2) ))
})

test_that("data is converted appropriately",{
  expect_is(rpivotTable( data.table(mtcars) )$x$data, "data.table")
  expect_is(rpivotTable( data.frame(x=1:10,y=1:10) )$x$data, "data.frame")
  expect_is(rpivotTable( Titanic )$x$data,  "data.frame")
})

test_that("data is not changed",{
  expect_identical(
    rpivotTable( data.frame(x=1:10,y=LETTERS[1:10]) )$x$data
    , data.frame(x=1:10,y=LETTERS[1:10]))
  expect_is(
    rpivotTable(tbl_df(iris))$x$data
    , "tbl_df"
  )
  expect_identical(
    rpivotTable( data.table(mtcars) )$x$data
    , data.table(mtcars)
  )
})

