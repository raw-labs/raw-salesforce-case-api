-- @param case_id the ID of the case to update
-- @type case_id varchar

-- @param subject the new subject of the case
-- @type subject varchar
-- @default subject null

-- @param description the new description of the case
-- @type description varchar
-- @default description null

-- @param status the new status of the case. Permissible values: 'New', 'Working', 'Escalated', 'Closed'
-- @type status varchar
-- @default status null

-- @param priority the new priority of the case. Permissible values: 'High', 'Medium', 'Low'
-- @type priority varchar
-- @default priority null

-- @param origin the new origin of the case. Permissible values: 'Phone', 'Email', 'Web'
-- @type origin varchar
-- @default origin null

-- @param owner_id the new owner ID of the case
-- @type owner_id varchar
-- @default owner_id null

-- @param type the new type of the case. Permissible values: 'Question', 'Problem', 'Feature Request'
-- @type type varchar
-- @default type null

-- @param reason the new reason for the case. Permissible values: 'Installation', 'User Education', 'Performance', 'Breakdown', 'Hardware Failure', 'Other'
-- @type reason varchar
-- @default reason null

-- @param is_closed whether the case is closed. Permissible values: true, false
-- @type is_closed boolean
-- @default is_closed null

-- @param is_escalated whether the case is escalated. Permissible values: true, false
-- @type is_escalated boolean
-- @default is_escalated null

-- @return the updated case information

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
updated_case AS (
    UPDATE
        salesforce.salesforce_case
    SET
        subject = COALESCE(:subject, subject),
        description = COALESCE(:description, description),
        status = COALESCE(
            CASE
                WHEN :status IS NULL THEN status
                WHEN :status IN (SELECT status FROM valid_status) THEN :status
                ELSE NULL
            END,
            status
        ),
        priority = COALESCE(
            CASE
                WHEN :priority IS NULL THEN priority
                WHEN :priority IN (SELECT priority FROM valid_priority) THEN :priority
                ELSE NULL
            END,
            priority
        ),
        origin = COALESCE(
            CASE
                WHEN :origin IS NULL THEN origin
                WHEN :origin IN (SELECT origin FROM valid_origin) THEN :origin
                ELSE NULL
            END,
            origin
        ),
        type = COALESCE(
            CASE
                WHEN :type IS NULL THEN type
                WHEN :type IN (SELECT type FROM valid_type) THEN :type
                ELSE NULL
            END,
            type
        ),
        reason = COALESCE(
            CASE
                WHEN :reason IS NULL THEN reason
                WHEN :reason IN (SELECT reason FROM valid_reason) THEN :reason
                ELSE NULL
            END,
            reason
        ),
        is_closed = COALESCE(:is_closed, is_closed),
        is_escalated = COALESCE(:is_escalated, is_escalated),
        owner_id = COALESCE(:owner_id, owner_id)
    WHERE
        id = :case_id
        AND (
            (:status IS NULL OR :status IN (SELECT status FROM valid_status))
            AND (:priority IS NULL OR :priority IN (SELECT priority FROM valid_priority))
            AND (:origin IS NULL OR :origin IN (SELECT origin FROM valid_origin))
            AND (:type IS NULL OR :type IN (SELECT type FROM valid_type))
            AND (:reason IS NULL OR :reason IN (SELECT reason FROM valid_reason))
        )
    RETURNING *
)
SELECT
    id,
    case_number,
    subject,
    description,
    status,
    priority,
    origin,
    type,
    reason,
    is_closed,
    is_escalated,
    owner_id,
    last_modified_date
FROM
    updated_case;
