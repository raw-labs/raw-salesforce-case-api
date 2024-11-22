-- @param case_id the ID of the case
-- @type case_id varchar
-- @default case_id null

-- @param case_number the case number
-- @type case_number varchar
-- @default case_number null

-- @param contact_id the ID of the related contact
-- @type contact_id varchar
-- @default contact_id null

-- @param account_id the ID of the related account
-- @type account_id varchar
-- @default account_id null

-- @param asset_id the ID of the related asset
-- @type asset_id varchar
-- @default asset_id null

-- @param type the type of the case
-- @type type varchar
-- @default type null

-- @param status the status of the case
-- @type status varchar
-- @default status null

-- @param reason the reason for the case
-- @type reason varchar
-- @default reason null

-- @param origin the origin of the case
-- @type origin varchar
-- @default origin null

-- @param subject filter cases by subject (supports substring match)
-- @type subject varchar
-- @default subject null

-- @param priority the priority of the case
-- @type priority varchar
-- @default priority null

-- @param is_closed whether the case is closed
-- @type is_closed boolean
-- @default is_closed null

-- @param closed_date_start filter cases closed on or after this date (YYYY-MM-DD)
-- @type closed_date_start date
-- @default closed_date_start null

-- @param closed_date_end filter cases closed on or before this date (YYYY-MM-DD)
-- @type closed_date_end date
-- @default closed_date_end null

-- @param is_escalated whether the case is escalated
-- @type is_escalated boolean
-- @default is_escalated null

-- @param owner_id the ID of the owner of the case
-- @type owner_id varchar
-- @default owner_id null

-- @param created_by_id the ID of the user who created the case
-- @type created_by_id varchar
-- @default created_by_id null

-- @param created_date_start filter cases created on or after this date (YYYY-MM-DD)
-- @type created_date_start date
-- @default created_date_start null

-- @param created_date_end filter cases created on or before this date (YYYY-MM-DD)
-- @type created_date_end date
-- @default created_date_end null

-- @param last_modified_by_id the ID of the user who last modified the case
-- @type last_modified_by_id varchar
-- @default last_modified_by_id null

-- @param last_modified_date_start filter cases last modified on or after this date (YYYY-MM-DD)
-- @type last_modified_date_start date
-- @default last_modified_date_start null

-- @param last_modified_date_end filter cases last modified on or before this date (YYYY-MM-DD)
-- @type last_modified_date_end date
-- @default last_modified_date_end null

-- @param contact_phone the contact's phone number (supports substring match)
-- @type contact_phone varchar
-- @default contact_phone null

-- @param contact_email the contact's email address (supports substring match)
-- @type contact_email varchar
-- @default contact_email null

-- @param is_deleted whether the case is deleted
-- @type is_deleted boolean
-- @default is_deleted null

-- @param description filter cases by description (supports substring match)
-- @type description varchar
-- @default description null

-- @param comments filter cases by comments (supports substring match)
-- @type comments varchar
-- @default comments null

-- @param currency_iso_code the currency ISO code
-- @type currency_iso_code varchar
-- @default currency_iso_code null

-- @param page the current page number to retrieve
-- @type page integer
-- @default page 1

-- @param page_size the number of records per page
-- @type page_size integer
-- @default page_size 50

-- @return cases matching the specified filters

SELECT
    c.id,
    c.case_number,
    c.contact_id,
    c.account_id,
    c.asset_id,
    c.type,
    c.status,
    c.reason,
    c.origin,
    c.subject,
    c.priority,
    c.description,
    c.is_closed,
    c.closed_date,
    c.is_escalated,
    c.owner_id,
    c.created_date,
    c.created_by_id,
    c.last_modified_date,
    c.last_modified_by_id,
    c.contact_phone,
    c.contact_mobile,
    c.contact_email,
    c.contact_fax,
    c.currency_iso_code,
    c.is_deleted
FROM
    salesforce.salesforce_case c
WHERE
    (:case_id IS NULL OR c.id = :case_id)
    AND (:case_number IS NULL OR c.case_number = :case_number)
    AND (:contact_id IS NULL OR c.contact_id = :contact_id)
    AND (:account_id IS NULL OR c.account_id = :account_id)
    AND (:asset_id IS NULL OR c.asset_id = :asset_id)
    AND (:type IS NULL OR c.type = :type)
    AND (:status IS NULL OR c.status = :status)
    AND (:reason IS NULL OR c.reason = :reason)
    AND (:origin IS NULL OR c.origin = :origin)
    AND (:subject IS NULL OR c.subject ILIKE CONCAT('%', :subject, '%'))
    AND (:priority IS NULL OR c.priority = :priority)
    AND (:is_closed IS NULL OR c.is_closed = :is_closed)
    AND (:is_escalated IS NULL OR c.is_escalated = :is_escalated)
    AND (:owner_id IS NULL OR c.owner_id = :owner_id)
    AND (:created_by_id IS NULL OR c.created_by_id = :created_by_id)
    AND (:last_modified_by_id IS NULL OR c.last_modified_by_id = :last_modified_by_id)
    AND (:contact_phone IS NULL OR c.contact_phone ILIKE CONCAT('%', :contact_phone, '%'))
    AND (:contact_email IS NULL OR c.contact_email ILIKE CONCAT('%', :contact_email, '%'))
    AND (:is_deleted IS NULL OR c.is_deleted = :is_deleted)
    AND (:description IS NULL OR c.description ILIKE CONCAT('%', :description, '%'))
    AND (:comments IS NULL OR c.comments ILIKE CONCAT('%', :comments, '%'))
    AND (:currency_iso_code IS NULL OR c.currency_iso_code = :currency_iso_code)
    AND (
        (:created_date_start IS NULL OR c.created_date >= :created_date_start::timestamp)
        AND (:created_date_end IS NULL OR c.created_date <= :created_date_end::timestamp)
    )
    AND (
        (:last_modified_date_start IS NULL OR c.last_modified_date >= :last_modified_date_start::timestamp)
        AND (:last_modified_date_end IS NULL OR c.last_modified_date <= :last_modified_date_end::timestamp)
    )
    AND (
        (:closed_date_start IS NULL OR c.closed_date >= :closed_date_start::timestamp)
        AND (:closed_date_end IS NULL OR c.closed_date <= :closed_date_end::timestamp)
    )
ORDER BY
    c.created_date DESC
LIMIT COALESCE(:page_size, 50) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 50);
