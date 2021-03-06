
<!-- README.md is generated from README.Rmd. Please edit that file -->

# novelCoViD <img src="man/figures/logo.jpg" align="right" height = 150 />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/novelCoViD)](https://CRAN.R-project.org/package=novelCoViD)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.com/rasaashrafi/novelCoViD.svg?branch=master)](https://travis-ci.com/rasaashrafi/novelCoViD)
<!-- badges: end -->

## Introduction

The “novelCoViD” R package allows users to obtain live worldwide data
from the novel CoronaVirus Disease (CoViD-19), as published by Johns
Hopkins University. The package also provides basic map and plot
functions to explore the dataset.

The goal of this package is to make the latest data available for anyone
who wants to know more about number of death and confirmed cases of
covid19 in any country in the world, and obtain some visualized
understanding from this data.

### Data Accessibility

The `Covid19Data()` function allows users to obtain real time data of
CoViD19 reported cases from Johns Hopkins University data repository.
This function provides a clean data of total and daily death and
confirmed cases for every country, available since 2020-01-22.

### Visualizing data on map

The `Covid19onMap()` function provides a world map in which the color of
every country shows number of new confirmed cases or death from covid19
on the given date. Entries of this function are: 1) a dataframe which
should be provided by Covid19Data() function, 2) a specific date,
possible formats are: “yyyy-m-d” or “yyyy/m/d” 3) the type of
“confirmed” or “death” to show on the map. 4) Whether to show data
in logarithmic scale or not. Default is FALSE. Note that the default
data is a local data which is the offline available version of covid19
data stored in the package. It is recommended that the user gets the
updated data using Covid19Data() function.

### Plot daily cases as a function of time for the given country

The `Covid19Plot()` function plots number of daily confirmed cases and
daily death from covid19 as a function of time for the given country or
countries. Entries of this function are: 1) data set which should be
provided by Covid19Data() function, 2) country or countries names.
available names are stored in the variable named ‘country\_names’, 3)
start date, 4) end date. Note that the default data is a local data
which is the offline available version of covid19 data stored in the
package. It is recommended that the user gets the updated data using
Covid19Data() function.

## Installation

You can install the development version of novelCoViD from
[GitHub](https://github.com/) with:

``` r
# need devtools for installing from the github repo
install.packages("devtools")

# install novelCoViD from github
devtools::install_github('https://github.com/rasaashrafi/novelCoViD.git')
```

## Example

These are some examples of the three main functions of the package:

``` r
library(novelCoViD)
# get new data
newdata <- Covid19Data()
```

``` r
# map the data of daily cases for a given date
Covid19onMap(newdata, "2020-06-24", "confirmed",log_scale = TRUE)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
# plot the data as a function of time for any country
Covid19Plot(newdata,"Iran",start_date="2020-01-22",end_date = "2020-10-24")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
# plot the data as a function of time for a number of countries
Covid19Plot(newdata,country=c("Iran","India"),start_date="2020/02/22",end_date = "2020/05/15")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
