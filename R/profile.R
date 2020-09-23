#' Static Profile Data
#'
#' Provides static information (achievements, categories, criteria, and rewards)
#'  about SC2 profiles
#' in a given region.
#'
#' @family profile API calls
#' @param region_id A numeric argument indicating the region of the profile.
#'     \itemize{
#'         \item 1 = US Region
#'         \item 2 = EU Region
#'         \item 3 = KR/TW Region
#'         \item 5 = CN Region
#' }
#' @param host_region The host region that the API call will be sent to. For most API calls, the same data will be
#' returned regardless of which region the request is sent to. Must be one of "us", "eu", "kr", "tw", "cn". For more
#' information on regionality, refer to
#' \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}.
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Request static data of profiles in the EU region. Request is sent through
#' # the U.S. host region.
#' try(get_static(region_id = 2, host_region = "us"))
#'
#' # Request static data of profiles in the China region. The request must be
#' # sent to the China gateway.
#' try(get_static(region_id = 5, host_region = "cn"))
#' }
#'
#' @export

get_static <- function(region_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, host_region = host_region)

  endpoint <- sprintf('sc2/static/profile/%s', region_id)
  make_request(endpoint, host_region)
}



#' Profile Metadata
#'
#' Provides metadata for an individual's profile including their display name, profile URL,
#' and avatar URL.
#'
#' @family profile API calls
#' @inheritParams get_static
#' @param realm_id A numeric argument indicating the realm of the profile. A realm is a subset
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
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Request profile metadata of a particular profile in the European region and
#' # European realm.
#' try(get_metadata(region_id = 2, realm_id = 1, host_region = 3437681))
#' }
#' @export
#'
get_metadata <- function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/metadata/profile/%s/%s/%s', region_id, realm_id, profile_id)
  make_request(endpoint, host_region)
}



#' Profile Data
#'
#' Provides summary data for an individual's profile such as campaign completion, career
#' ladder finishes, earned achievements, and more.
#'
#' @family profile API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Request profile summary of a particular profile in the U.S. region and U.S. realm.
#' try(get_profile(region_id = 1, realm_id = 1, profile_id = 4716773))
#' }
#' @export
#'
get_profile <-  function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/profile/%s/%s/%s', region_id, realm_id, profile_id)
  make_request(endpoint, host_region)
}



#' Profile Ladder Summary
#'
#' Provides a detailed list of ladder membership, profile showcases, and placement matches.
#'
#' @family profile API calls
#' @inheritParams get_metadata
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Request ladder summary of a particular profile in the U.S. region and U.S. realm.
#' try(get_ladder_summary(region_id = 1, realm_id = 1, profile_id = 4716773))
#' }
#' @export
#'
get_ladder_summary <- function(region_id, realm_id, profile_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/profile/%s/%s/%s/ladder/summary', region_id, realm_id, profile_id)
  make_request(endpoint, host_region)
}



#' Ladder Details and Profile Rank
#'
#' Provides information about a particular ladder and the individual's rank and status within that
#' ladder (i.e. rank, MMR, etc.).
#'
#' @family profile API calls
#'
#' @inheritParams get_metadata
#' @param ladder_id A unique identifier for a particular ladder. With the exception of Grandmaster, leagues
#' (bronze, silver, etc.), are separated into tiers (1,2,3) which are further separated into divisions.
#' These divisions, or ladders, each have a unique identifier.
#' @references \itemize{
#'    \item \href{https://develop.battle.net/documentation/starcraft-2/community-apis}{Blizzard Community API Documentation}
#'    \item \href{https://develop.battle.net/documentation/guides/regionality-and-apis}{Regionality and APIs}
#'    }
#' @examples
#' \donttest{
#' # Obtaining the overall ladder performance of a profile.
#' try({
#'     ladderData <- get_ladder_summary(region_id = 1, realm_id = 1, profile_id = 4716773)
#'
#'     # Choose a single ladder ID
#'     ladderID <- ladderData$allLadderMemberships$ladderId[1]
#'
#'     # Get full ladder information and the profile's performance in this ladder
#'     get_ladder(region_id = 1, realm_id = 1, profile_id = 4716773, ladder_id = ladderID)
#' })
#' }
#' @export
#'
get_ladder <- function(region_id, realm_id, profile_id, ladder_id, host_region = "us") {
  host_region <- match.arg(host_region, choices = c("us","eu","kr","tw","cn"))
  verify_args(region_id = region_id, realm_id = realm_id, host_region = host_region)

  endpoint <- sprintf('sc2/profile/%s/%s/%s/ladder/%s', region_id, realm_id, profile_id, ladder_id)
  make_request(endpoint, host_region)
}
