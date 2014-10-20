
##' @param dtm dataframe with $muscles and $cm (positive or negative)
##' @value plots a barplot
##' @author Brian Cohn \email{brian_cohn14@@pitzer.edu}
##' @export
horiz_barplot <- function(dtm, filename='default.pdf', DOF="")
{
	library(ggplot2)
	dtm$colour <- ifelse(dtm[,2] < 0, "firebrick3", "darkolivegreen3")
	dtm$hjust <- ifelse(dtm$cm > 0, 1, 0)
	print(dtm)
	
	a <- ggplot(dtm, aes(x=reorder(muscles,cm), y=cm, label = muscles,
	   hjust = hjust)) + geom_text(aes(y = 0,
	   colour = colour)) + geom_bar(stat = "identity",
	   aes(fill = colour))
	last_plot() + coord_flip() +labs(x = "", y = "") 
	   scale_x_discrete(breaks = NA) + theme_bw()

	  p<- a + coord_flip() + theme_bw()  + scale_x_discrete(breaks=NULL) +
	    theme(axis.title.y = element_blank()) + theme(legend.position="none") +
	    theme(panel.border=element_blank()) + ylim(-5.40,5.40)+
	    labs(title = paste('DOF ', DOF))
  
  print(p)
  

}


##' @param R_mat Matrix with DOF as labeled rows, and columns as muscles acting on a given joint (typically in a unit of length).
##' @value plots barplot for each DOF.
##' @author Brian Cohn \email{brian_cohn14@@pitzer.edu}
##' @export
barplot_per_dof <- function(R_mat) {
for (i in 1:(length(R_mat[,1]))) {
	df <- data.frame(sort(R_mat[i,]))
	onlypos_nums <- df[df[,1]>0,]
	newdf <- data.frame(onlypos_nums)
	rownames(newdf) <- rownames(df)[df[,1]>0]
	# barplot(as.matrix(t(newdf)),
	# 				  horiz=TRUE,
	# 				  xlab=paste(DOFs[i], "Positive"),
	# 				  las=2,
	# 				  xlim=c(0,.036))
	positives <- as.matrix(t(newdf))

	onlyneg_nums <- df[df[,1]<0,]
	newdf <- data.frame(onlyneg_nums)
	rownames(newdf) <- rownames(df)[df[,1]<0]
	rev_vec <- rev(as.matrix(t(newdf*-1)))
	revdf <- t(data.frame(rev_vec))
	colnames(revdf) <- rev(colnames(as.matrix(t(newdf*-1))))
	# barplot( revdf,
	# 		 horiz=TRUE,
	# 		 xlab=paste(DOFs[i], "negative"),
	# 		 las=2,
	# 		 xlim=c(0,.036))
	negatives <- revdf
	
	if(length(negatives[,1])!=0){
	moment_arms <- rbind(t(positives), t(negatives*-1))
} else {
	moment_arms <- rbind(t(positives))
}
	muscles <- rownames(moment_arms)
	newmomentarms <- data.frame(muscles= as.character(muscles),cm=as.numeric(moment_arms[,1]), row.names=NULL)
	horiz_barplot(newmomentarms, filename=paste0('output/','DOF',i,'_', DOFs[i], '.pdf'), DOF=rownames(R_mat)[i])
}#endfor

}