### INPUT NEXUS FILE PARAMETERS ###

#Enter the full path to the Decatenater folder
file.location <- "/~/Google Drive/Personal/Code/Decatenater"
	
#Enter PartitionFinder configuration options
branchlengths <- "linked" 		# linked | unlinked
models <- "all" 				# all | raxml | mrbayes | beast
model_selection <- "BIC"		# AIC | AICc | BIC
search <- "greedy" 				# all | user | greedy
	
### CODE BELOW DOES NOT NEED TO BE MODIFIED ###

setwd(file.path(file.location)) #Set working directory to file.location

source("scripts/read_config.r")

source("scripts/read_gene_data.r")

source("scripts/write_phylip.r")
source("scripts/write_nexus.r")

source("scripts/pf_configs.r")

source("scripts/paup_basefreqs.r")

#source("scripts/read_trees.r")
#source("scripts/calc_total_tree_lengths.r")