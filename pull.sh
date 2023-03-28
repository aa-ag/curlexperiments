#!/bin/bash
# 1. Create database
createdb "testdb"

# 2. Create table
psql -d "testdb" -c "CREATE TABLE IF NOT EXISTS testtable(
    venue_short TEXT,sport_id TEXT,league_abbrev TEXT,team_id TEXT,spring_league_id TEXT,active_sw TEXT,division TEXT,mlb_org_brief TEXT,season TEXT,first_year_of_play TEXT,state TEXT,name_short TEXT,bis_team_code TEXT,venue_id TEXT,name_display_short TEXT,name_display_long TEXT,name_display_brief TEXT,sport_code_name TEXT,spring_league TEXT,league TEXT,division_id TEXT,sport_code TEXT,time_zone_num TEXT,mlb_org TEXT,name_display_full TEXT,all_star_sw TEXT,division_abbrev TEXT,name TEXT,home_opener TEXT,phone_number TEXT,address_zip TEXT,time_zone_text TEXT,venue_name TEXT,division_full TEXT,franchise_code TEXT,city TEXT,time_zone_alt TEXT,address_state TEXT,name_abbrev TEXT,store_url TEXT,file_code TEXT,address_line3 TEXT,address_line2 TEXT,address_province TEXT,mlb_org_id TEXT,address_line1 TEXT,spring_league_full TEXT,spring_league_abbrev TEXT,last_year_of_play TEXT,address TEXT,league_full TEXT,address_country TEXT,base_url TEXT,time_zone TEXT,address_city TEXT,team_code TEXT,mlb_org_abbrev TEXT,address_intl TEXT,time_zone_generic TEXT,website_url TEXT,sport_code_display TEXT,home_opener_time TEXT,mlb_org_short TEXT,league_id TEXT
)"

# 3. Pull records from API
YEAR=2011
while [ $YEAR -le 2012 ]
do
	# 3.1. GET teams by year
    curl --request GET \
	--url 'https://mlb-data.p.rapidapi.com/json/named.team_all_season.bam?season='\'$YEAR\''&all_star_sw='\''N'\''&sort_order=name_asc' \
	--header 'X-RapidAPI-Host: mlb-data.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: '$KEY > 'files/jsons/result'$YEAR'.json'
	# 3.2. Format .json response to CSV
	jq -r '["venue_short", "sport_id", "league_abbrev", "team_id", "spring_league_id", "active_sw", "division", "mlb_org_brief", "season", "first_year_of_play", "state", "name_short", "bis_team_code", "venue_id", "name_display_short", "name_display_long", "name_display_brief", "sport_code_name", "spring_league", "league", "division_id", "sport_code", "time_zone_num", "mlb_org", "name_display_full", "all_star_sw", "division_abbrev", "name", "home_opener", "phone_number", "address_zip", "time_zone_text", "venue_name", "division_full", "franchise_code", "city", "time_zone_alt", "address_state", "name_abbrev", "store_url", "file_code", "address_line3", "address_line2", "address_province", "mlb_org_id", "address_line1", "spring_league_full", "spring_league_abbrev", "last_year_of_play", "address", "league_full", "address_country", "base_url", "time_zone", "address_city", "team_code", "mlb_org_abbrev", "address_intl", "time_zone_generic", "website_url", "sport_code_display", "home_opener_time", "mlb_org_short", "league_id"], ( .team_all_season.queryResults.row[] | [.venue_short, .sport_id, .league_abbrev, .team_id, .spring_league_id, .active_sw, .division, .mlb_org_brief, .season, .first_year_of_play, .state, .name_short, .bis_team_code, .venue_id, .name_display_short, .name_display_long, .name_display_brief, .sport_code_name, .spring_league, .league, .division_id, .sport_code, .time_zone_num, .mlb_org, .name_display_full, .all_star_sw, .division_abbrev, .name, .home_opener, .phone_number, .address_zip, .time_zone_text, .venue_name, .division_full, .franchise_code, .city, .time_zone_alt, .address_state, .name_abbrev, .store_url, .file_code, .address_line3, .address_line2, .address_province, .mlb_org_id, .address_line1, .spring_league_full, .spring_league_abbrev, .last_year_of_play, .address, .league_full, .address_country, .base_url, .time_zone, .address_city, .team_code, .mlb_org_abbrev, .address_intl, .time_zone_generic, .website_url, .sport_code_display, .home_opener_time, .mlb_org_short, .league_id]) | @csv' "files/jsons/result$YEAR.json" > "files/csvs/result$YEAR.csv"
	# 3.3. Copy CSV to Postgres DB
	psql -d "testdb" -c "\COPY testtable FROM 'files/csvs/result$YEAR.csv' DELIMITER ',' CSV HEADER;"
    ((YEAR++))
done
# 4. Let the user know this is done running
echo "Done."