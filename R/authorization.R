#' Authorization
#'
#' @name authorization
#' @description The Blizzard API uses OAuth 2.0 for authorization. For more information on how Blizzard
#'    uses OAuth in their API, visit \url{https://develop.battle.net/documentation/guides/using-oauth}.
#'
#'    Before using the Blizzard API, one must first create a client in the
#'    \href{https://develop.battle.net/}{Blizzard Developer Portal} and obtain a valid client ID and
#'    client secret. For more information on getting started, see:
#'    \href{https://develop.battle.net/documentation/guides/getting-started}{Getting Started}.
#'
#'    Once a client has been created, use \code{\link{set_token}} and supply the client id and client
#'    secret as arguments to set an environment variable for all future API calls.
#'
#'    Once \code{set_token()} has been used, an access token can be removed from the environment
#'    using \code{remove_token()}
#'
#'    Note that access tokens are set to expire in 24 hours and, subsequently,
#'    a new token must be used for any future API calls.
#'
#'@note Access tokens expire after 24 hours.
NULL

#' @importFrom httr POST
#' @importFrom httr content
#' @importFrom httr authenticate
get_token <- function(client_id, client_secret) {
  if (missing(client_id) | missing(client_secret)) {
    stop("Please provide a client ID and client secret.")
  }
  url <- 'https://us.battle.net/oauth/token'
  res <- httr::POST(url,
                     body = list(grant_type = "client_credentials"),
                     config = httr::authenticate(client_id,client_secret))
  if (res$status_code==401) {
    stop('HTTP Error code 401: Unauthorized. Please ensure you have entered a valid client id and client secret.')
  }
  httr::stop_for_status(res)
  token <- httr::content(res)$access_token
  return(token)
}



#' @param verbose If verbose is set to TRUE, your access token will be printed on screen.
#' @param client_id,client_secret A client ID and client secret can be obtained from the
#'     \href{https://develop.battle.net/}{Blizzard Developer Portal}. For more information on
#'     creating a client, visit
#'     \href{https://develop.battle.net/documentation/guides/getting-started}{Getting Started}.
#' @rdname authorization
#' @examples \dontrun{
#' #Get and set a token as an environment variable
#' set_token(client_id = "YOUR CLIENT ID", client_secret = "YOUR CLIENT SECRET")
#'
#' #Set an access token that you have already retrieved as an environment variable
#' set_token(access_token = "YOUR TOKEN")
#' }
#' @export
set_token <- function(client_id, client_secret, access_token, verbose = FALSE) {
  if (!missing(access_token)) {
    message("Testing to see if supplied access token is valid...")
    if (validate_token(access_token)) {
      message("Valid access token! Setting as an environment variable for future API calls.")
      if (verbose==TRUE) print(access_token)
      Sys.setenv("BLIZZ_TOKEN" = access_token)
      return(1) # FIX THIS
    } else if (!missing(client_id) & !missing(client_secret)) {
      message("Invalid access token supplied. Trying to obtain token using client id and client secret...")
      access_token = get_token(client_id, client_secret)
      if (verbose==TRUE) print(access_token)
      Sys.setenv("BLIZZ_TOKEN" = access_token)
      return(1) # FIX THIS
    } else {
      stop("Invalid access token detected. Please try providing a client id and client secret to receive a valid access token.")
    }
  } else if (missing(client_id) | missing(client_secret)) {
    stop('Please provide both a client id and client secret')
  } else {
    access_token = get_token(client_id, client_secret)
    if (verbose==TRUE) print(access_token)
    Sys.setenv("BLIZZ_TOKEN" = access_token)
  }
}




#' @importFrom httr POST
#' @importFrom httr http_error
#' @param access_token An OAuth 2.0 access token required to use the Blizzard API. Access tokens can be
#'    obtained by using \code{set_token} with a valid client ID and client secret.
#' @rdname authorization
#' @examples \dontrun{
#' # Ensure that a valid token is currently set as an environment variable
#' validate_token()
#'
#' # Check if a token is valid
#' valid_token("TEST TOKEN")
#' }
#' @export
validate_token <- function(access_token) {
  if (missing(access_token)) {
    message("An access token was not supplied. Checking if a valid token has already been set as an environment variable...")
    access_token <- Sys.getenv("BLIZZ_TOKEN")
  }

  url <- 'https://us.battle.net/oauth/check_token'
  res <- httr::POST(url,
                        body = list(token = access_token))
  if (httr::http_error(res)) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}



#' @rdname authorization
#' @examples \dontrun{
#' # Remove token from environment variable
#' unset_token()
#' }
#' @export
unset_token <- function() {
  Sys.unsetenv("BLIZZ_TOKEN")
}
