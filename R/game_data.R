#' Ladder Data
#'
#' Provides data of players in a particular ladder. This includes MMR, points,
#' win/loss record, time of joining, time of a player's last game, and more.
#' @family data API calls
#' @param ladder_id A unique identifier for a particular ladder. With the exception of gradmaster, leagues
#' (bronze, silver, etc.), are separated into tiers (1,2,3) which are further separated into divisions.
#' These divisions, or ladders, each have a unique identifier.
#' @param host_region The host region that the API call will be sent to. For \code{get_ladder_data}, the host
#' region MUST be the region that the ladder is a part of. Must be one of "us", "eu", "kr", "tw", "cn". For more
#' information on regionality, refer to
#' \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}.
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @note For \code{get_ladder_data}, the host region MUST be the region that the ladder is a part of.
#' @examples \dontrun{
#' ### Obtain battle tags and MMR of players in a particular ladder.
#'
#' #Get full ladder data
#' data <- get_ladder_data(ladder_id = 289444, host_region = "us")
#'
#' # Player ratings
#' ratings <- data$team$rating
#'
#' # Get battle tags using list indexing with sapply
#' tags <- sapply(data$team$member, function(x) x$character_link$battle_tag)
#' }
#' @export
#'
get_ladder_data <- function(ladder_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  endpoint <- sprintf('data/sc2/ladder/%s', ladder_id)
  make_request(endpoint, host_region)
}



#' League Data
#'
#' League data is divided into 3 tiers for each league (with the exception of grandmaster, which only has
#' 1 tier) and further divided into a number of divisions depending on how many players are in a given league.
#' League data contains the number of divisions, the unique ladder ID of each division and the
#' total player count contained within each division.
#' @param season_id A numeric argument indicating a particular ladder season. Currently, league data
#'     is only available for season 28 and higher (i.e. data prior to this season is inaccessible).
#' @param queue_id
#'      \itemize{
#'         \item 1 = WoL 1v1
#'         \item 2 = WoL 2v2
#'         \item 3 = WoL 3v3
#'         \item 4 = WoL 4V4
#'         \item 101 = HotS 1v1
#'         \item 102 = HotS 2v2
#'         \item 103 = HotS 3v3
#'         \item 104 = HotS 4v4
#'         \item 201 = LotV 1v1
#'         \item 202 = LotV 2v2
#'         \item 203 = LotV 3v3
#'         \item 204 = LotV 4v4
#'         \item 206 = LotV Archon
#'      }
#' @param team_type
#'     \itemize{
#'         \item 0 = Arranged
#'         \item 1 = Random
#'     }
#' @param league_id
#'     \itemize{
#'         \item 0 = Bronze
#'         \item 1 = Silver
#'         \item 2 = Gold
#'         \item 3 = Platinum
#'         \item 4 = Diamond
#'         \item 5 = Masters
#'         \item 6 = Grandmaster
#'      }
#' @param host_region The host region that the API call will be sent to. For \code{get_league_data}, the host
#' region affects the data you will receive (i.e. different regions will result in different data).
#' Must be one of "us", "eu", "kr", "tw", "cn". For more information on regionality, refer to
#' \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}.
#' @note League data is only available for season 28 and higher.
#' @examples \dontrun{
#' # Get full league data for Season 30, LotV 1v1, arranged teams,
#' # Masters league, U.S. region.
#' data <- get_league_data(season_id = 30,
#'                     queue_id = 201,
#'                     team_type = 0,
#'                     league_id = 5,
#'                     host_region = "us")
#'
#' # Get all divisions and their associated player counts
#' player_counts <- data$tier$division[[3]]$member_count
#' total_count <- sum(player_counts)
#' }
#' @export
#'
get_league_data <- function(season_id, queue_id, team_type, league_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  if (!(season_id %in% 28:44)) {
    stop("Invalid season_id. Please see ?get_league_data for argument choices.")
  }
  if (!(queue_id %in% c(1,2,3,4,101,102,103,104,201,202,203,204,206))) {
    stop("Invalid queue_id. Please see ?get_league_data for argument choices.")
  }
  if (!(team_type %in% c(0,1))) {
    stop("Invalid team_type. Please see ?get_league_data for argument choices.")
  }
  if (!(league_id %in% 0:6)) {
    stop("Invalid league_id. Please see ?get_league_data for argument choices.")
  }

  endpoint <- sprintf('data/sc2/league/%s/%s/%s/%s', season_id, queue_id, team_type, league_id)
  make_request(endpoint, host_region)
}



#' Season Data
#'
#' Provides start and ending times for a given season.
#' @inheritParams get_league_data
#' @param host_region The host region that the API call will be sent to. For \code{get_season_data}, the host
#' region affects the data you will receive (i.e. different regions will result in different data).
#' Must be one of "us", "eu", "kr", "tw", "cn". For more information on regionality, refer to
#' \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}.
#' @note Season data is only available for season 28 and higher.
#' @examples \dontrun{
#' # Get season start and end times for season 35 in the European region.
#'
#' data <- get_season_data(season_id = 35, host_region = "eu")
#' as.POSIXct(data$start_timestamp, origin = "1970-01-01")
#' as.POSIXct(data$end_timestamp, origin = "1970-01-01")
#' }
#' @export
#'
get_season_data <- function(season_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  if (!(season_id %in% 28:44)) {
    stop("season_id must be between 28 and 44.")
  }

  endpoint <- sprintf('data/sc2/season/%s', season_id)
  make_request(endpoint, host_region)
}
