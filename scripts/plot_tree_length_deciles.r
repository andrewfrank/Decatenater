if (exists("trees.total.length") == FALSE) {
	
	source("scripts/calc_total_tree_lengths.r")

}

require(phangorn)

trees.total.length.deciles <- lapply(
	quantile(
		trees.total.length, 
		prob = seq(0, 1, 0.1)
	),
	function(x) {
		which(trees.total.length > x)
	}
)

data.trees.decile <- data.trees[names(trees.total.length.deciles[["50%"]])]
class(data.trees.90) <- "multiphylo"

#data.trees.90 <- lapply(
#	data.trees.90, 
#	function(x) {
#		root(x, outgroup="I7498_SK_02_Scincidae_Plestiodon_longirostris", resolve.root=TRUE)
#	}
#)

data.trees.decile <- lapply(
	data.trees.decile, 
	function(x) {
		midpoint(x)
	}
)

dir.create(path=file.path(file.location,"tree_decile_pdfs")) #Create the subdir for tree stats

pdf(file=file.path(file.location,"tree_decile_pdfs","50th_percentile_midroot.pdf"), height=10, paper="US")

	layout(
		matrix(c(1,2,3,4), 2,2, byrow=TRUE),
	)
	
	par(xpd=NA)
	
	lapply(
		seq(1,length(data.trees.decile)),
		function(x) {
			plot.phylo(
				data.trees.decile[[x]],
				show.node.label=TRUE, 
#				no.margin=TRUE, 
				cex=0.5
			)
			add.scale.bar(
				x=-0.0001278259,
				y=-0.5870881,
				xpd=NA
			)
			title(names(data.trees.decile[x]))
		}
	)
	
dev.off()