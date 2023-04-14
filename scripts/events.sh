#!/bin/bash
source ../.env

PAGENUMBER=1
EPOCH=0
END_OF_STREAM=false
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

while [ $END_OF_STREAM != true ]
do
    curl "$URL" -v -u "$EMAIL/token:$TOKEN" > '../temp/events1.json'
    END_OF_STREAM=true
done

echo "Done."