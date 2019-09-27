test_that("recode works", {

  x <- data.frame(
    id = 1:10,
    gender = sample(c("m", "f", "fe"), 10, replace = TRUE),
    labour = sample(c("employed, fulltime", "employed, part-time", "unemployed"), 10, replace = TRUE)
  )

  my_table <- data.frame(variable = c(rep("gender",3), rep("labour", 3)),
                         category = c("m", "f", "fe",
                                      "employed, fulltime", "employed, part-time", "unemployed"),
                         new_category = c("male", "female", "female",
                                          "employed", "employed", "unemployed"))

  x_new <- recodeR::recode(x = x, table = my_table, verbose = TRUE)

  expect_true(all(dim(x) == dim(x_new)))
  expect_true(all(names(x) == names(x_new)))
  expect_true(is.data.frame(x_new))
  expect_true(all(unique(x_new[["gender"]]) %in% c("male", "female")))
  expect_true(all(unique(x_new[["labour"]]) %in% c("employed", "unemployed")))
})
