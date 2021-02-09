# graph-session-bxn.R
# This file produces an example graph with session-by-session data for up to 4 behaviors.
# Written by Harley Lang.
# Contributors: [add yourself here if you edit this document]
library(ggplot2)

# set your working directory to current directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load data from CSV file; here we loaded a file with 3 behaviors, but any number of bhx between 1-4 will work
data <- read.csv('./data/eg-session-bx3.csv', header = TRUE)

# graph aesthetics 
source('./functions/graphThemeTemplate.R')
graph <- graphThemeTemplate(data)

# set aspect ratio ~~
graph <- graph + coord_fixed(ratio=1.6)

# set labels ~~
graph <- graph + labs(title='An Example AB Graph', x="Sessions", y="Count per Measure")

# add trend lines and points ~~
source('./functions/addDataLinesAndPoints.R')
graph <- addDataLinesAndPoints(graph, data)

# add condition lines ~~
source('./functions/addConditionLines.R')
graph <- addConditionLines(graph, data)

# add condition labels ~~
source('./functions/addConditionLabels.R')
graph <- addConditionLabels(graph, data, labels=c('Condition 1', 'Condition 2'))
  
# view graph locally 
graph

# print graph to file
ggsave("graph-session-bxn.png", graph, width=16, height=10, units="cm")
