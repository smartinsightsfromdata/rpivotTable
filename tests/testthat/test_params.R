context("parameters")

test_that("parameters handled correctly",{
  expect_match(
    rpivotTable(data.frame(),rows = c("arow"))$x$params$rows
    ,"arow"
  )
  # one row or column should be made list so will be boxed for JSON
  expect_is(
    rpivotTable(data.frame(),rows = c("arow"))$x$params$rows
    ,"list"
  )
  expect_match(
    rpivotTable(data.frame(),rows = c("arow"))$x$params$rows
    ,"arow"
  )
  expect_identical(
    rpivotTable(data.frame(),rows = c("arow","anotherRow"))$x$params$rows
    ,c("arow","anotherRow")
  )

  expect_is(
    rpivotTable(data.frame(),cols = c("acol"))$x$params$cols
    ,"list"
  )
  expect_match(
    rpivotTable(data.frame(),cols = c("acol"))$x$params$cols
    ,"acol"
  )
  expect_identical(
    rpivotTable(data.frame(),cols = c("acol","anothercol"))$x$params$cols
    ,c("acol","anothercol")
  )

  expect_match(
    rpivotTable(data.frame(),aggregatorName="Sum")$x$params$aggregatorName
    ,"Sum"
  )

  expect_is(
    rpivotTable(data.frame(),vals="aval")$x$params$vals
    ,"list"
  )
  expect_match(
    rpivotTable(data.frame(),vals="aval")$x$params$vals
    ,"aval"
  )
})
