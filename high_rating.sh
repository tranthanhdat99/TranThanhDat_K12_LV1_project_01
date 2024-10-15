#!/bin/bash

# Protect commas within quotes
csvquote tmdb-movies.csv > temp_quoted.csv

# Create a CSV file with high rating movies
{
	# Print the header row
	head -n 1 temp_quoted.csv > high_rating_movies.csv

	# Filter movies with ratings > 7.5
	tail -n +2 temp_quoted.csv | \
	awk 'BEGIN {FS=OFS=","} {
		if ($18 > 7.5) print $0
	}' | csvquote -u >> high_rating_movies.csv
}

# Clean up temporary files
rm temp_quoted.csv
