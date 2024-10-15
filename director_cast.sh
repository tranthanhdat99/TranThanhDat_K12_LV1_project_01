#!/bin/bash
# Column to group by
group_column=9 #director
group_column_2=7 #cast

# Protect commas within quotes
csvquote tmdb-movies.csv > temp_quoted.csv

{
	echo "Director name,Number of movies" > dir_cast.csv 

	# Process and count occurrences of each value for directors
	awk -F',' -v OFS=',' -v group_column="$group_column" 'NR > 1 {
		split($group_column, values, "|");
		for (i in values) 
		{count[values[i]]++;}
	} END {
		for (value in count) 
		{print value, count[value];}
		
	}' temp_quoted.csv | sort -t',' -k2,2nr | head -n 1 >> dir_cast.csv


	echo "Actor name,Number of movies" >> dir_cast.csv 

	# Process and count occurrences of each value for actors
	awk -F',' -v OFS=',' -v group_column="$group_column_2" 'NR > 1 {
		split($group_column, values, "|");
		for (i in values) 
		{count[values[i]]++;}
	} END {
		for (value in count) 
		{print value, count[value];}
		
	}' temp_quoted.csv | sort -t',' -k2,2nr | head -n 1 >> dir_cast.csv

	cat dir_cast.csv
}

# Clean up temporary files
rm temp_quoted.csv dir_cast.csv 
