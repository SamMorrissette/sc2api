#' Grandmaster Leaderboard
#'
#' Provides a full listing of players currently in the grandmaster leaderboard. Also provides other
#' information such as player profile information, records (match record, MMR, etc.), and clans.
#'
#' @family ladder data API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    \item \href{https://starcraft2.com/en-us/ladder/grandmaster/1}{Grandmaster League}
#'    }
#' @examples
#' \donttest{
#' # Obtain GM leaderboard for the Korea region
#' try(get_gm_leaderboard(region_id = 3))
#' }
#' @note This API call is currently not supported for the China region (region_id = 5).
#'
#' @importFrom data.table rbindlist
#' @export
#'
get_gm_leaderboard <- function(region_id, host_region = "us") {
  if (region_id == 5) {
    stop("Blizzard currently does not support this API call for the China region (region_id = 5)")
  }

  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))

  verify_args(region_id = region_id, host_region = host_region)

  endpoint <- sprintf('sc2/ladder/grandmaster/%s',region_id)
  content <- make_request(endpoint, host_region)

  #Formatting
  content <- content$ladderTeams
  new_cols <- data.table::rbindlist(content$teamMembers,fill=TRUE)
  content$teamMembers <- NULL
  content <- as.data.frame(cbind(new_cols,content))
  return(content)
}



#' Current Season Information
#'
#' Provides the current season ID, starting date, and ending date.
#'
#' @family ladder data API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Obtain current season information for the European region
#' try(get_season(region_id = 2))
#' }
#' @inheritParams get_metadata
#' @export
#'
get_season <- function(region_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, host_region = host_region)

  endpoint <- sprintf('sc2/ladder/season/%s',region_id)
  make_request(endpoint, host_region)
}
