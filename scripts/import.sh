#!/bin/bash
source ../.env

mkdir ../files/jsons
mkdir ../files/csvs

PAGENUMBER=1
EPOCH=0
END_OF_STREAM=false
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

while [ $END_OF_STREAM != true ]
do
    curl "$URL" -v -u "$EMAIL/token:$TOKEN" > "../files/jsons/page$PAGENUMBER.json"
    jq -r '["url","id","external_id","via","created_at","updated_at","type","subject","raw_subject","description","priority","status","recipient","requester_id","submitter_id","assignee_id","organization_id","group_id","collaborator_ids","follower_ids","email_cc_ids","forum_topic_id","problem_id","has_incidents","is_public","due_at","tags","custom_fields","satisfaction_rating","sharing_agreement_ids","custom_status_id","fields","followup_ids","ticket_form_id","brand_id","allow_channelback","allow_attachments","from_messaging_channel","generated_timestamp"], ( .tickets[] | [.url,.id,.external_id,(.via|tostring),.created_at,.updated_at,.type,.subject,.raw_subject,.description,.priority,.status,.recipient,.requester_id,.submitter_id,.assignee_id,.organization_id,.group_id,(.collaborator_ids|tostring),(.follower_ids|tostring),(.email_cc_ids|tostring),.forum_topic_id,.problem_id,.has_incidents,.is_public,.due_atl,(.tags|tostring),(.custom_fields|tostring),(.satisfaction_rating|tostring),(.sharing_agreement_ids|tostring),.custom_status_id,(.fields|tostring),(.followup_ids|tostring),.ticket_form_id,.brand_id,.allow_channelback,.allow_attachments,.from_messaging_channel,.generated_timestamp] ) | @csv' ../files/jsons/page$PAGENUMBER.json > ../files/csvs/page$PAGENUMBER.csv
    psql -d "raw_db" -c "\COPY t_raw FROM '../files/csvs/page$PAGENUMBER.csv' DELIMITER ',' CSV HEADER;"
    AFTER_URL=$(jq -r '.after_url' "../files/jsons/page$PAGENUMBER.json")
    URL=$AFTER_URL
    IS_END_OF_STREAM=$(jq -r '.end_of_stream' "../files/jsons/page$PAGENUMBER.json")
    END_OF_STREAM=$IS_END_OF_STREAM
    ((PAGENUMBER++))
done

# aws s3 cp ... ... -r
rm -r ../files/csvs
rm -r ../files/jsons

echo "Done."