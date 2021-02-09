# A function that identifies breaks in the 'condition' column, logs those breaks, and returns
# an updated graph with labels those condition-break points. The 'labels' value provided to
# the function should be a vector of strings, one for each condition. If you do not provide
# a string for each condition, R will throw an error due to a mismatching condition/label count.

addConditionLabels <- function(graph, data, labels) {
  
  # make list of condition
  conditions <- unique(data$condition)
  
  # list of locations of condition onset
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
      if (length(cl) + 1 == length(conditions)) { # if all conditions are accounted for, break
        break
      } else { # else, look for starting location of the next condition
        cl <- conditions[length(cl) + 1]
      }
      
    }
    
  }
  
  # add first condition to cl
  cl <- c(0,cl)
  
  # make data frame for intercepts
  clines <- data.frame(cl = cl, labels=labels)
  
  # update graph
  updatedGraph <- graph + geom_text(data=clines, aes(x=cl, y=max(data$bx1), label=labels), hjust=-0.1, inherit.aes = FALSE)
  
  # return updated graph
  return(updatedGraph)
  
}
