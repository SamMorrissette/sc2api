
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SC2API

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/SamMorrissette/sc2api.svg?branch=master)](https://travis-ci.org/github/SamMorrissette/sc2api)
[![CRAN
status](https://www.r-pkg.org/badges/version/SC2API)](https://CRAN.R-project.org/package=SC2API)
[![Travis build
status](https://travis-ci.com/SamMorrissette/sc2api.svg?branch=master)](https://travis-ci.com/SamMorrissette/sc2api)
<!-- badges: end -->

The goal of SC2API is to build a simple and easy-to-use API wrapper for
Blizzard Starcraft II API in the R programming language.

## Installation

The SC2API is published on CRAN and can be installed using

``` r
install.packages('SC2API')
```

You can also install the development version of SC2API from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SamMorrissette/sc2api")
```

Note that there is also a vignette that comes with the package that can
be installed using:

``` r
# install.packages("devtools")
devtools::install_github("SamMorrissette/sc2api", build_vignettes = TRUE, dependencies = TRUE)
```

## Example Usage

This is a basic example to obtain the MMR (match-maker rating) of the
current top 10 players in the North America Grandmaster leaderboard.

First, you must set your own token in the R environment by supplying
your own client ID and client secret. For more information on how to
obtain these, visit [Getting
Started](https://develop.battle.net/documentation/guides/getting-started).

``` r
library(SC2API)
```

``` r
set_token("YOUR CLIENT ID", "YOUR CLIENT SECRET")
```

``` r
data <- get_gm_leaderboard(1) # An argument of "1" corresponds to the North American ladder.
top10 <- data[1:10,] # Extract the top 10 players
playerMMR <- top10$mmr # Extract the "mmr" vector from each player. 
print(playerMMR)
#>  [1] 6609 6451 6425 6322 6276 6232 6208 6135 6106 6092
```
