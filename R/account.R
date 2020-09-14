#' Account Metadata
#'
#' Provides metadata for an individual's account including a list of profiles associated
#' with the account, as well as their their respective display names, profile URLs
#' and avatar URLs.
#' @inheritParams get_metadata
#' @param account_id A unique identifier for an individual's account.
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @export
#'
get_player <- function(account_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))

  endpoint <- sprintf('sc2/player/%s',account_id)
  make_request(endpoint, host_region)
}
