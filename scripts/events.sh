#!/bin/bash
source ../.env

PAGENUMBER=1
EPOCH=0
END_OF_STREAM=false
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

while [ $END_OF_STREAM != true ]
do
    RESPONSE=$(curl "$URL" -v -u "$EMAIL/token:$TOKEN")
    jq -r '["id","via","via_reference_id","type","author_id","body","html_body","plain_body","public","attachments","audit_id","created_at","event_type"], ( .ticket_events[] | [.id,(.via|to_string),.via_reference_id,.type,.author_id,.body,.html_body,.plain_body,.public,.attachments,.audit_id,.created_at,.event_type] ) | @csv' <<<"$RESPONSE" > ../temp/csvs/page$PAGENUMBER.csv
    IS_END_OF_STREAM=true
    ((PAGENUMBER++))
done

echo "Done."