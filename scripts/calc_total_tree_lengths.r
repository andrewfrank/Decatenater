if (exists("data.trees") == FALSE) {	
	source("scripts/read_trees.r")
}

trees.total.length <- unlist(
	lapply(
		data.trees, 
		function(x) {
			sum(x$edge.length)
		}
	)
)