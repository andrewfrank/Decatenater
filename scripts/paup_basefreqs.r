dir.create(file.path("paup basefreqs files")) #Create the subdir for all the nexus files

sink(file.path("paup basefreqs files","paup_basefreqs.nex")) #Write paup basefreqs execution nexus file

	cat("#NEXUS", sep="\n")
	cat("", sep="\n")
	cat("BEGIN SETS;", sep="\n")

	if (length(taxa.exclude > 0)) {	
		for (b in 1:length(taxa.exclude)) {
			cat(paste("taxset excludeset",b," = ",taxa.exclude[b],";", sep=""), sep="\n")
		}
	}
	
	cat("", sep="\n")
	cat("BEGIN PAUP;", sep="\n")
	cat(paste("log file = ",file.name.noext,"_basefreqs.log replace=yes;", sep=""), sep="\n")
	cat(paste("execute ",file.name, sep=""), sep="\n")
	cat("", sep="\n")
	
	for (c in 1:length(gene.names)) {
		cat(paste("charset ",gene.names[c],"_1stpos = 1-",gene.stop.pos[c],"\\3;", sep=""), sep="\n")
		cat(paste("charset ",gene.names[c],"_2ndpos = 2-",gene.stop.pos[c],"\\3;", sep=""), sep="\n")
		cat(paste("charset ",gene.names[c],"_3rdpos = 3-",gene.stop.pos[c],"\\3;", sep=""), sep="\n")
		cat("", sep="\n")
	}	
	
	for (d in 1:length(gene.names)) {
		cat("EXCLUDE all;", sep="\n")
		cat(paste("INCLUDE ",gene.names[d],"_1stpos;", sep=""), sep="\n")
		cat("basefreqs;", sep="\n")
		cat("EXCLUDE all;", sep="\n")
		cat(paste("INCLUDE ",gene.names[d],"_2ndpos;", sep=""), sep="\n")
		cat("basefreqs;", sep="\n")
		cat("EXCLUDE all;", sep="\n")
		cat(paste("INCLUDE ",gene.names[d],"_3rdpos;", sep=""), sep="\n")
		cat("basefreqs;", sep="\n")
		cat("", sep="\n")
	}
	
	if (length(taxa.exclude > 0)) {
		for (e in 1:length(taxa.exclude)) {
			cat(paste("delete excludeset",e,";", sep=""), sep="\n")
			cat("", sep="\n")
			for (d in 1:length(gene.names)) {
				cat("EXCLUDE all;", sep="\n")
				cat(paste("INCLUDE ",gene.names[d],"_1stpos;", sep=""), sep="\n")
				cat("basefreqs;", sep="\n")
				cat("EXCLUDE all;", sep="\n")
				cat(paste("INCLUDE ",gene.names[d],"_2ndpos;", sep=""), sep="\n")
				cat("basefreqs;", sep="\n")
				cat("EXCLUDE all;", sep="\n")
				cat(paste("INCLUDE ",gene.names[d],"_3rdpos;", sep=""), sep="\n")
				cat("basefreqs;", sep="\n")
				cat("", sep="\n")
			}
			cat(paste("restore excludeset",b,";", sep=""), sep="\n")
			cat("", sep="\n")		
		}
	}
	
	cat("END;")
	
sink() #Stop writing
