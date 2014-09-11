if (exists("trees.total.length") == FALSE) {	
	source("scripts/calc_total_tree_lengths.r")
}

dir.create(path=file.path(file.location,"tree_stats")) #Create the subdir for tree stats

trees.total.length.stats <- summary(trees.total.length)

pdf(file=file.path(file.location,"tree_stats","total_tree_lengths.pdf"), width=10, paper="USr")

	layout(
		matrix(c(1,2), 1,2, byrow=TRUE), 
		widths=c(0.75,0.25)
	)
	
	plot(
		trees.total.length,
		xlab="Loci Trees",
		ylab="Total Tree Length",
		frame.plot=FALSE
	)
	
	legend(
		legend=paste(
			names(trees.total.length.stats),
			trees.total.length.stats,
			sep=' : '
		),
		x="top",
		ncol=2,
		inset=-0.155,
		xpd=NA
	)
		
	boxplot(
		trees.total.length,
		frame.plot=FALSE
	)
	
dev.off()