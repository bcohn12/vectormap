library(ggplot2)

horiz_barplot <- function(dtm)
{
	dtm$colour <- ifelse(dtm$value < 0, "firebrick1",
	   "steelblue")
	dtm$hjust <- ifelse(dtm$value > 0, 1.3, -0.3)
	a <- ggplot(dtm, aes(month, value, label = month,
	   hjust = hjust)) + geom_text(aes(y = 0,
	   colour = colour)) + geom_bar(stat = "identity",
	   aes(fill = colour))
	last_plot() + coord_flip() +labs(x = "", y = "") 
	   scale_x_discrete(breaks = NA) + theme_bw() 

	   a + coord_flip() + theme_bw() + scale_x_discrete(breaks=NULL) + theme(axis.title.x = element_blank()) + theme(legend.position="none")
}