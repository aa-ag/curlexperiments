dropdb "raw_db"
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