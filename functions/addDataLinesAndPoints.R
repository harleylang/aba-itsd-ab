# A function that identifies (1) the number of bxs defined in the provided data (up to 4) and,
# (2) graphs those data accordingly.
library(dplyr) 

addDataLinesAndPoints <- function(graph, data) {
  
  # purify function by assigning graph to new var
  updatedGraph <- graph
  
  # get list of data column names that begin with 'bx'
  bxs <- colnames(data)[grepl('bx',colnames(data))]
  
  # throw warning if applicable
  if (length(bxs) > 4) { stop('MORE THAN 4 MEASURES DETECTED. Please submit an issue to repo for assistance with adding more measures.') }
  
  # create list of symbols; circle, triangle, square, x
  syms <- c(16, 17, 15, 4) 
  
  # create list of line styles for better readability
  styles <- c('solid', 'dashed', 'dotted', 'dotdash')
  
  # add each bx to the graph
  for (i in seq(length(bxs))) {
    
    # create new data frame for each bx
    df <- data.frame(session=data$session, score=data[[bxs[i]]], condition=data$condition)
    
    # add lines ~~
    lines <- geom_line(data=df, aes(x=session, y=score, group=condition), linetype=styles[i], colour="black", size=0.5)
  
    # add lines ~~
    points <- geom_point(data=df, aes(x=session, y=score, group=condition), shape=syms[i], colour="black", size=2.5)
    
    # update the graph
    updatedGraph <- updatedGraph + lines + points
    
  }
  
  # return updated graph
  return(updatedGraph)
  
}
