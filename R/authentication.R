#' Authentication Methods
#'
#' @name authentication
#' @description The Blizzard API uses OAuth 2.0 for authorization. For more information on how Blizzard
#'    uses OAuth in their API, visit \url{https://develop.battle.net/documentation/guides/using-oauth}.
#'
#'    Before using the Blizzard API, one must first create a client in the
#'    \href{https://develop.battle.net/}{Blizzard Developer Portal} and obtain a valid client ID and
#'    client secret. For more information on getting started, see:
#'    \href{https://develop.battle.net/documentation/guides/getting-started}{Getting Started}.
#'
#'    Once a client has been created, use \code{get_token(client_id,client_secret)}
#'    to obtain a valid access token. This token can then be supplied to
#'    \code{set_token()} to set an environment variable
#'    for all future API calls.
#'
#'    Once \code{set_token()} has been used, an access token can be removed from the environment
#'    using \code{remove_token()}
#'
#'    Note that access tokens are set to expire in 24 hours and, subsequently,
#'    a new token must be used for any future API calls.
#'@note Access tokens expire after 24 hours.
NULL

#' @importFrom httr POST
#' @importFrom httr content
#' @importFrom httr authenticate
#'
#' @param client_id,client_secret A client ID and client secret can be obtained from the
#'     \href{https://develop.battle.net/}{Blizzard Developer Portal}. For more information on
#'     creating a client, visit
#'     \href{https://develop.battle.net/documentation/guides/getting-started}{Getting Started}.
#'
#' @rdname authentication
#' @export
get_token <- function(client_id, client_secret) {
  if (missing(client_id) | missing(client_secret)) {
    stop("Please provide a client ID and client secret.")
  }
  url <- 'https://us.battle.net/oauth/token'
  auth <- httr::POST(url,
                     body=list(grant_type = "client_credentials"),
                     config = httr::authenticate(client_id,client_secret))
  if (auth$status_code==200) {
    token <- httr::content(auth)$access_token
    return(token)
  } else {
    stop(paste0(paste("HTTP Error code", auth$status_code), ". Please ensure that you have entered a valid client ID and client secret."))
  }
}


#' @importFrom httr POST
#' @param access_token An OAuth 2.0 access token required to use the Blizzard API. Access tokens can be
#'    obtained by using \code{get_token()} with a valid client ID and client secret.
#'
#' @rdname authentication
#' @export
valid_token <- function(access_token) {
  if (missing(access_token)) {
    message("An access token was not supplied. Checking if a valid token is already in use...")
    access_token <- Sys.getenv("BLIZZ_TOKEN")
  }

  url <- 'https://us.battle.net/oauth/check_token'
  request <- httr::POST(url,
                        body = list(token = access_token))

  if (request$status_code == 200) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' @rdname authentication
#' @export
set_token <- function(access_token) {
  if (missing(access_token)) {
    stop("Please provide an access token. You can receive an access token using get_token(client_id, client_secret).")
  }
  if (valid_token(access_token)) {
    Sys.setenv("BLIZZ_TOKEN"=access_token)
  } else {
    stop("Invalid access token detected. Please use get_token(client_id, client_secret) to receive a valid access token.")
  }
}

#' @rdname authentication
#' @export
remove_token <- function() {
  Sys.unsetenv("BLIZZ_TOKEN")
}
