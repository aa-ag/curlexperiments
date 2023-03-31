#!/bin/bash
source ../.env

mkdir ../files/jsons
mkdir ../files/csvs

createdb "raw_db"
psql -d "raw_db" -c "CREATE TABLE IF NOT EXISTS t_raw(
    url TEXT,
    source_id BIGINT UNIQUE,
    external_id TEXT,
    via TEXT,
    created_at TEXT,
    updated_at TEXT,
    type VARCHAR(20),
    subject TEXT,
    raw_subject TEXT,
    description TEXT,
    priority VARCHAR(20),
    status VARCHAR(20),
    recipient BIGINT,
    requester_id BIGINT,
    submitter_id BIGINT,
    assignee_id BIGINT,
    organization_id BIGINT,
    group_id BIGINT,
    collaborator_ids TEXT,
    follower_ids TEXT,
    email_cc_ids TEXT,
    forum_topic_id BOOLEAN,
    problem_id BIGINT,
    has_incidents BOOLEAN,
    is_public BOOLEAN,
    due_at TEXT,
    tags TEXT,
    custom_fields TEXT,
    satisfaction_rating TEXT,
    sharing_agreement_ids TEXT,
    custom_status_id BIGINT,
    fields TEXT,
    followup_ids TEXT,
    ticket_form_id BIGINT,
    brand_id BIGINT,
    allow_channelback BOOLEAN,
    allow_attachments BOOLEAN,
    from_messaging_channel BOOLEAN,
    generated_timestamp BIGINT
)"

PAGENUMBER=1
EPOCH=0
URL="https://$DOMAIN.$ENDPOINT&start_time=$EPOCH"

while [ $PAGENUMBER -le 10 ]
do
    curl "$URL" \
    -v -u "$EMAIL/token:$TOKEN" > "../files/jsons/page$PAGENUMBER.json"
    jq -r '["url","id","external_id","via","created_at","updated_at","type","subject","raw_subject","description","priority","status","recipient","requester_id","submitter_id","assignee_id","organization_id","group_id","collaborator_ids","follower_ids","email_cc_ids","forum_topic_id","problem_id","has_incidents","is_public","due_at","tags","custom_fields","satisfaction_rating","sharing_agreement_ids","custom_status_id","fields","followup_ids","ticket_form_id","brand_id","allow_channelback","allow_attachments","from_messaging_channel","generated_timestamp"], ( .tickets[] | [.url,.id,.external_id,(.via|tostring),.created_at,.updated_at,.type,.subject,.raw_subject,.description,.priority,.status,.recipient,.requester_id,.submitter_id,.assignee_id,.organization_id,.group_id,(.collaborator_ids|tostring),(.follower_ids|tostring),(.email_cc_ids|tostring),.forum_topic_id,.problem_id,.has_incidents,.is_public,.due_atl,(.tags|tostring),(.custom_fields|tostring),(.satisfaction_rating|tostring),(.sharing_agreement_ids|tostring),.custom_status_id,(.fields|tostring),(.followup_ids|tostring),.ticket_form_id,.brand_id,.allow_channelback,.allow_attachments,.from_messaging_channel,.generated_timestamp] ) | @csv' ../files/jsons/page$PAGENUMBER.json > ../files/csvs/page$PAGENUMBER.csv
    psql -d "raw_db" -c "\COPY t_raw FROM '../files/csvs/page$PAGENUMBER.csv' DELIMITER ',' CSV HEADER;"
    # aws s3 cp ... ...
    AFTER_URL=$(jq -r '.after_url' "../files/jsons/page$PAGENUMBER.json")
    URL=$AFTER_URL
    ((PAGENUMBER++))
done

rm -r ../files/csvs
rm -r ../files/jsons

echo "Done."