#Define gene.stop.pos from gene.lengths
for (i in 1:length(gene.lengths)) {
	if (exists("gene.start.pos") == FALSE) {
		gene.start.pos <- gene.lengths[i] - (gene.lengths[i] - 1)
		gene.stop.pos <- gene.lengths[i]
	} else if (exists("gene.start.pos") == TRUE) {
		gene.start.pos <- c(gene.start.pos,(gene.lengths[i-1]+gene.start.pos[i-1]))
		gene.stop.pos <- c(gene.stop.pos,(gene.lengths[i]+gene.stop.pos[i-1]))
	}
}

taxa.exclude.sep <- strsplit(taxa.exclude, split=" ")

file.name.all <- list.files(
	path=".", 
	pattern = ".nex", 
	all.files=FALSE, 
	full.names=FALSE, 
	recursive=TRUE, 
	include.dirs=FALSE
)

file.name <- basename(file.name.all)

file.name.noext <- sub("^([^.]*).*", "\\1",file.name) #Modify file.name to exclude the file extension
