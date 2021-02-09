# A function that identifies (1) the number of bxs defined in the provided data (up to 4) and,
# (2) graphs those data accordingly.
library(dplyr, reshape2) 

addDataLinesAndPoints <- function(graph, data, legend, labels) { # legend: boolean; labels: vector (leave empty eg. c() if no legend)
  
  # purify function by assigning graph to new var
  updatedGraph <- graph
  df <- data
  
  # get list of data column names that begin with 'bx'
  bxs <- colnames(data)[grepl('bx',colnames(data))]
  
  # throw warning if applicable
  if (length(bxs) > 4) { stop('MORE THAN 4 MEASURES DETECTED. Please submit an issue to repo for assistance with adding more measures.') }
  
  # create list of symbols; circle, triangle, square, x
  syms <- c(16, 17, 15, 4) 
  
  # create list of line styles for better readability
  linestyles <- c('solid', 'dashed', 'dotted', 'dotdash')
  
  # add each bx to the graph
  for (i in seq(length(bxs))) {
   
    df[[paste0(bxs[i],'sym')]] = rep(syms[i],length(df$session))
    df[[paste0(bxs[i],'line')]] = rep(linestyles[i],length(df$session)) 
    
  }
  
  # some data transformation magik
  dfSession <- melt(data, id.vars='session')
  
  dfSession <- dfSession[!(dfSession$variable=='condition'),]
  
  dfCondition <- melt(data, id.vars='condition')
  
  dfCondition <- dfCondition[!(dfCondition$variable=='session'),]
  
  # make lines ~~
  lines <- geom_line(data=dfSession, 
                     aes(x=session, y=value, group=interaction(variable, dfCondition$condition), linetype=variable), 
                     colour="black", size=0.5, show.legend = FALSE)
  # make points ~~
  points <- geom_point(data=dfSession, 
                      aes(x=session, y=value, group=interaction(variable, dfCondition$condition), shape=variable), 
                      colour="black", size=2.5, show.legend = legend)
  
  # add lines and points ~~
  updatedGraph <- updatedGraph + lines + points
  
  # label legend
  updatedGraph <- updatedGraph + 
    scale_linetype_manual(labels=labels, values=linestyles[1:length(bxs)]) +
    scale_shape_manual(labels=labels, values=syms[1:length(bxs)])
  
  # style legend
  updatedGraph <- updatedGraph + 
    theme(
      legend.title = element_blank(),
      legend.position = 'bottom',
      legend.text = element_text(size=10,colour="black",family="Arial")
    )
  
  # return updated graph
  return(updatedGraph)
  
}
