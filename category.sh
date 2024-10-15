#!/bin/bash
# Column to group by
group_column=14 #genre

# Protect commas within quotes
csvquote tmdb-movies.csv > temp_quoted.csv

{
	echo "Category,Number of movies" > category.csv 

	# Process and count occurrences of each value
	awk -F',' -v OFS=',' -v group_column="$group_column" 'NR > 1 {
	split($group_column, values, "|");
	for (i in values) 
		{count[values[i]]++;}
	} END {
	for (value in count) 
		{print value, count[value];}
	}' temp_quoted.csv | sort -t',' -k2,2nr >> category.csv

	cat category.csv
    
}

# Clean up temporary files
rm temp_quoted.csv category.csv 
