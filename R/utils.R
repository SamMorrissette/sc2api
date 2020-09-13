#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom httr content
#'
make_request <- function(endpoint) {
  url <- paste0('https://us.api.blizzard.com/',endpoint)
  request <- httr::GET(url,
                       httr::add_headers(Authorization = paste('Bearer', Sys.getenv('BLIZZ_TOKEN'))))
  if (request$status_code == 200) {
    response <- httr::content(request)
    return(response)
  } else {
    stop(paste0("HTTP Error code ", request$status_code,'. Please ensure that you have set a valid authentication using set_token(auth_token)'))
  }
}
