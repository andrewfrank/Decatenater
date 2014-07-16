dir.create(file.path("partitionfinder config files")) #Create the subdir for all the partition finder config files

for (a in 1:length(gene.names)) {

	sink(
		file.path(
			"partitionfinder config files",
			paste(gene.names[a],".cfg", sep="")
		)
	)
	
		cat("## ALIGNMENT FILE ##")
		cat("\n")
		cat(paste("alignment = ",gene.names[a],".phy;",sep=""))
		cat("\n")
		cat("\n")
		cat("## BRANCHLENGTHS: linked | unlinked ##")
		cat("\n")
		cat(paste("branchlengths = ",branchlengths,";",sep=""))
		cat("\n")
		cat("\n")
		cat("## MODELS OF EVOLUTION for PartitionFinder: all | raxml | mrbayes | beast | <list> ##")
		cat("\n")
		cat("##              for PartitionFinderProtein: all_protein | <list> ##")
		cat("\n")
		cat(paste("models = ",models,";",sep=""))
		cat("\n")
		cat("\n")
		cat("# MODEL SELECTION: AIC | AICc | BIC #")
		cat("\n")
		cat(paste("model_selection = ",model_selection,";",sep=""))
		cat("\n")
		cat("\n")
		cat("## DATA BLOCKS: see manual for how to define ##")
		cat("\n")
		cat("[data_blocks]")
		cat("\n")
		cat(paste("pos1 = 1-",gene.lengths[a],"\\3;", sep=""))
		cat("\n")
		cat(paste("pos2 = 2-",gene.lengths[a],"\\3;", sep=""))
		cat("\n")
		cat(paste("pos3 = 3-",gene.lengths[a],"\\3;", sep=""))
		cat("\n")
		cat("\n")
		cat("## SCHEMES, search: all | user | greedy ##")
		cat("\n")
		cat("[schemes]")
		cat("\n")
		cat(paste0("search = ",search,";"))
		cat("\n")
		cat("\n")
		cat("#user schemes go here if search=user. See manual for how to define.#")
		cat("\n")
		
	sink()
	
}		