#' League and Tier Counts
#'
#' Provides both league (i.e. bronze, silver, etc.) and tier (1, 2, 3) player counts.
#' @inheritParams get_league_data
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @note Data is only available for season 28 and higher.
#' @examples \donttest{
#' # Get league counts for Season 35, LotV 2v2, randomly gathered teams,
#' # Bronze league, Korean region.
#' try({
#'     data <- get_league_counts(season_id = 35,
#'                               queue_id = 202,
#'                               team_type = 1,
#'                               league_id = 0,
#'                               host_region = "kr")
#' })
#' }
#' @return A list with tier counts and the overall league count.
#' @export
get_league_counts <- function(season_id, queue_id, team_type, league_id, host_region) {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))

  league_data <- get_league_data(season_id, queue_id, team_type, league_id, host_region)
  player_count <- sapply(league_data$tier$division,
                         function(x) {
                           sapply(x$member_count, sum)
                         })
  player_count <- lapply(league_data$tier$division, function(x) x$member_count)
  tier_player_count <- sapply(player_count,sum)
  league_player_count <- sum(sapply(player_count,sum))
  all_count <- list(tiers = tier_player_count,
                  league = league_player_count)
  return(all_count)
}

#' League Ladder ID's
#'
#' Provides ladder ID's for all divisions in a league's tiers.
#' @inheritParams get_league_data
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @note Data is only available for season 28 and higher.
#' @examples \donttest{
#' # Get all ladder ID's for Season 35, LotV 2v2, randomly gathered teams,
#' # Bronze league, Korean region.
#' try({
#'     data <- get_ladder_ids(season_id = 35,
#'                            queue_id = 202,
#'                            team_type = 1,
#'                            league_id = 0,
#'                            host_region = "kr")
#' })
#' }
#' @return List of ladder ID's separated by tier. For grandmaster league, an integer is returned.
#' @export
get_ladder_ids <- function(season_id, queue_id, team_type, league_id, host_region) {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))

  league_data <- get_league_data(season_id, queue_id, team_type, league_id, host_region)
  list_ids <- sapply(league_data$tier$division, function(x) x$ladder_id)

  return(list_ids)
}

#' Last Played Match
#'
#' Get the time of the last played match in a player's match history.
#' @inheritParams get_legacy_match_history
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @note Data is only available for season 28 and higher.
#' @examples \donttest{
#' # Get last played match for a particular profile
#' try(get_last_played(1, 4716773, host_region = "us"))
#' }
#' @export
get_last_played <- function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))

  history <- get_legacy_match_history(region_id, realm_id, profile_id, host_region = "us")
  last_match <- as.POSIXct(history[1,"date"], origin = "1970-01-01")
  return(last_match)
}

