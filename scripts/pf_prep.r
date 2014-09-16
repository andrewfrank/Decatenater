setwd("scripts")

file.location.pl <- paste0(
	"\'",
	file.location,
	"\'"
)

system(
	paste0(
		"perl write_pf_shell.pl ",
		file.location.pl
	)
)