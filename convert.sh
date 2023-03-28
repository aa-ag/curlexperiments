#!/bin/bash
YEAR=2011
while [ $YEAR -le 2021 ]
do
    jq -r '["venue_short", "sport_id", "league_abbrev", "team_id", "spring_league_id", "active_sw", "division", "mlb_org_brief", "season", "first_year_of_play", "state", "name_short", "bis_team_code", "venue_id", "name_display_short", "name_display_long", "name_display_brief", "sport_code_name", "spring_league", "league", "division_id", "sport_code", "time_zone_num", "mlb_org", "name_display_full", "all_star_sw", "division_abbrev", "name", "home_opener", "phone_number", "address_zip", "time_zone_text", "venue_name", "division_full", "franchise_code", "city", "time_zone_alt", "address_state", "name_abbrev", "store_url", "file_code", "address_line3", "address_line2", "address_province", "mlb_org_id", "address_line1", "spring_league_full", "spring_league_abbrev", "last_year_of_play", "address", "league_full", "address_country", "base_url", "time_zone", "address_city", "team_code", "mlb_org_abbrev", "address_intl", "time_zone_generic", "website_url", "sport_code_display", "home_opener_time", "mlb_org_short", "league_id"], ( .team_all_season.queryResults.row[] | [.venue_short, .sport_id, .league_abbrev, .team_id, .spring_league_id, .active_sw, .division, .mlb_org_brief, .season, .first_year_of_play, .state, .name_short, .bis_team_code, .venue_id, .name_display_short, .name_display_long, .name_display_brief, .sport_code_name, .spring_league, .league, .division_id, .sport_code, .time_zone_num, .mlb_org, .name_display_full, .all_star_sw, .division_abbrev, .name, .home_opener, .phone_number, .address_zip, .time_zone_text, .venue_name, .division_full, .franchise_code, .city, .time_zone_alt, .address_state, .name_abbrev, .store_url, .file_code, .address_line3, .address_line2, .address_province, .mlb_org_id, .address_line1, .spring_league_full, .spring_league_abbrev, .last_year_of_play, .address, .league_full, .address_country, .base_url, .time_zone, .address_city, .team_code, .mlb_org_abbrev, .address_intl, .time_zone_generic, .website_url, .sport_code_display, .home_opener_time, .mlb_org_short, .league_id]) | @csv' "files/jsons/result$YEAR.json" > "files/csvs/result$YEAR.csv"
    ((YEAR++))
done
echo "Done converting."