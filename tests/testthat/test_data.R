context("Data")

library(dplyr)

test_that("data is checked",{
  expect_error(rpivotTable( data= NULL ) )
  expect_error(rpivotTable( 1:20 ))
  expect_error(rpivotTable( matrix(1:20,ncol=2) ))
})

test_that("data is converted",{
  expect_is(rpivotTable( Titanic )$x$data,  "data.frame")
  expect_warning(rpivotTable( data.table(iris) ))
  expect_is(suppressWarnings(rpivotTable( data.table(iris) ))$x$data, "data.frame")
  expect_is(rpivotTable( data.frame(x=1:10,y=1:10) )$x$data, "data.frame")
})

test_that("data is not changed",{
  expect_identical(
    rpivotTable( data.frame(x=1:10,y=LETTERS[1:10]) )$x$data
    , data.frame(x=1:10,y=LETTERS[1:10]))
  expect_is(
    rpivotTable(tbl_df(iris))$x$data
    , "tbl_df"
  )
})
