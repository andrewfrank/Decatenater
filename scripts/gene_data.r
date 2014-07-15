require(ape) #Used for read.nexus.data
data.nexus <- as.DNAbin(read.nexus.data(file.name)) #Read in nexus file as a DNAbin object

dir.create(file.path("nexus files")) #Create the subdir for all the nexus files
dir.create(file.path("phy files")) #Create the subdir for all the phy files

for (a in 1:length(gene.names)) {

	data.gene.matrix <- as.matrix(data.nexus)[,gene.start.pos[a]:gene.stop.pos[a]] #Need to refer to data.nexus as a matrix in order to extract gene
	data.gene.list <- as.list(data.gene.matrix) #Then convert it to a list in order for write.nexus.data to work
	
	#Write nexus file
	write.nexus.data(
		data.gene.list,
		file=file.path(
			"nexus files",
			paste(gene.names[a],".nex",sep="")
			)
	)
	
	#Write phy file
	write.dna(
		data.gene.list, 
		file=file.path(
			"phy files",
			paste(gene.names[a],".phy",sep="")
			),
		nbcol= -1, 
		format = "interleaved", 
		colsep=""
	)

}

if (length(taxa.exclude > 0)) {

	for (c in 1:length(taxa.exclude.sep)) {
	
		dir.create(file.path("nexus files",paste0("exclude set ",c))) #Create the subdir for nexus files from this taxa exclusion set
		dir.create(file.path("phy files",paste0("exclude set ",c))) #Create the subdir for phy files from this taxa exclusion set
	
		for (d in 1:length(gene.names)) {

			data.gene.matrix <- as.matrix(data.nexus)[,gene.start.pos[d]:gene.stop.pos[d]] #Need to refer to data.nexus as a matrix in order to extract gene
			data.gene.list <- as.list(data.gene.matrix) #Then convert it to a list in order for write.nexus.data to work

			taxa.exclude.num <- match(unlist(taxa.exclude.sep[c]),labels(data.gene.list))
			data.gene.exclude <- data.gene.list[-taxa.exclude.num]

			#Write nexus file
			write.nexus.data(
				data.gene.exclude,
				file=file.path(
					"nexus files",
					paste0("exclude set ",c),
					paste(gene.names[d],"_excludeSet",c,".nex",sep="")
					)
			)
	
			#Write phy file
			write.dna(
				data.gene.exclude, 
				file=file.path(
					"phy files",
					paste0("exclude set ",c),
					paste(gene.names[d],"_excludeSet",c,".phy",sep="")
					),
				nbcol= -1, 
				format = "interleaved", 
				colsep=""
			)
			
		}
	}
}

setwd(file.path(file.location)) #Set back to original wd
