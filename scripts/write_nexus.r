if (exists("data.align") == FALSE) {
	source("scripts/read_gene_data.r")
}

dir.create(file.path("nexus_data")) #Create the subdir for the nexus files
		
lapply(
	seq(1,length(data.align)),
	function(x) {	
		write.nexus.data(
			as.list(data.align[[x]]),
			file=file.path(
				"nexus_data",
				paste0(
					names(data.align[x]),
					".nex"
				)
			),
			interleaved = FALSE
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
				write.nexus.data(
					as.list(data.align.exclude[[x]]),
					file=file.path(
						"nexus_data",
						paste0(
							names(data.align[x]),
							"_",
							taxa.exclude.titles.col[c],
							".nex"
						)
					),
					interleaved = FALSE
				)
			}
		)
	}
}