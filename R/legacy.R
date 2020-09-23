#' Legacy API - Profile Data
#'
#' Provides summary data for an individual's profile such as campaign completion, career
#' ladder finishes, earned achievements, and much more.
#'
#' @family legacy API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @seealso \code{\link{get_profile}}
#' @note Legacy API call. It is recommended to use \code{\link{get_profile}} instead.
#' @export
#'
get_legacy_profile <- function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/legacy/profile/%s/%s/%s', region_id, realm_id, profile_id)
  make_request(endpoint, host_region)
}



#' Legacy API - Profile Ladder Summary
#'
#' Provides information about a profile's performance in the current season, previous season, and
#' showcase entries.
#'
#' @family legacy API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @seealso \code{\link{get_ladder_summary}}
#' @note Legacy API call. For similar information, use \code{\link{get_ladder_summary}}.
#' @export
#'
get_legacy_ladders <- function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/legacy/profile/%s/%s/%s/ladders', region_id, realm_id, profile_id)
  make_request(endpoint, host_region)
}



#' Legacy API - Profile Match History
#'
#' Provides information about a profile's recent match history (last 25 matches, win/loss, timestamp, etc.).
#'
#' @family legacy API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Obtain recent 1v1 results for a profile in the U.S. region
#' try({
#'     matches <- get_legacy_match_history(region_id = 1, realm_id = 1, profile_id = 4716773)
#'     matches[matches$type=='1v1',"decision"]
#' })
#' }
#' @note Although this is a legacy API call, there is no other call available to obtain a profile's match history.
#' @export
#'
get_legacy_match_history <- function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/legacy/profile/%s/%s/%s/matches', region_id, realm_id, profile_id)
  content <- make_request(endpoint, host_region)

  #Formatting
  content <- content$matches
  return(content)
}



#' Legacy API - Ladder Details
#'
#' Provides a listing of players in a given ladder. Also provides other information such as
#' their ladder record, points, profile information, and clan.
#'
#' @family legacy API calls
#' @inheritParams get_ladder
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @seealso \code{\link{get_ladder_data}}
#' @note Legacy API call. It is recommended to use \code{\link{get_ladder_data}} instead.
#' @export
#'
get_legacy_ladder <- function(region_id, ladder_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, host_region = host_region)

  endpoint <- sprintf('sc2/legacy/ladder/%s/%s', region_id, ladder_id)
  content <- make_request(endpoint, host_region)
  content <- content$ladderMembers
  return(content)
}



#' Legacy API - Available Achievements
#'
#' Provides a listing of available achievements in Starcraft II.
#' @family legacy API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @note Legacy API call. It is recommended to use \code{\link{get_static}} instead.
#' @seealso \code{\link{get_static}}
#' @export
#'
get_legacy_achievements <- function(region_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, host_region = host_region)

  endpoint <- sprintf('sc2/legacy/data/achievements/%s', region_id)
  make_request(endpoint, host_region)
}



#' Legacy API - Available Rewards
#'
#' Provides a listing of available rewards in Starcraft II.
#' @family legacy API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @note Legacy API call. It is recommended to use \code{\link{get_static}} instead.
#' @seealso \code{\link{get_static}}
#' @export
#'
get_legacy_rewards <- function(region_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, host_region = host_region)

  endpoint <- sprintf('sc2/legacy/data/rewards/%s', region_id)
  make_request(endpoint, host_region)
}
