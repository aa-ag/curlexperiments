#!/bin/bash
source ../.env

mkdir ../files/jsons
mkdir ../files/jsons/tickets

PAGE=1
EPOCH=0
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

while [ $PAGE -le 1 ]
do
    curl --silent "$URL" \
    -v -u "$EMAIL/token:$TOKEN" > "../files/jsons/tickets/page$PAGE.json"
    AFTER_URL=$(jq -r '.after_url' "../files/jsons/tickets/page$PAGE.json")
    URL=$AFTER_URL
	((PAGE++))
done

echo "Done."