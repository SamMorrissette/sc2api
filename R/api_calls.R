#' Blizzard API Calls
#'
#' @name blizzard
#' @description A list of functions to make calls to the Blizzard API. Before using any of the
#'    functions, ensure that an access token is set as an environment variable by using
#'    \code{\link{set_token}}.
#'
#'    Explanations for each of the functions can be found in the
#'    \href{https://develop.battle.net/documentation/starcraft-2}{Starcraft II API documentation}.
#'
#'    Note that the China region is \strong{not} supported at this time.
#'
NULL

#' Static Profile Data
#'
#' Provides static information (achievements, categories, criteria, and rewards) about SC2 profiles
#' in a given region.
#'
#' @family profile API calls
#'
#' @param region_id A numeric argument indiciating in which region the profile resides.
#'     \itemize{
#'         \item 1 = US Region
#'         \item 2 = EU Region
#'         \item 3 = KR/TW Region
#' }
#'
#' @export
profile_static <- function(region_id) {
  endpoint <- paste0('sc2/static/profile/', region_id)
  make_request(endpoint)
}

#' Profile Metadata
#'
#' Provides metadata for an individual's profile including their display name, profile URL,
#' and avatar URL.
#'
#'
#' @family profile API calls
#'
#' @inheritParams profile_static
#' @param realm_id A numeric argument indiciating in which realm the profile resides. A realm is a subset
#'     of the region.
#'      \itemize{
#'          \item{US Region}
#'              \itemize{
#'                  \item{1 = US}
#'                  \item{2 = LatAm}
#'              }
#'          \item{EU Region}
#'              \itemize{
#'                  \item{1 = Europe}
#'                  \item{2 = Russia}
#'          }
#'          \item{KR/TW Region}
#'              \itemize{
#'                  \item{1 = Korea}
#'                  \item{2 = Taiwan}
#'          }
#'      }
#' @param profile_id A unique, numeric identifier for an individual's profile.
#'
#' @export
profile_metadata <- function(region_id,realm_id,profile_id) {
  endpoint <- paste0('sc2/metadata/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id)
  make_request(endpoint)
}

#' Profile Data
#'
#' Provides summary data for an individual's profile such as campaign completion, career
#' ladder finishes, earned achievements, and much more.
#'
#' @family profile API calls
#'
#' @inheritParams profile_metadata
#'
#' @export
profile_profile <-  function(region_id,realm_id,profile_id) {
  endpoint <- paste0('sc2/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id)
  make_request(endpoint)
}

#' Profile Ladder Summary
#'
#' Provides a detailed list of ladder membership, profile showcases, and placement matches.
#'
#' @family profile API calls
#'
#' @inheritParams profile_metadata
#'
#' @export
profile_ladder_summary <- function(region_id,realm_id,profile_id) {
  endpoint <- paste0('sc2/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id, '/',
                     'ladder/summary')
  make_request(endpoint)
}

#' Ladder Details and Profile Rank
#'
#' Provides information about a particular ladder and the individual's rank and status within that
#' ladder (i.e. rank, MMR, etc.).
#'
#' @family profile API calls
#'
#' @inheritParams profile_metadata
#' @param ladder_id A unique identifier for a particular ladder. With the exception of gradmaster, leagues
#' (bronze, silver, etc.), are separated into tiers (1,2,3) which are further separated into divisions.
#' These divisions, or ladders, each have a unique identifier.
#' @export
profile_ladder <- function(region_id,realm_id,profile_id,ladder_id) {
  endpoint <- paste0('sc2/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id, '/',
                     'ladder/',
                     ladder_id)
  make_request(endpoint)
}

#' Grandmaster Leaderboard
#'
#' Provides a full listing of players currently in the grandmaster leaderboard. Also provides other
#' information such as player profile information, records (match record, MMR, etc.), and clans.
#'
#' @family ladder data API calls
#'
#' @inheritParams profile_metadata
#' @export
ladder_gm_leaderboard <- function(region_id) {
    endpoint <- paste0('sc2/ladder/grandmaster/',region_id)
    make_request(endpoint)
}

#' Current Season Information
#'
#' Provides the current season ID, starting date, and ending date.
#'
#' @family ladder data API calls
#'
#' @inheritParams profile_metadata
#' @export
ladder_season <- function(region_id) {
  endpoint <- paste0('sc2/ladder/season/',region_id)
  make_request(endpoint)
}

#' Account Metadata
#'
#' Provides metadata for an individual's account including a list of profiles associated
#' with the account, as well as their their respective display names, profile URLs
#' and avatar URLs.
#'
#' @param account_id A unique identifier for an individual's account.
#' @export
account_player <- function(account_id) {
  endpoint <- paste0('sc2/player/',account_id)
  make_request(endpoint)
}

#' Legacy API - Profile Data
#'
#' Provides summary data for an individual's profile such as campaign completion, career
#' ladder finishes, earned achievements, and much more.
#'
#' @family legacy API calls
#' @seealso \code{\link{profile_profile}}
#' @inheritParams profile_metadata
#' @export
legacy_profile <- function(region_id,realm_id,profile_id) {
  endpoint <- paste0('sc2/legacy/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id)
  make_request(endpoint)
}

#' Legacy API - Profile Ladder Summary
#'
#' Provides information about a profile's performance in the current season, previous season, and
#' showcase entries.
#'
#' @family legacy API calls
#' @seealso \code{\link{profile_ladder_summary}}
#' @inheritParams profile_metadata
#' @export
legacy_ladders <- function(region_id,realm_id,profile_id) {
  endpoint <- paste0('sc2/legacy/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id, '/',
                     'ladders')
  make_request(endpoint)
}

#' Legacy API - Profile Match History
#'
#' Provides information about a profile's recent match history (win/loss, timestamp, etc.).
#'
#' @family legacy API calls
#' @inheritParams profile_metadata
#' @export
legacy_match_history <- function(region_id,realm_id,profile_id) {
  region_id <- convert_region(region)
  endpoint <- paste0('sc2/legacy/profile/',
                     region_id, '/',
                     realm_id, '/',
                     profile_id, '/',
                     'matches')
  make_request(endpoint)
}

#' Legacy API - Ladder Details
#'
#' Provides a listing of players in a given ladder. Also provides other information such as
#' their ladder record, points, profile information, and clan.
#'
#' @family legacy API calls
#'
#' @inheritParams profile_ladder
#' @export
legacy_ladder <- function(region_id,ladder_id) {
  endpoint <- paste0('sc2/legacy/ladder/',
                     region_id, '/',
                     ladder_id)
  make_request(endpoint)
}

#' Legacy API - Available Achievements
#'
#' Provides a listing of available achievements in Starcraft II.
#' @family legacy API calls
#' @inheritParams profile_metadata
#' @seealso \code{\link{profile_static}}
#' @export
legacy_achievements <- function(region_id) {
  endpoint <- paste0('sc2/legacy/data/achievements/',
                     region_id)
  make_request(endpoint)
}

#' Legacy API - Available Rewards
#'
#' Provides a listing of available rewards in Starcraft II.
#' @family legacy API calls
#' @inheritParams profile_metadata
#' @seealso \code{\link{profile_static}}
#' @export
legacy_rewards <- function(region_id) {
  endpoint <- paste0('sc2/legacy/data/rewards/',
                     region_id)
  make_request(endpoint)
}

#' Ladder Data
#'
#' Provides data of players in a particular ladder. This includes MMR, points,
#' win/loss record, time of joining, time of a player's last game, and more.
#' @inheritParams profile_ladder
#' @export
ladder_data <- function(ladder_id) {
  endpoint <- paste0('data/sc2/ladder/',
                     ladder_id)
  make_request(endpoint)
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
#' @note League data is only available for season 28 and higher.
#' @export
league_get_league_data <- function(season_id,queue_id,team_type,league_id) {
  endpoint <- paste0('/data/sc2/league/',
                     season_id, '/',
                     queue_id, '/',
                     team_type, '/',
                     league_id)
  make_request(endpoint)
}

