if (exists("data.align") == FALSE) {
	source("scripts/read_gene_data.r")
}

if (file.exists(file.path(file.location,"phylip_data")) == FALSE) {

	dir.create(file.path("phylip_data")) #Create the subdir for the phy files
		
	lapply(
		seq(1,length(data.align)),
		function(x) {	
			write.dna(
				data.align[x],
				file=file.path(
					"phylip_data",
					paste0(
						names(data.align[x]),
						".phy"
					)
				),
				nbcol= -1, 
				format = "sequential", 
				colsep=""
			)
		}
	)

	if (length(taxa.exclude > 0)) {

		taxa.exclude.combn <- list()
		taxa.exclude.titles.combn <- list()
		taxa.exclude.titles.col <- c()

		for (b in 1:length(taxa.exclude.list)) {
	
			taxa.exclude.combn <- append(
				taxa.exclude.combn,
				combn(taxa.exclude.list,b,simplify=FALSE)
			)
		
			taxa.exclude.titles.combn <- append(
				taxa.exclude.titles.combn,
				combn(taxa.exclude.titles,b,simplify=FALSE)
			)			
		
		}
	
		for (x in 1:length(taxa.exclude.titles.combn)) {
	
			taxa.exclude.titles.col[x] <- paste(taxa.exclude.titles.combn[[x]],collapse="_")
		
		}

		for (c in 1:length(taxa.exclude.combn)) {
	
			data.align.exclude <- lapply(
				seq(1,length(data.align)),
				function(x) {
					data.align[[x]][-
						match(
							unlist(
								taxa.exclude.combn[[c]]
							),
							labels(data.align[[x]])
						)
					,]
				}
			)

			lapply(
				seq(1,length(data.align.exclude)),
				function(x) {	
					write.dna(
						data.align.exclude[[x]],
						file=file.path(
							"phylip_data",
							paste0(
								names(data.align[x]),
								"_",
								taxa.exclude.titles.col[c],
								".phy"
							)
						),
						nbcol= -1, 
						format = "sequential", 
						colsep=""
					)
				}
			)
		}
	}
}