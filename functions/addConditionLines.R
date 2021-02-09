# A function that identifies breaks in the 'condition' column, logs those breaks, and returns
# an updated graph with lines at those condition-break points.

addConditionLines <- function(graph, data) {
  
  # make list of condition
  conditions <- unique(data$condition)
  
  # empty list of locations of condition lines
  cl <- c()
  
  # look for first coord at the second condition! that's the first coord to draw a line at
  condition <- conditions[2]
  
  # iterate over rows
  for (i in seq(nrow(data))) {
    
    # if equal to current condition
    if (condition == data$condition[i]) {
      
      # add coord to list of condition lines
      cl <- c(cl, i - 0.5)
      
      # check if next condition exists
      if (length(cl) + 1 == length(conditions)) { # if all conditions are captured, break
        break
      } else { # else, look for starting location of the next condition
        cl <- conditions[length(cl) + 1]
      }
      
    }
    
  }
  
  # make data frame for intercepts
  clines <- data.frame(cl = cl)
  
  # update graph
  updatedGraph <- graph + geom_vline(data=clines, aes(xintercept=as.numeric(cl)), colour="black", linetype="dashed", size=0.5)
  
  # return updated graph
  return(updatedGraph)
  
}
