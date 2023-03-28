#!/bin/bash
createdb "testdb"
psql -d "testdb" -c "CREATE TABLE IF NOT EXISTS testtable(
    venue_short TEXT,sport_id TEXT,league_abbrev TEXT,team_id TEXT,spring_league_id TEXT,active_sw TEXT,division TEXT,mlb_org_brief TEXT,season TEXT,first_year_of_play TEXT,state TEXT,name_short TEXT,bis_team_code TEXT,venue_id TEXT,name_display_short TEXT,name_display_long TEXT,name_display_brief TEXT,sport_code_name TEXT,spring_league TEXT,league TEXT,division_id TEXT,sport_code TEXT,time_zone_num TEXT,mlb_org TEXT,name_display_full TEXT,all_star_sw TEXT,division_abbrev TEXT,name TEXT,home_opener TEXT,phone_number TEXT,address_zip TEXT,time_zone_text TEXT,venue_name TEXT,division_full TEXT,franchise_code TEXT,city TEXT,time_zone_alt TEXT,address_state TEXT,name_abbrev TEXT,store_url TEXT,file_code TEXT,address_line3 TEXT,address_line2 TEXT,address_province TEXT,mlb_org_id TEXT,address_line1 TEXT,spring_league_full TEXT,spring_league_abbrev TEXT,last_year_of_play TEXT,address TEXT,league_full TEXT,address_country TEXT,base_url TEXT,time_zone TEXT,address_city TEXT,team_code TEXT,mlb_org_abbrev TEXT,address_intl TEXT,time_zone_generic TEXT,website_url TEXT,sport_code_display TEXT,home_opener_time TEXT,mlb_org_short TEXT,league_id TEXT
)"
YEAR=2011
while [ $YEAR -le 2021 ]
do
    psql -d "testdb" -c "\COPY testtable FROM 'files/csvs/result$YEAR.csv' DELIMITER ',' CSV HEADER;"
    ((YEAR++))
done
echo "Done pouring into the db."