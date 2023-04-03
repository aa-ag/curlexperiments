#!/bin/bash
source ../.env

PAGENUMBER=1
EPOCH=0
END_OF_STREAM=false
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

RESPONSE=$(curl "$URL" -v -u "$EMAIL/token:$TOKEN")
jq -r '.tickets[]' <<<"$RESPONSE"