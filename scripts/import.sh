#!/bin/bash
source ../.env

PAGE=1
EPOCH=0
curl "https://$DOMAIN.zendesk.com/api/v2/incremental/tickets/cursor.json?per_page=10&start_time=$EPOCH" \
-v -u "$EMAIL/token:$TOKEN"