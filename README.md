<!-- README.md is generated from README.Rmd. Please edit that file -->

# bis620.final

<!-- badges: start -->

[![R-CMD-check](https://github.com/NickyYiningChen/bis620.final/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/NickyYiningChen/bis620.final/actions/workflows/R-CMD-check.yaml) [![test-coverage](https://github.com/NickyYiningChen/bis620.final/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/NickyYiningChen/bis620.final/actions/workflows/test-coverage.yaml)

<!-- badges: end -->

The bis620.final project aims to explore the current landscape of clinical studies on metastatic colorectal cancer (mCRC) using clinical trials metadata on clinicaltrials.gov. The package offers off-the-shelf data visualization and statistical analyses tools that allows users to understand characteristics of recent mCRC clinical trials.

## Installation

You can install the development version of bis620.final from [GitHub](https://github.com/) with:

``` r
install.packages("devtools")
install_github("NickyYiningChen/bis620.final")

# Or alternatively:
devtools::install_github("NickyYiningChen/bis620.final")
```

## Example

#### Dataset

The below code block shows you the one of the datasets we are using which consists of information about 717 clinical trials that are related to mCRC:

``` r
library(bis620.final)
crc |> head(5) 
#> # A tibble: 5 × 12
#>   nct_id      condition_name   start_date completion_date study_type brief_title
#>   <chr>       <chr>            <date>     <date>          <chr>      <chr>      
#> 1 NCT01531595 Metastatic Colo… 2012-02-29 2025-12-31      Intervent… Study of B…
#> 2 NCT01531621 Metastatic Colo… 2012-02-29 2025-12-31      Observati… A Populati…
#> 3 NCT01532804 Metastatic Colo… 2011-07-28 2019-01-31      Intervent… 2nd-line T…
#> 4 NCT01533740 Metastatic Colo… 2012-03-31 2014-02-28      Observati… Circulatin…
#> 5 NCT01539824 Metastatic Colo… 2012-02-29 2014-08-31      Intervent… A Study of…
#> # ℹ 6 more variables: official_title <chr>, overall_status <chr>, phase <chr>,
#> #   enrollment <dbl>, why_stopped <chr>, source_class <chr>
```

Next, this shows the second dataset which contains information about the specific interventions used in the above clinical trials:

``` r
crc_sub |> head(5)
#> # A tibble: 5 × 16
#>   nct_id      condition_name intervention_id intervention_type intervention_name
#>   <chr>       <chr>                    <dbl> <chr>             <chr>            
#> 1 NCT01531595 Metastatic Co…        60057945 Drug              Bevacizumab plus…
#> 2 NCT01531621 Metastatic Co…        60057946 Other             Biomarker sampli…
#> 3 NCT01532804 Metastatic Co…        60058040 Drug              bevacizumab, oxa…
#> 4 NCT01532804 Metastatic Co…        60058041 Drug              Bevacizumab, oxa…
#> 5 NCT01533740 Metastatic Co…        60058119 Drug              fluorouracil/iri…
#> # ℹ 11 more variables: description <chr>, start_date <date>,
#> #   completion_date <date>, study_type <chr>, brief_title <chr>,
#> #   official_title <chr>, overall_status <chr>, phase <chr>, enrollment <dbl>,
#> #   why_stopped <chr>, source_class <chr>
```

#### Data Visualization & Analyses

Here are a few snapshots of implementing the functions of this package:

``` r
summarize_crc_table()
```

<img src="man/figures/summary_table.png" width="60%"/>

``` r
plot_crc_sankey()
```

<img src="man/figures/sankey_plot.png" width="80%"/>

``` r
plot_intervention_count_time()
```

<img src="man/figures/intervention_count_over_time.png" width="80%"/>

### Statistical Analyses

``` r
enrollment_source_analysis()
```

<img src="man/figures/enrollment_source1.png" width="70%"/>

<img src="man/figures/enrollment_source2.png" width="70%"/>

<img src="man/figures/enrollment_source3.png" width="70%"/>

``` r
enrollment_phase_analysis()
```

<img src="man/figures/enrollment_phase1.png" width="70%"/>

<img src="man/figures/enrollment_phase2.png" width="70%"/>

<img src="man/figures/enrollment_phase3.png" width="70%"/>

``` r
enrollment_duration_analysis()
```

<img src="man/figures/enrollment_duration1.png" width="70%"/>

<img src="man/figures/enrollment_duration2.png" width="70%"/>

### Regression of Duration

``` r
duration_regression_analysis()
```

<img src="man/figures/regression1.png" width="70%"/>

<img src="man/figures/regression2.png" width="70%"/>

<img src="man/figures/regression3.png" width="70%"/>

### Classification of Overall Status

``` r
status_classification()
```

<img src="man/figures/classification1.png" width="70%"/>

<img src="man/figures/classification2.png" width="70%"/>
