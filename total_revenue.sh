#!/bin/bash

# Protect commas within quotes
csvquote tmdb-movies.csv > temp_quoted.csv

# Calculate total revenue
{
	total_rev=$(awk -F',' 'NR>1 {sum += $5} END {print sum}' temp_quoted.csv)
	printf "Total revenue: %.0f\n" "$total_rev"
}

# Clean up temporary files
rm temp_quoted.csv
