
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SC2API

<!-- badges: start -->

<!-- badges: end -->

The goal of SC2API is to build a simple and easy-to-use API wrapper for
the Blizzard Starcraft II API in the R programming language.

## Installation

You can install the development version of SC2API from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SamMorrissette/sc2api")
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
set_token(get_token("YOUR CLIENT ID", "YOUR CLIENT SECRET"))
```

``` r
data <- ladder_gm_leaderboard(1) # An argument of "1" corresponds to the NA ladder.
top10 <- data$ladderTeams[1:10] # Extract the top 10 players
playerMMR <- sapply(top10, function(x) x$mmr) # Extract the "mmr" vector from each player. 
print(playerMMR)
#>  [1] 6456 6350 6300 6279 6252 6228 6128 6086 6052 6044
```
