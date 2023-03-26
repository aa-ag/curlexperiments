#!/bin/bash
source .env
YEAR=2017
while [ $YEAR -le 2019 ]
do
curl --request GET \
	--url 'https://mlb-data.p.rapidapi.com/json/named.team_all_season.bam?season='\'$YEAR\''&all_star_sw='\''N'\''&sort_order=name_asc' \
	--header 'X-RapidAPI-Host: mlb-data.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: '$KEY > 'result'$YEAR'.json'
    ((YEAR++))
done
echo "Done."