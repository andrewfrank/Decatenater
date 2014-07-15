### INPUT NEXUS FILE PARAMETERS ###

#Enter the full path to the Decatenater folder
file.location <- "~/Decatenater"

#Enter the names of the genes that make up your concatenated nexus file, in the order of their appearance
gene.names <- c(
	"ABHD13",
	"c3f39",
	"KBTBD2",
	"PROX1",
	"RAG1",
	"RAG2",
	"SCFD2",
	"SLC18A3",
	"SLC26A1",
	"ZFPM2"
	)

#Enter the length of the genes that make up your concatenated nexus file, in the order of their appearance
gene.lengths <- c(
	816,
	1398,
	1461,
	1551,
	1344,
	1236,
	651,
	930,
	975,
	1734
	)
	
#Optional - Enter the taxon sets you would like to iteratively exclude from analysis (using the exact name format that appears in your nexus file, with names separated by spaces)
taxa.exclude <- c(
	"Danio_rerio Homo_sapiens",
	"Danio_rerio Homo_sapiens Hydrolagus_novaezealandiae Callorhinchus_milii"
	)
	
#Enter PartitionFinder configuration options
branchlengths <- "linked" 		# linked | unlinked
models <- "all" 				# all | raxml | mrbayes | beast
model_selection <- "BIC"		# AIC | AICc | BIC
search <- "greedy" 				# all | user | greedy
	
### CODE BELOW DOES NOT NEED TO BE MODIFIED ###

setwd(file.path(file.location)) #Set working directory to file.location

source("scripts/prep.r")
source("scripts/paup_basefreqs.r")
source("scripts/gene_data.r")
source("scripts/pf_configs.r")
