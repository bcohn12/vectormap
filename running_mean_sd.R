main <- function() {
	args <- commandArgs(TRUE)
	value_data <- read.csv(args[1])
	# loop over multiple runs
	print(value_data[,1])
	}
main()