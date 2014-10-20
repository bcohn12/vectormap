##' @title Generate Muscle Activation Plot
##' @param muscle_names Vector of strings, each string is a muscle
##' @param activations Numeric vector of normalized activations (between 0.0 and 1.0)
##' @value Base-R vertical barplot in alphabetic order.
##' @author Brian Cohn \email{brian_cohn14@@pitzer.edu}
##' @export
muscle_activation_barplot<- function(muscle_names, activations){
    muscle_activations <- data.frame(rbind(muscles = muscles,activation = vec[1:31]))

    ac_vec<- t(data.frame(activation = vec[1:31]))
    colnames(ac_vec) = muscles #strings
    barplot(ac_vec, xlab="Muscle", ylab="Unit Activation", ylim = c(0,1))
}


sohnmuscle_fullname <- function(muscle_num, fullname=FALSE){
	short <- c( 'adf'  ,
				'adl'  ,
				'bfa'  ,
				'bfp'  ,
				'edl'  ,
				'fdl' ,
				'fhl'  ,
				'gmax' ,
				'gmed' ,
				'gmin',
				'grac' ,
				'lg'   ,
				'mg'   ,
				'pb'   ,
				'pec'  ,
				'pl'   ,
				'plan' ,
				'psoas',
				'pt'   ,
				'pyr'  ,
				'qf'   ,
				'rf'   ,
				'sart' ,
				'sm'   ,
				'sol'  ,
				'st'   ,
				'ta'   ,
				'tp'   ,
				'vi'   ,
				'vl'   ,
				'vm'   )

	muscle_fullnames<- c("Adductor femoris",
						"Adductor longus",
						"Biceps femoris anterior",
						"Biceps femoris posterior",
						"Extensor digitorum longus",
						"Flexor digitorum longus",
						"Gluteus maximus",
						"Gluteus minimus",
						"Gracilis",
						"Lateral gastrocnemius",
						"Medial gastrocnemius",
						"Peroneus brevis",
						"Pectineus",
						"Peroneus longus",
						"Plantaris",
						"Iliopsoas",
						"Peroneus tertius",
						"Pyriformis",
						"Quadratus femoris",
						"Rectus femoris",
						"Sartorius",
						"Semimembranossus",
						"Soleus",
						"Semitendinosus",
						"Tibialis anterior",
						"Tibialis posterior",
						"Vastus intermedius",
						"Vastus lateralis",
						"Vastus medialis")
	if (fullname)	{
		return (muscle_fullnames[muscle_num])
	} else {
		return (short[muscle_num])
	}
}

feasible_activation_plot <- function(muscle_num, alpha, upper, lower) {
	muscle_short <- sohnmuscle_fullname(muscle_num)
	muscle_full <- sohnmuscle_fullname(muscle_num, TRUE)
	plot(alpha, upper, xlab=expression(alpha), 
		main=muscle_full, 
		ylim=c(0,1), 
		ylab="Activation",
		asp=1)
	points(alpha, lower, pch=20)
	 polygon(c(alpha, rev(alpha)),
	 		c(upper, rev(lower)), 
   col=rgb(1, 0, 0,0.5), border = NA, ) 

}

bound_subset <- function(muscle_num, specimen=1, muscleDB){
	muscleDB[muscleDB[,1]==specimen & muscleDB[,2]==muscle_num,]
}

# muscle_activation_barplot(muscle_fullnames, activations)
main <- function(){

	pdf("alpha_plots3.pdf", width=20, height=20)
	db <- as.matrix(read.csv("output/muscle_database.csv"))
	colnames(db) <- c('specimen', 'muscle', 'alpha', 'lower', 'upper')
	par(mfrow=c(6,6))
	speciesNUM=3
	for (i in 1:31) {
		m_subset <- bound_subset(muscle_num = i, specimen=speciesNUM, db)
		feasible_activation_plot(i,m_subset[,3], m_subset[,5], m_subset[,4])
	}
	dev.off()
}


