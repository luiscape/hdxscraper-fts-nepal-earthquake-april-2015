## Function to collect all the financial data from FTS
## based on a crisis ID.

fetchTimeSeries <- function(id = NULL) {
  cat('Collecting data from FTS | ')
  
  url = paste0('http://fts.unocha.org/api/v1/Contribution/emergency/', id, '.json')
  doc = fromJSON(getURL(url))
  
  t = length(doc)
  pb <- txtProgressBar(min = 0, max = t, style = 3, char = '.')
  for (i in 1:t) {
    
    it <- data.frame(
      docid = doc[[i]]$id,
      amount = doc[[i]]$amount,
      decision_date = as.Date(doc[[i]]$decision_date),
      year = doc[[i]]$year,
      donor = doc[[i]]$donor,
      recipient = doc[[i]]$recipient,
      emergency_id = doc[[i]]$emergency_id,
      appeal_id = doc[[i]]$appeal_id,
      status = doc[[i]]$status,
      is_allocation = doc[[i]]$is_allocation,
      project_code = ifelse(is.null(doc[[i]]$project_code), 'NON-CAP', doc[[i]]$project_code),
      appeal_title = ifelse(is.null(doc[[i]]$appeal_title), 'NON-CAP', doc[[i]]$appeal_title),
      emergency_title = doc[[i]]$emergency_title
    )
    if (i == 1) output <- it
    else output <- rbind(output, it)
    setTxtProgressBar(pb, i)
  }
  close(pb)
  
  cat("Done!\n")
  return(output)
}