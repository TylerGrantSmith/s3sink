
<!-- README.md is generated from README.Rmd. Please edit that file -->

# s3sink

<!-- badges: start -->

[![R build
status](https://github.com/TylerGrantSmith/s3sink/workflows/R-CMD-check/badge.svg)](https://github.com/TylerGrantSmith/s3sink)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("TylerGrantSmith/s3sink")
```

## Example

``` r
library(s3sink)

plotting_function <- function() {
  g <- ggplot2::ggplot(mtcars) + ggplot2::geom_point(ggplot2::aes(mpg, disp))
  print(g)
  invisible(NULL)
}

sink_s3("print.ggplot", "ggplot2")
plotting_function()
#> Registered S3 method overwritten by 'ggplot2':
#>   method       from
#>   print.ggplot
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
out <- unsink_s3("print.ggplot")

str(out, 1)
#> List of 1
#>  $ :List of 9
#>   ..- attr(*, "class")= chr [1:2] "gg" "ggplot"
```
