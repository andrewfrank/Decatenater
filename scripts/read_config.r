### Specify the input configuration file ###

#Get list of all config.txt files in the Decatenater directory
config.file.all <- list.files(
	path=".", 
	pattern = "config.txt", 
	all.files=FALSE, 
	full.names=FALSE, 
	recursive=TRUE, 
	include.dirs=FALSE
)

#Check how many configuration files are in the Decatenater directory
if (length(config.file.all) > 1) {
	print("Please include only a single configuration file in the Decatenater directory")
	
} else if (length(config.file.all) == 1) {

	config.file <- basename(config.file.all) #Remove any file path syntax from config.file.all

	### Define variables from configuration file ###

	config <- scan(file=config.file, what="character")

	gene.names <- config[
		(which(config == "[Gene_Names]") + 1) : (which(config == "[Gene_Lengths]") - 1)
	]

	gene.lengths <- as.numeric(config[
		(which(config == "[Gene_Lengths]") + 1) : (which(config == "[Taxon_Exclusion_Groups]") - 1)
	]
	)

	taxa.exclude <- config[
		(which(config == "[Taxon_Exclusion_Groups]") + 1) : length(config)
	]

	### Check if taxon exclusion groups have been specified, create taxa.exclude.list variable ###
	if (NA %in% taxa.exclude == FALSE) {

		taxa.exclude.list <- list() #Establish taxa.exclude.list as empty list
	
		pos <- grep("\\[",taxa.exclude) #Identify where in taxa.exclude the group titles are
		taxa.exclude.titles <- taxa.exclude[pos]
		taxa.exclude.titles <- gsub("\\[","",taxa.exclude.titles)
		taxa.exclude.titles <- gsub("\\]","",taxa.exclude.titles)	
	
		#Extract taxa per group of specified taxa, place into taxa.exclude.list
		for (i in 1:length(pos)) {
			if (i != length(pos)) {
				taxa.exclude.list[[i]] <- taxa.exclude[
					(pos[i] + 1) : (pos[i + 1] - 1)
				]
			} else if (i == length(pos)) {
				taxa.exclude.list[[i]] <- taxa.exclude[
					(pos[i] + 1) : length(taxa.exclude)
				]
			}
		}
			
	}

	#Define gene start and stop positions from gene.lengths
	for (i in 1:length(gene.lengths)) {
		if (exists("gene.start.pos") == FALSE) {
			gene.start.pos <- gene.lengths[i] - (gene.lengths[i] - 1)
			gene.stop.pos <- gene.lengths[i]
		} else if (exists("gene.start.pos") == TRUE) {
			gene.start.pos <- c(gene.start.pos,(gene.lengths[i-1]+gene.start.pos[i-1]))
			gene.stop.pos <- c(gene.stop.pos,(gene.lengths[i]+gene.stop.pos[i-1]))
		}
	}

	### Specify the input nexus file ###

	#Get list of all phylip files in the Decatenater directory
	file.name.all <- list.files(
		path=".", 
		pattern = ".phy", 
		all.files=FALSE, 
		full.names=FALSE, 
		recursive=FALSE, 
		include.dirs=FALSE
	)

	#Check if there's only one nexus file in the Decatenater directory
	if (length(file.name.all) > 1) {
		print("Please include only a single concatenated phylip file in the Decatenater directory")
	} else
		file.name <- basename(file.name.all) #Remove any file path syntax from file.name.all
		file.name.noext <- sub("^([^.]*).*", "\\1",file.name) #Modify file.name to exclude the file extension

} else if (length(config.file.all) < 1) {
	taxa.exclude <- c()	
}