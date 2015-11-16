context("locale")

test_that("locale changed as expected",{
  # dependency added
  expect_match(
    change_locale(rpivotTable(data.frame()),"pt")$dependencies[[1]]$name
    ,"pivottable-pt"
  )
  # locale changed in x
  expect_match(
    change_locale(rpivotTable(data.frame()),"pt")$x$locale
    ,"pt"
  )
})

