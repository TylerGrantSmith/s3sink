test_that("remove_s3_override ignores non-registered methods", {
  expect_null(remove_s3_override("this_name_certainly_is_not_used"))
})

test_that("remove_s3_override ignores non-overridden registered s3 methods", {
  expect_null(remove_s3_override("print.data.frame"))
})

