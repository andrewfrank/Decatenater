Decatenater v0.1

INTRODUCTION
------------

Multi-gene concatenated nucleotide data sets are common in modern phylogenetic analyses. Often users wish to perform analyses on the individual genes that make up the concatenated data set. 

Decatenater is a set of scripts in R that take a concatenated nucleotide data set in nexus format as input, and output nexus and phylip files for the individual genes, along with a nexus file containing a PAUP block that executes PAUP's basefreqs function per gene per codon position, and PartitionFinder configuration files for each gene.

Decatenater also allows the user to exclude multiple sets of taxa from the input concatenated nexus file. This produces a set of gene nexus and phylip files per set of excluded taxa, and modifies the PAUP basefreqs nexus file to perform additional basefreqs analyses with sets of excluded taxa removed, and produces PartitionFinder configuration files for each gene per set of excluded taxa.

REQUIREMENTS
------------

Decatenater requires the following R packages:
* ape (http://cran.r-project.org/web/packages/ape/)

INSTALLATION & CONFIGURATION
----------------------------

- Place the Decatenater folder in your desired location.
- Place your input concatenated nucleotide nexus file in the Decatenater folder.

- Open Decatenater.r in a text editor or in R.
- Edit the parameters in the section "INPUT NEXUS FILE PARAMETERS" to match the parameters of your input concatenated nucleotide nexus file.
- Save Decatenater.r.
- Run the Decatenater.r script.

- Decatenater produces four folders: "paup basefreqs files", "nexus files", "phy files", and "partitionfinder config files".
	- Additional folders for each taxon exclusion set are produced within "nexus files",
	"phy files" if taxon exclusion sets are entered.