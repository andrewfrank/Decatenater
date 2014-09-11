require(ape)

if (file.exists(file.path(file.location,"phylip_data")) == TRUE) {

	taxa <- list(
		c("I7498_SK_02_Scincidae_Plestiodon_longirostris"),
		c("I7488_EULA_02_Scincidae_Plestiodon_skiltonianus"),
		c("I7489_JQR025_Scincidae_Plestiodon_gilberti","I7496_JQR1589_Scincidae_Plestiodon_gilberti"),
		c("I7497_JQR1615_Scincidae_Plestiodon_gilberti","I7490_JQR517_Scincidae_Plestiodon_gilberti"),
		c("I7491_JQR552_Scincidae_Plestiodon_gilberti"),
		c("I7487_CAS223944_Scincidae_Plestiodon_skiltonianus"),
		c("I7495_JQR1255_Scincidae_Plestiodon_skiltonianus"),
		c("I7492_JQR576_Scincidae_Plestiodon_skiltonianus"),
		c("I7493_JQR792_Scincidae_Plestiodon_skiltonianus")
	)
	
	taxa.short <- list(
		c("SK_02_P_longirostris_(outgroup)"),
		c("EULA_02_P_skiltonianus_(lagunensis)"),
		c("JQR025_P_gilberti_(sierran)","JQR1589_P_gilberti_(sierran)"),
		c("JQR1615_P_gilberti_(southern)","JQR517_P_gilberti_(southern)"),
		c("JQR552_P_gilberti_(inyo)"),
		c("CAS223944_P_skiltonianus_(group_9)"),
		c("JQR1255_P_skiltonianus_(group_5)"),
		c("JQR576_P_skiltonianus_(group_3)"),
		c("JQR792_P_skiltonianus_(group_7)")
	)

	require(ape)

	### Custom data read-in ###
	
	data.align.file.all <- list.files(
		path=file.path(file.location,"phylip_data"), 
		pattern = ".phy", 
		all.files=FALSE, 
		full.names=TRUE, 
		recursive=TRUE, 
		include.dirs=FALSE
	)
	
	data.align.file <- basename(data.align.file.all)
	data.align.file.noext <- sub("^([^.]*).*", "\\1",data.align.file) #Modify data.align.file to exclude the file extension

	data.align <- lapply(
		data.align.file,
		function(x) {
			read.dna(
				file.path(file.location,"phylip_data",x),
				format="sequential"
			)	
		}
	)
	
	names(data.align) <- data.align.file.noext
	
} else if (file.exists(file.path(file.location,"phylip_data")) == FALSE) {

	data.align <- read.dna(file.name) #Read in concatenated phylip file as a DNAbin object

	gene.pos <- lapply(
		seq(1:length(gene.start.pos)), 
		function(x) {	
			c(gene.start.pos[x],gene.stop.pos[x])
		}
	)
	
	data.align <- lapply(
		gene.pos,
		function(x) {
			as.matrix(data.align)[,x[1]:x[2]]
		}
	)
	
	names(data.align) <- gene.names
	
}