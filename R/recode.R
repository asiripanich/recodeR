#' Recode variables based on a pre-defined mapping table.
#'
#' @param x a data.frame
#' @param table a data.frame with three columns: variable, category, new_category
#'
#' @return a recoded data.frame.
#' @export
#'
#' @examples
#'
#' # the main data frame to be recoded
#' x <- data.frame(
#'   id = 1:10,
#'   gender = sample(c("m", "f", "fe"), 10, replace = TRUE),
#'   labour = sample(c("employed, fulltime", "employed, part-time", "unemployed"), 10, replace = TRUE)
#' )
#'
#' # create a mapping table
#' my_table <- data.frame(variable = c(rep("gender",3), rep("labour", 3)),
#'                        category = c("m", "f", "fe",
#'                                     "employed, fulltime", "employed, part-time", "unemployed"),
#'                        new_category = c("male", "female", "female",
#'                                         "employed", "employed", "unemployed"))
#'
#' x_new <- recodeR::recode(x = x, table = my_table, verbose = TRUE)
recode <- function(x, table, verbose = TRUE) {

  if (!is.data.frame(x)) {
    stop("x must be a data.frame object.")
  }

  if (!is.data.frame(table)) {
    stop("table must be a data.frame object.")
  }

  x <- as.data.table(x) %>%
    data.table::copy(.) %>%
    .[, lapply(.SD, function(var){if (is.factor(var)) as.character(var) else var})]

  table <- as.data.table(table) %>%
    data.table::copy(.) %>%
    .[, lapply(.SD, function(var){if (is.factor(var)) as.character(var) else var})]

  if (!all(names(table) %in% c("variable", "category", "new_category"))) {
    stop("table must have these columns {variable, category, new_category}")
  }

  vars <- table[, unique(variable)][table[, unique(variable)] %in% names(x)]

  if (verbose) message(glue("there are {length(vars)} variables"))

  for (var in vars) {
    if (verbose) message(glue("recoding.. {(var)}."))
    cats <- table[variable == var, category]
    new_cats <- table[variable == var, new_category]
    for (i in seq_along(cats)) {
      if (verbose) message(glue("recoding.. {var} from '{cats[i]}' to '{new_cats[i]}'"))
      var_x <- x[[var]]
      x[var_x == cats[[i]], c(var) := new_cats[[i]]]
    }
  }

  x
}
