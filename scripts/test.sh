#!/bin/bash
source ../.env

PAGENUMBER=1
EPOCH=0
END_OF_STREAM=false
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

RESPONSE=$(curl "$URL" -v -u "$EMAIL/token:$TOKEN")
AFTER_URL=$(jq -r '.after_url' <<<"$RESPONSE")
END_OF_STREAM=$(jq -r '.end_of_stream' <<<"$RESPONSE")
echo $AFTER_URL
echo $END_OF_STREAM