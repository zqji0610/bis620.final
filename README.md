<!-- README.md is generated from README.Rmd. Please edit that file -->

# bis620.final

<!-- badges: start -->

[![R-CMD-check](https://github.com/Yukodeng/bis620.2023/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Yukodeng/bis620.2023/actions/workflows/R-CMD-check.yaml) [![test-coverage](https://github.com/Yukodeng/bis620.2023/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/Yukodeng/bis620.2023/actions/workflows/test-coverage.yaml)

<!-- badges: end -->

The bis620.final project aims to explore the current landscape of clinical studies on metastatic colorectal cancer (mCRC) using clinical trials metadata on clinicaltrials.gov. The package offers off-the-shelf data visualization and statistical analyses tools that allows users to understand characteristics of recent mCRC clinical trials.

## Installation

You can install the development version of bis620.final from [GitHub](https://github.com/) with:

``` r
install.packages("devtools")
install_github("Yukodeng/bis620.final")

# Or alternatively:
devtools::install_github("Yukodeng/bis620.final")
```

## Example

### Dataset

The below code block shows you the one of the datasets we are using which consists of information about 717 clinical trials that are related to mCRC:

``` r
library(bis620.final)
crc |> 
  head(5)
```

Next, this shows the second dataset which contains information about the specific interventions used in the above clinical trials:

``` r
crc_sub |> 
  head(5)
```

### Data Visualization & Analyses

Here are a few snapshots of implementing the functions of this package:

``` r
plot_crc_sankey()
```

<img src="man/figures/sankey_plot.png" width="100%"/>

``` r
plot_intervention_proportion_time()
```

<img src="man/figures/intervention_prop_over_time.png" width="100%"/>

``` r
plot_intervention_count_time()
```

<img src="man/figures/intervention_count_over_time.png" width="100%"/>
