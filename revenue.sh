#!/bin/bash

# Protect commas within quotes
csvquote tmdb-movies.csv > temp_quoted.csv

{
	# Print the header row
	head -n 1 temp_quoted.csv

	# Sort by the 5th column (revenue)
	awk -F',' 'NR>1' temp_quoted.csv | sort -t',' -k5,5nr > sorted.csv

	# Print the highest and lowest revenue movies
	head -n 1 sorted.csv | csvquote -u
	tail -n 1 sorted.csv | csvquote -u

}

# Clean up temporary files
rm temp_quoted.csv sorted.csv
