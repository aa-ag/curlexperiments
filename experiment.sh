#!/bin/bash
source .env
curl --request GET \
	--url 'https://mlb-data.p.rapidapi.com/json/named.team_all_season.bam?season='\''2017'\''&all_star_sw='\''N'\''&sort_order=name_asc' \
	--header 'X-RapidAPI-Host: mlb-data.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: '$KEY > result.json