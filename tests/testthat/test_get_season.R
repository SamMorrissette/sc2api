with_mock_api({
  test_that("get_season returns list with season information", {
  skip_on_cran()

  data <- get_season(1,"us")
  expect_true(is.list(data))
  expect_true(length(data) >= 1)
  })
})
