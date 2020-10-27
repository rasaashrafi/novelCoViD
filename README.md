
# novelCoViD

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/novelCoViD)](https://CRAN.R-project.org/package=novelCoViD)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

## Introduction 
The "novelCoViD" R package allows users to obtain live worldwide data from the
novel CoronaVirus Disease (CoViD-19) published by Johns Hopkins University. The package also provides basic map and plot functions to explore the dataset.

The goal of this package is to make the latest data available for anyone who wants to
know more about number of death and confirmed cases of covid19 in any country in the world, and 
obtain some visualized understanding from this data.

### Data Accessibility
The `Covid19Data()` function allows users to obtain realtime data of CoViD19 reported cases from Johns Hopkins University data repository. This function provides a clean data of total and daily death and confirmed cases for every country, available scince 2020-01-22.

### visualizing data on map 
The `Covid19onMap()` function provides a world map in which the color of every country shows number of new cases of confirmed or death from covid19 on the given date. Entries of this function are: data set provided by Covid19Data() function, a specific date and the type of "confirmed" or "death" to show on the map. 
Note that the default data is a local data which is the latest version of covid19 data stored in the package. It is recommended that the user gets the updated data using Covid19Data() function.

### plot new cases as a function of time for the given country
The 'Covid19Plot()' function plots number of new confirmed cases and new death from covid19 as a function of time for the given country or countries. Entries of this function are: data set provided by Covid19Data() function, country or countries names, start date and end date.
Note that the default data is a local data which is the latest version of covid19 data stored in the package. It is recommended that the user gets the updated data using Covid19Data() function.


## Installation

You can install the released version of novelCoViD from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("novelCoViD")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(novelCoViD)
## basic example code
newdata <- Covid19Data()
```

``` r
Covid19onMap(newdata, "2020-06-24", "confirmed")
```


``` r
Covid19Plot(newdata,"Iran",start_date="2020-01-22",end_date = "2020-10-24")
```

``` r
Covid19Plot(newdata,country=c("Iran","india"),start_date="2020/02/22",end_date = "2020/05/15")
```

