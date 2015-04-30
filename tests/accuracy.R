## This tests makes sure that the figures calculated are the same as
## the ones displayed on FTS' website. 

accuracyTest <- function(df = NULL, appeal_id = NULL, verbose = FALSE) {
  cat('-------------------------------\n')
  cat('Running tests:\n')
  cat('-------------------------------\n')
  
  # list of indicators to test
  # non-cap figures are not tested at this point
  # because those aggregates are not appearing
  # as a single call from the API.
  indIDs <- c('CHD.FUN.147', 'CHD.FUN.148', 'CHD.FUN.149', 'CHD.FUN.150')
  
  # appeal id summaries
  fts_summary = fetchSummary(appeal_id)

  if (verbose) print(fts_summary)
  
  for (i in 1:length(indIDs)) {
    # extracting the max value out of
    # the timeseries respective indicator
    scraped = max(df$value[df$indID == indIDs[i]])

    if (verbose) print(scraped)

    if (is.na(scraped)) scraped = 0
    if (is.null(scraped)) scraped = 0
    
    # selecting the values depending on the indicator / test
    if (i == 1) fts = fts_summary$current_requirements
    if (i == 2) fts = fts_summary$funding
    if (i == 3) fts = round(fts_summary$funding / fts_summary$current_requirements, 3)
    if (i == 4) fts = fts_summary$pledges
    
    # testing
    if (scraped == fts) {
      cat(indIDs[i], ' | ')
      cat('Things seem wonderful!\n') 
    }
    else { 
      cat(indIDs[i], ' | ')
      cat('Spooooky!\n')
    }
  }
  cat('-------------------------------\n')
}