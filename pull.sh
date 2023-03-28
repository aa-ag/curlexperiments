#!/bin/bash
YEAR=2011
while [ $YEAR -le 2021 ]
do
    curl --request GET \
	--url 'https://mlb-data.p.rapidapi.com/json/named.team_all_season.bam?season='\'$YEAR\''&all_star_sw='\''N'\''&sort_order=name_asc' \
	--header 'X-RapidAPI-Host: mlb-data.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: '$KEY > 'files/jsons/result'$YEAR'.json'
    ((YEAR++))
done
echo "Done pulling."