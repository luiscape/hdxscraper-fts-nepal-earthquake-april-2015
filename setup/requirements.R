#
dependencies = c('sqldf', 'RCurl', 'rjson')

# There is the need for manual input
# if running it on the terminal.
for (i in 1:length(dependencies)) {
  install.packages(dependencies[i], repos='http://cran.us.r-project.org')
}