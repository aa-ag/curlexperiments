#!/bin/bash
source ../.env

EPOCH=0
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"
curl "$URL" -v -u "$EMAIL/token:$TOKEN" > 'events1.json'