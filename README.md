
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recodeR

<!-- badges: start -->

<!-- badges: end -->

The goal of recodeR is to make recoding super easy when you have a
pre-defined mapping table. I often found myself using the
dplyr::case\_when function in data prepation and it can look super messy
real fast when you have a lot of categories to be recoded. Hence,
recodeR was born\!

## Installation

You can install this package using the following commands in R with the
`remote` package.

``` r
remotes::install_github("asiripanich/recodeR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(recodeR)
## basic example code

x <- data.frame(
    id = 1:10,
    gender = sample(c("m", "f", "fe"), 10, replace = TRUE),
    labour = sample(c("employed, fulltime", "employed, part-time", "unemployed"), 10, replace = TRUE)
  )
print(x)
#>    id gender              labour
#> 1   1      m          unemployed
#> 2   2      f employed, part-time
#> 3   3      f          unemployed
#> 4   4     fe employed, part-time
#> 5   5      f          unemployed
#> 6   6     fe          unemployed
#> 7   7      m          unemployed
#> 8   8     fe  employed, fulltime
#> 9   9     fe  employed, fulltime
#> 10 10     fe employed, part-time

my_table <- data.frame(variable = c(rep("gender",3), rep("labour", 3)),
                       category = c("m", "f", "fe",
                                    "employed, fulltime", "employed, part-time", "unemployed"),
                       new_category = c("male", "female", "female",
                                        "employed", "employed", "unemployed"))
print(my_table)
#>   variable            category new_category
#> 1   gender                   m         male
#> 2   gender                   f       female
#> 3   gender                  fe       female
#> 4   labour  employed, fulltime     employed
#> 5   labour employed, part-time     employed
#> 6   labour          unemployed   unemployed

x_new <- recodeR::recode(x = x, table = my_table, verbose = TRUE)
#> there are 2 variables
#> recoding.. gender.
#> recoding.. gender from 'm' to 'male'
#> recoding.. gender from 'f' to 'female'
#> recoding.. gender from 'fe' to 'female'
#> recoding.. labour.
#> recoding.. labour from 'employed, fulltime' to 'employed'
#> recoding.. labour from 'employed, part-time' to 'employed'
#> recoding.. labour from 'unemployed' to 'unemployed'
print(x_new)
#>     id gender     labour
#>  1:  1   male unemployed
#>  2:  2 female   employed
#>  3:  3 female unemployed
#>  4:  4 female   employed
#>  5:  5 female unemployed
#>  6:  6 female unemployed
#>  7:  7   male unemployed
#>  8:  8 female   employed
#>  9:  9 female   employed
#> 10: 10 female   employed
```
