# graph-session-bx1.R
# This file produces an example graph with session-by-session data for 1 behavior.
# Written by Harley Lang.
# Contributors: [add yourself here if you edit this document]
library(ggplot2)

# set your working directory to current directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load data from CSV file
data <- read.csv('./data/eg-session-bx1.csv', header = TRUE)

# graph aesthetics 
source('./functions/graphThemeTemplate.R')
graph <- graphThemeTemplate(data)

# set aspect ratio ~~
graph <- graph + coord_fixed(ratio=1.6)

# set labels ~~
graph <- graph + labs(title='An Example AB Graph', x="Sessions", y="Count per Measure")

# add trend lines ~~
graph <- graph + geom_line(aes(x=data$session, y=data$score, group=data$condition), colour="black", size=0.5)

# add the data points ~~
graph <- graph + geom_point(aes(x=data$session, y=data$score, group=data$condition), colour="black", size=2.5)

# add condition lines ~~
source('./functions/addConditionLines.R')
graph <- addConditionLines(graph, data)

# add condition labels ~~
source('./functions/addConditionLabels.R')
graph <- addConditionLabels(graph, data, labels=c('Condition 1', 'Condition 2'))
  
# view graph locally 
graph

# print graph to file
ggsave("graph-session-bx1.png", graph, width=16, height=10, units="cm")
