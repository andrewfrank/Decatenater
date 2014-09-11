require(ape)

boot.tree.file.all <- list.files(
	path=file.path(file.location,"bootstrap_trees"), 
	pattern = ".tre", 
	all.files=FALSE, 
	full.names=TRUE, 
	recursive=TRUE, 
	include.dirs=FALSE
)

data.trees <- lapply(boot.tree.file.all,read.nexus)

data.trees <- lapply(
	seq(1,length(data.trees)), 
	function(x) {
		temp <- which(data.trees[[x]]$tip.label == "I7492_JQR576_Scincidae_Plestiodon_gilberti")
		data.trees[[x]]$tip.label[temp] <- "I7492_JQR576_Scincidae_Plestiodon_skiltonianus"
		return(data.trees[[x]])
	}
)

names(data.trees) <- sub(
	"^([^.]*).*", 
	"\\1",
	basename(boot.tree.file.all)
)