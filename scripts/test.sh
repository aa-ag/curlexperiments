#!/bin/bash
source ../.env
mkdir ../files/csvs
PAGE=1
createdb "raw_db"
psql -d "raw_db" -c "CREATE TABLE IF NOT EXISTS ticket_raw(
    url TEXT, source_id BIGINT UNIQUE, external_id TEXT, via TEXT
)"

jq -r '["url","id","external_id","via"], ( .tickets[] | [.url, .id, .external_id, (.via|tostring)] ) | @csv' ../files/jsons/page1.json > ../files/csvs/page1.csv

psql -d "raw_db" -c "\COPY ticket_raw FROM '../files/csvs/page$PAGE.csv' DELIMITER ',' CSV HEADER;"