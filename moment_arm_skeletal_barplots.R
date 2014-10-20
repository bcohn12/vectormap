##' @author Brian Cohn \email{brian_cohn14@@pitzer.edu}
##' setwd('dev//sohn_data/')
R_av <- read.csv('output/R_av.csv', stringsAsFactors = FALSE, header=FALSE)
R_sd <- read.csv('output/R_sd.csv', stringsAsFactors = FALSE, header=FALSE)



source('moment_arm_barplot_functions.R')



abbrevs = c('adf',
'adl',
'bfa',
'bfp',
'edl',
'fdl',
'fhl',
'gmax',
'gmed',
'gmin',
'grac',
'lg',
'mg',
'pb',
'pec',
'pl',
'plan',
'psoas',
'pt',
'pyr',
'qf',
'rf',
'sart',
'sm',
'sol',
'st',
'ta',
'tp',
'vi',
'vl',
'vm')

DOFs = c('HF',
'HAd',
'HR',
'KE',
'KA',
'AE',
'AAd')

colnames(R_av) = abbrevs
colnames(R_sd) = abbrevs
rownames(R_av) = DOFs
rownames(R_sd) = DOFs

R_av <- as.matrix(R_av)
R_sd <- as.matrix(R_sd)

source('moment_arm_barplot_functions.R')
 pdf(file="figs/R_catleg_av.pdf", width=5.3, height=5.3)
barplot_per_dof(R_av*100)
 dev.off()

  pdf(file="figs/R_catleg_std.pdf", width=5.3, height=5.3)
barplot_per_dof(R_sd)
 dev.off()

 #



# barplot(revdf, horiz=TRUE)

##################EMILY's ARM THROW PLOTS############



source('moment_arm_barplot_functions.R')
	arm_R <-as.matrix(read.csv('frisbee_R_matrix_10_1_2014.csv',stringsAsFactors=FALSE, row.names=1))
	arm_R <- data.matrix(arm_R, rownames.force = TRUE)
	pdf(file="figs/R_arm.pdf", width=5.3, height=5.3)
	barplot_per_dof(arm_R)
	 dev.off()
