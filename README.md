
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

str(out)
#> List of 1
#>  $ :List of 9
#>   ..$ data       :'data.frame':  32 obs. of  11 variables:
#>   .. ..$ mpg : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#>   .. ..$ cyl : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
#>   .. ..$ disp: num [1:32] 160 160 108 258 360 ...
#>   .. ..$ hp  : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
#>   .. ..$ drat: num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#>   .. ..$ wt  : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
#>   .. ..$ qsec: num [1:32] 16.5 17 18.6 19.4 17 ...
#>   .. ..$ vs  : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
#>   .. ..$ am  : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
#>   .. ..$ gear: num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
#>   .. ..$ carb: num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
#>   ..$ layers     :List of 1
#>   .. ..$ :Classes 'LayerInstance', 'Layer', 'ggproto', 'gg' <ggproto object: Class LayerInstance, Layer, gg>
#>     aes_params: list
#>     compute_aesthetics: function
#>     compute_geom_1: function
#>     compute_geom_2: function
#>     compute_position: function
#>     compute_statistic: function
#>     data: waiver
#>     draw_geom: function
#>     finish_statistics: function
#>     geom: <ggproto object: Class GeomPoint, Geom, gg>
#>         aesthetics: function
#>         default_aes: uneval
#>         draw_group: function
#>         draw_key: function
#>         draw_layer: function
#>         draw_panel: function
#>         extra_params: na.rm
#>         handle_na: function
#>         non_missing_aes: size shape colour
#>         optional_aes: 
#>         parameters: function
#>         required_aes: x y
#>         setup_data: function
#>         use_defaults: function
#>         super:  <ggproto object: Class Geom, gg>
#>     geom_params: list
#>     inherit.aes: TRUE
#>     layer_data: function
#>     map_statistic: function
#>     mapping: uneval
#>     position: <ggproto object: Class PositionIdentity, Position, gg>
#>         compute_layer: function
#>         compute_panel: function
#>         required_aes: 
#>         setup_data: function
#>         setup_params: function
#>         super:  <ggproto object: Class Position, gg>
#>     print: function
#>     setup_layer: function
#>     show.legend: NA
#>     stat: <ggproto object: Class StatIdentity, Stat, gg>
#>         aesthetics: function
#>         compute_group: function
#>         compute_layer: function
#>         compute_panel: function
#>         default_aes: uneval
#>         extra_params: na.rm
#>         finish_layer: function
#>         non_missing_aes: 
#>         parameters: function
#>         required_aes: 
#>         retransform: TRUE
#>         setup_data: function
#>         setup_params: function
#>         super:  <ggproto object: Class Stat, gg>
#>     stat_params: list
#>     super:  <ggproto object: Class Layer, gg> 
#>   ..$ scales     :Classes 'ScalesList', 'ggproto', 'gg' <ggproto object: Class ScalesList, gg>
#>     add: function
#>     clone: function
#>     find: function
#>     get_scales: function
#>     has_scale: function
#>     input: function
#>     n: function
#>     non_position_scales: function
#>     scales: list
#>     super:  <ggproto object: Class ScalesList, gg> 
#>   ..$ mapping    : Named list()
#>   .. ..- attr(*, "class")= chr "uneval"
#>   ..$ theme      : list()
#>   ..$ coordinates:Classes 'CoordCartesian', 'Coord', 'ggproto', 'gg' <ggproto object: Class CoordCartesian, Coord, gg>
#>     aspect: function
#>     backtransform_range: function
#>     clip: on
#>     default: TRUE
#>     distance: function
#>     expand: TRUE
#>     is_free: function
#>     is_linear: function
#>     labels: function
#>     limits: list
#>     modify_scales: function
#>     range: function
#>     render_axis_h: function
#>     render_axis_v: function
#>     render_bg: function
#>     render_fg: function
#>     setup_data: function
#>     setup_layout: function
#>     setup_panel_params: function
#>     setup_params: function
#>     transform: function
#>     super:  <ggproto object: Class CoordCartesian, Coord, gg> 
#>   ..$ facet      :Classes 'FacetNull', 'Facet', 'ggproto', 'gg' <ggproto object: Class FacetNull, Facet, gg>
#>     compute_layout: function
#>     draw_back: function
#>     draw_front: function
#>     draw_labels: function
#>     draw_panels: function
#>     finish_data: function
#>     init_scales: function
#>     map_data: function
#>     params: list
#>     setup_data: function
#>     setup_params: function
#>     shrink: TRUE
#>     train_scales: function
#>     vars: function
#>     super:  <ggproto object: Class FacetNull, Facet, gg> 
#>   ..$ plot_env   :<environment: 0x0000000015727b18> 
#>   ..$ labels     :List of 2
#>   .. ..$ x: chr "mpg"
#>   .. ..$ y: chr "disp"
#>   ..- attr(*, "class")= chr [1:2] "gg" "ggplot"
```
