# A helper function to identify the highest X value; esp. helpful
# when you have defined multiple measures in your data, for auto-scaling
# the y-axis.

findMaxY <- function(data) {
  
  # get list of data column names that begin with 'bx'
  bxs <- colnames(data)[grepl('bx',colnames(data))]
  
  # throw warning if applicable
  if (length(bxs) > 4) { stop('MORE THAN 4 MEASURES DETECTED. Please submit an issue to repo for assistance with adding more measures.') }
  
  # this var will hold the max Y, and will be updated while iterating over each measure / bx
  maxY <- 0
  
  # iterate over each bx; for each response ...
  for (i in seq(length(bxs))) {
    
    # max value for THIS bx
    maxVal <- max(data[[bxs[i]]])
    
    # if maxY is less than current maxVal
    if (maxY < maxVal) {
      
      # set maxY to that value!
      maxY <- maxVal
      
    }
    
  }
  
  return(maxY)
  
}
