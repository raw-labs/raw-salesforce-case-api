-- @param case_id the ID of the case to delete
-- @type case_id varchar

-- @return confirmation of deletion with case ID and details

WITH deleted_case AS (
    DELETE FROM
        salesforce.salesforce_case
    WHERE
        id = :case_id
    RETURNING
        id,
        case_number,
        subject,
        status,
        priority,
        origin,
        owner_id,
        created_date,
        last_modified_date
)
SELECT
    id,
    case_number,
    subject,
    status,
    priority,
    origin,
    owner_id,
    created_date,
    last_modified_date
FROM
    deleted_case;
