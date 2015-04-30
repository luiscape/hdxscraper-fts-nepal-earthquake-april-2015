## Function to extract indicators from
## FTS' raw inputs
exctractIndicators <- function(df = NULL) {
  cat('Extracting indicators | ')
  
  ## Extracting CHD.FUN.138 // Non-CAP Pledges
  sub <- df[df$status == 'Pledge'
            & df$is_allocation != 1, ]
  
  non_cap_pledges <- data.frame(
    indid = 'CHD.FUN.145',
    indicator_name = 'Total Funding to the Emergency: Nepal Earthquake - April 2015 (Pledges)',
    dsid = 'fts-nepal-earthquake-2015',
    region = 'WLD',
    period = row.names(tapply(sub$amount, sub$decision_date, sum)),
    value = tapply(sub$amount, sub$decision_date, sum),
    source = 'http://fts.unocha.org/pageloader.aspx?page=emerg-emergencyDetails&emergID=16575'
  )
  row.names(non_cap_pledges) <- NULL  # cleaning row.names
  non_cap_pledges$value <- cumsum(non_cap_pledges$value)  # making values cumulative
  
  ## Extracting CHD.FUN.139 // Non-CAP Funding
  sub <- df[(df$status == 'Paid contribution' | df$status == 'Commitment') 
            & df$is_allocation != 1 , ]
  
  non_cap_funding <- data.frame(
    indid = 'CHD.FUN.146',
    indicator_name = 'Total Funding to the Emergency: Nepal Earthquake - April 2015 (Funding)',
    dsid = 'fts-nepal-earthquake-2015',
    region = 'WLD',
    period = row.names(tapply(sub$amount, sub$decision_date, sum)),
    value = tapply(sub$amount, sub$decision_date, sum),
    source = 'http://fts.unocha.org/pageloader.aspx?page=emerg-emergencyDetails&emergID=16575'
  )
  row.names(non_cap_funding) <- NULL  # cleaning row.names
  non_cap_funding$value <- cumsum(non_cap_funding$value)  # making values cumulative
  
  ## Extracting CHD.FUN.140 // CAP Requirements
  sub <- fetchRequirement(1100)
  
  cap_required <- data.frame(
    indid = 'CHD.FUN.147',
    indicator_name = 'Nepal Earthquake Flash Appeal 2015 - Overview of Requirements and Funding (Requested)',
    dsid = 'fts-nepal-earthquake-2015',
    region = 'WLD',
    period = as.character(as.Date(sub$launch_date)),
    value = sub$current_requirements,
    source = 'http://fts.unocha.org/pageloader.aspx?page=emerg-emergencyDetails&emergID=16575'
  )
  row.names(cap_required) <- NULL  # cleaning row.names
  
  ## Extracting CHD.FUN.141 // CAP Funding
  sub <- df[
      (
        (df$status == 'Paid contribution' | df$status == 'Commitment')
        & df$appeal_id == 1100
        & df$is_allocation != 1
      ) | (df$donor == 'Central Emergency Response Fund' | df$donor == 'Common Humanitarian Fund'), 
    ]
  
  cap_funding <- data.frame(
    indid = 'CHD.FUN.148',
    indicator_name = 'Nepal Earthquake Flash Appeal 2015 - Overview of Requirements and Funding (Funding)',
    dsid = 'fts-nepal-earthquake-2015',
    region = 'WLD',
    period = row.names(tapply(sub$amount, sub$decision_date, sum)),
    value = tapply(sub$amount, sub$decision_date, sum),
    source = 'http://fts.unocha.org/pageloader.aspx?page=emerg-emergencyDetails&emergID=16575'
  )
  row.names(cap_funding) <- NULL  # cleaning row.names
  cap_funding$value <- cumsum(cap_funding$value)  # making values cumulative
  
  ## Extracting CHD.FUN.142 // CAP Funding Coverage
  sub <- df[
      (
        (df$status == 'Paid contribution' | df$status == 'Commitment')
        & df$appeal_id == 1100
        & df$is_allocation != 1
      ) | (df$donor == 'Central Emergency Response Fund' | df$donor == 'Common Humanitarian Fund'),
    ]


  ## Creating data.frame 
  cap_coverage <- data.frame(
    indid = 'CHD.FUN.149',
    indicator_name = 'Nepal Earthquake Flash Appeal 2015 - Overview of Requirements and Funding (Coverage)',
    dsid = 'fts-nepal-earthquake-2015',
    region = 'WLD',
    period = row.names(tapply(sub$amount, sub$decision_date, sum)),
    value = tapply(sub$amount, sub$decision_date, sum),
    source = 'http://fts.unocha.org/pageloader.aspx?page=emerg-emergencyDetails&emergID=16575'
  )
  row.names(cap_coverage) <- NULL  # cleaning row.names
  cap_coverage$value <- cumsum(cap_coverage$value)  # making values cumulative
  cap_coverage$value <- round((cap_coverage$value / cap_required$value), 3)  # calculating proportion
  
  ## Extracting CHD.FUN.143 // Pledges
  sub <- df[df$status == 'Pledge'
            & df$appeal_id != 0
            & df$is_allocation != 1, ]


  
  ## Using the value schema
  period_data = row.names(tapply(sub$amount, sub$decision_date, sum))
  value_data = tapply(sub$amount, sub$decision_date, sum)

  cap_pledges <- data.frame(
    indid = 'CHD.FUN.150',
    indicator_name = 'Nepal Earthquake Flash Appeal 2015 - Overview of Requirements and Funding (Pledges)',
    dsid = 'fts-nepal-earthquake-2015',
    region = 'WLD',
    period = ifelse(is.null(period_data), NA, period_data),
    value = ifelse(is.null(value_data), 0, value_data),
    source = 'http://fts.unocha.org/pageloader.aspx?page=emerg-emergencyDetails&emergID=16575'
  )
  row.names(cap_pledges) <- NULL  # cleaning row.names
  cap_pledges$value <- cumsum(cap_pledges$value)  # making values cumulative
  
  # Adding the indicators together.
  output <- rbind(cap_pledges, non_cap_pledges, non_cap_funding, cap_funding, cap_required, cap_coverage)
  
  cat('Done!\n')
  return(output)
}