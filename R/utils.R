#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr stop_for_status
#' @importFrom jsonlite fromJSON
#'

make_request <- function(endpoint,host_region) {
  if (host_region=="cn") {
    url <- sprintf('https://gateway.battlenet.com.cn/%s', endpoint)
  } else {
    url <- sprintf('https://%s.api.blizzard.com/%s', host_region, endpoint)
  }
  response <- httr::GET(url,
                       httr::add_headers(Authorization = paste('Bearer', Sys.getenv('BLIZZ_TOKEN'))))
  if (response$status_code==401) {
    stop('HTTP Error code 401: Unauthorized. Please ensure you have set a valid access token using set_token.')
  }
  httr::stop_for_status(response)
  response <- jsonlite::fromJSON(content(response,as='text'))
  return(response)
}

verify_args <- function(region_id, realm_id = 1, host_region="us") {
  #Verify region
  if (!(region_id %in% c(1,2,3,5))) {
    stop("Region ID must be one of the following: 1, 2, 3, 5")
  }

  #Verify Chinese Region has realm id of 1
  if (region_id == 5 & realm_id != 1) {
    stop("Realm ID for the China region must be set to 1")
  }
  #Verify all other realm IDs
  else if (!(realm_id %in% c(1,2))) {
    stop("Region ID must be one of the following: 1, 2")
  }

  if (region_id == 5 & host_region != "cn") {
    stop("The host region must be set to 'cn' when region_id is set to 5")
  }
}
