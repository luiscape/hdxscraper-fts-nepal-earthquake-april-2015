## Function to fetch a summary from FTS.

fetchSummary <- function(id = NULL) {
  url = paste0('http://fts.unocha.org/api/v1/Appeal/id/', id, '.json')
  doc = fromJSON(getURL(url))
  
  output <- data.frame(
    date = as.character(Sys.Date()),
    original_requirements = doc[[1]]$original_requirements,
    current_requirements = doc[[1]]$current_requirements,
    funding = doc[[1]]$funding,
    pledges = doc[[1]]$pledges
  )
  row.names(output) <- NULL  # cleaning row.names
  
  return(output) 
}

# Function that only fetches the requirement of
# a give crisis on FTS.
fetchRequirement <- function(id = NULL) {
  url = paste0('http://fts.unocha.org/api/v1/Appeal/id/', id, '.json')
  doc = fromJSON(getURL(url))
  
  output <- data.frame(
    date = as.character(Sys.Date()),
    launch_date = doc[[1]]$launch_date,
    original_requirements = doc[[1]]$original_requirements,
    current_requirements = doc[[1]]$current_requirements
    )
  row.names(output) <- NULL  # cleaning row.names
  
  return(output) 
}