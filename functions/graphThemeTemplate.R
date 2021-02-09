graphThemeTemplate <- function(data) {
  return(
    ggplot() + 
      scale_x_continuous(expand = c(0, 0), 
        limits=c(0, max(data$session) + 0.5)) +
      scale_y_continuous(expand = c(0, 0), 
        labels = scales::number_format(accuracy = 1), # remove decimal points, change accuracy to add decimals (e.g., `0.1`)
        limits=c(0, max(data$bx1) + 0.5)) +
      theme_classic() + 
      theme(
        axis.line.x = element_line(colour="black"),
        axis.line.y = element_line(colour="black"),
        axis.title.x = element_text(size=12,colour="black",family="Arial"),
        axis.title.y = element_text(size=12,colour="black",family="Arial"),
        axis.text.x = element_text(size=12,colour="black",family="Arial"),
        axis.text.y = element_text(size=12,colour="black",family="Arial"),
        plot.title = element_text(size=12,colour="black",family="Arial",face="bold")
      )
  )
}

