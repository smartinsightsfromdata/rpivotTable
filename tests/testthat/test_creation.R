context("creation")

test_that("rpivotTable is right class",{
  expect_is(rpivotTable(data.frame()),"htmlwidget")
  expect_is(rpivotTable(data.frame()),"rpivotTable")
})
