#!/bin/bash

# Protect commas within quotes
csvquote tmdb-movies.csv > temp_quoted.csv

# Create a sorted CSV file with reformatted dates
{
	# Print the header row
	head -n 1 temp_quoted.csv > release_date_sorted.csv

	# Reformat dates and sort by release date
	tail -n +2 temp_quoted.csv | \
	awk 'BEGIN {FS=OFS=","} {
		split($16, a, "/");
		if (a[3] < 50) a[3] += 2000; else a[3] += 1900;
		a[1] = sprintf("%02d", a[1]);
		a[2] = sprintf("%02d", a[2]);
		$16 = a[3] "/" a[1] "/" a[2];
		print $0
	}' | sort -t',' -rk16 | csvquote -u >> release_date_sorted.csv
}

# Clean up temporary files
rm temp_quoted.csv

