#!/bin/bash
source ../.env

mkdir ../files/jsons
mkdir ../files/jsons/tickets

PAGE=1
EPOCH=0
URL="https://$DOMAIN.zendesk.com/api/v2/incremental/tickets/cursor.json?&start_time=$EPOCH"

while [ $PAGE -le 10 ]
do
    curl "$URL" \
    -v -u "$EMAIL/token:$TOKEN" > "../files/jsons/tickets/page$PAGE.json"
    AFTER_URL=$(jq -r '.after_url' "../files/jsons/tickets/page$PAGE.json")
    URL=$AFTER_URL
	((PAGE++))
done

echo "Done."