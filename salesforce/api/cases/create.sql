-- @param subject the subject of the case
-- @type subject varchar

-- @param description the detailed description of the case
-- @type description varchar
-- @default description null

-- @param status the status of the case. Permissible values: 'New', 'Working', 'Escalated', 'Closed'
-- @type status varchar
-- @default status 'New'

-- @param priority the priority of the case. Permissible values: 'High', 'Medium', 'Low'
-- @type priority varchar
-- @default priority 'Medium'

-- @param origin the origin of the case. Permissible values: 'Phone', 'Email', 'Web'
-- @type origin varchar
-- @default origin 'Web'

-- @param owner_id the owner ID of the case
-- @type owner_id varchar
-- @default owner_id null

-- @param type the type of the case. Permissible values: 'Question', 'Problem', 'Feature Request'
-- @type type varchar
-- @default type null

-- @param reason the reason for the case. Permissible values: 'Installation', 'User Education', 'Performance', 'Breakdown', 'Hardware Failure', 'Other'
-- @type reason varchar
-- @default reason null

-- @param is_closed whether the case is closed. Permissible values: true, false
-- @type is_closed boolean
-- @default is_closed false

-- @param is_escalated whether the case is escalated. Permissible values: true, false
-- @type is_escalated boolean
-- @default is_escalated false

-- @param contact_id the ID of the related contact
-- @type contact_id varchar
-- @default contact_id null

-- @param account_id the ID of the related account
-- @type account_id varchar
-- @default account_id null

-- @return the newly created case information

WITH valid_status AS (
    SELECT unnest(ARRAY['New', 'Working', 'Escalated', 'Closed']) AS status
),
valid_priority AS (
    SELECT unnest(ARRAY['High', 'Medium', 'Low']) AS priority
),
valid_origin AS (
    SELECT unnest(ARRAY['Phone', 'Email', 'Web']) AS origin
),
valid_type AS (
    SELECT unnest(ARRAY['Question', 'Problem', 'Feature Request']) AS type
),
valid_reason AS (
    SELECT unnest(ARRAY['Installation', 'User Education', 'Performance', 'Breakdown', 'Hardware Failure', 'Other']) AS reason
),
validated_params AS (
    SELECT
        :subject AS subject,
        :description AS description,
        CASE
            WHEN :status IS NULL THEN 'New'
            WHEN :status IN (SELECT status FROM valid_status) THEN :status
            ELSE NULL
        END AS status,
        CASE
            WHEN :priority IS NULL THEN 'Medium'
            WHEN :priority IN (SELECT priority FROM valid_priority) THEN :priority
            ELSE NULL
        END AS priority,
        CASE
            WHEN :origin IS NULL THEN 'Web'
            WHEN :origin IN (SELECT origin FROM valid_origin) THEN :origin
            ELSE NULL
        END AS origin,
        :owner_id AS owner_id,
        CASE
            WHEN :type IS NULL THEN NULL
            WHEN :type IN (SELECT type FROM valid_type) THEN :type
            ELSE NULL
        END AS type,
        CASE
            WHEN :reason IS NULL THEN NULL
            WHEN :reason IN (SELECT reason FROM valid_reason) THEN :reason
            ELSE NULL
        END AS reason,
        COALESCE(:is_closed, false) AS is_closed,
        COALESCE(:is_escalated, false) AS is_escalated,
        :contact_id AS contact_id,
        :account_id AS account_id
)
INSERT INTO
    salesforce.salesforce_case (
        subject,
        description,
        status,
        priority,
        origin,
        owner_id,
        type,
        reason,
        is_closed,
        is_escalated,
        contact_id,
        account_id
    )
SELECT
    subject,
    description,
    status,
    priority,
    origin,
    owner_id,
    type,
    reason,
    is_closed,
    is_escalated,
    contact_id,
    account_id
FROM
    validated_params
WHERE
    subject IS NOT NULL
    AND status IS NOT NULL
    AND priority IS NOT NULL
    AND origin IS NOT NULL
RETURNING
    id,
    case_number,
    subject,
    description,
    status,
    priority,
    origin,
    owner_id,
    type,
    reason,
    is_closed,
    is_escalated,
    contact_id,
    account_id,
    created_date;
