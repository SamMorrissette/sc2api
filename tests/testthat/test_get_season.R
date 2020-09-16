with_mock_api({
    test_that("get_league_players returns a list with tier and league counts", {

    d1 <- get_league_counts(40, 204, 1, 3, "kr")
    expect_type(d1, "list")

    #GM should have only one tier
    d2 <- get_league_counts(35, 201, 0, 6, "eu")
    expect_equal(d2$tiers, d2$league)

    #Tiers should sum to league
    d3 <- get_league_counts(29, 204, 1, 1, "us")
    expect_equal(sum(d3$tiers), sum(d3$league))
  })
})

with_mock_api({
  test_that("get_ladder_ids returns correct type depending on league", {

    #Returns an integer for grandmaster
    d1 <- get_ladder_ids(38, 201, 0, 6, "us")
    expect_type(d1, "integer")

    #Returns a list otherwise
    d2 <- get_ladder_ids(43, 202, 1, 5, "eu")
    expect_type(d2, "list")
  })
})


