#!/bin/bash

# Convert line endings and protect commas within quotes
tr -d '\r' < tmdb-movies.csv > temp_unix.csv
csvquote temp_unix.csv > temp_quoted.csv

{
	# Print the header row
	header=$(head -n 1 temp_quoted.csv)
	echo "$header,Profit" > sorted.csv

	# Count the number of columns
	num_columns=$(awk -F',' 'NR==1 {print NF}' temp_quoted.csv)

	# Calculate profit and sort by it
	awk -F',' -v OFS=',' -v num_columns="$num_columns" 'NR > 1 {
		profit = $5 - $4;
		$(num_columns + 1) = profit;
		print $0
	}' temp_quoted.csv | sort -t',' -k$(($num_columns + 1))nr | csvquote -u  >> sorted.csv

    # Display the top 10 highest profit movies
    head -n 11 sorted.csv
}

# Clean up temporary files
rm temp_quoted.csv temp_unix.csv  sorted.csv
