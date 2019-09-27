
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recodeR <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->

<!-- badges: end -->

The goal of recodeR is to make recoding super easy when you have a
mapping table. I often found myself using the `dplyr::case_when`
function for recoding and it can look super messy real fast when you
have a lot of categories to be recoded. Hence, recodeR was born\!

My primary use for this package is when I prepare a reference sample and
control tables for systhesising microdata. This is a common problem that
microsimulation modellers and agent-based modellers would face in the
data preparation phase.

## Installation

You can install this package using the following commands in R with the
`remotes` package.

``` r
remotes::install_github("asiripanich/recodeR")
```

## Example

This is a basic example which shows you how to solve a common problem
with recoding:

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
#> 1   1      f          unemployed
#> 2   2      m employed, part-time
#> 3   3      f  employed, fulltime
#> 4   4      m          unemployed
#> 5   5      f  employed, fulltime
#> 6   6      f  employed, fulltime
#> 7   7      f  employed, fulltime
#> 8   8     fe  employed, fulltime
#> 9   9      m employed, part-time
#> 10 10      m  employed, fulltime

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
#>  1:  1 female unemployed
#>  2:  2   male   employed
#>  3:  3 female   employed
#>  4:  4   male unemployed
#>  5:  5 female   employed
#>  6:  6 female   employed
#>  7:  7 female   employed
#>  8:  8 female   employed
#>  9:  9   male   employed
#> 10: 10   male   employed
```
