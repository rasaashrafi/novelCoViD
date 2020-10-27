
newdata <- Covid19Data()

test_that("Import data correctly", {
  expect_s3_class(newdata,"data.frame")
})


### number of columns of data set
test_that("number of columns of data set", {
  expect_equal(length(newdata),6)
})



