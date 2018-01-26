context("locale")

test_that("locale changed as expected",{
  # locale changed in x
  expect_match(
    change_locale(rpivotTable(data.frame()),"pt")$x$locale
    ,"pt"
  )
})

