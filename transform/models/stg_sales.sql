-- stg_sales.sql
-- ============================================================
-- STAGING MODEL
-- Reads from the raw tap_csv.raw_sales table and does light
-- cleaning only — no business logic yet.
-- This is the "clean copy" of the raw data.
-- ============================================================

WITH source AS (
    SELECT * FROM {{ source('tap_csv', 'raw_sales') }}
)

SELECT
    order_id::INTEGER                                           AS order_id,

    -- Fix name casing: "bob smith" → "Bob Smith"
    INITCAP(customer_name)                                      AS customer_name,

    -- Fill missing emails
    CASE
        WHEN email IS NULL OR TRIM(email) = ''
        THEN 'unknown@no-email.com'
        ELSE TRIM(email)
    END                                                         AS email,

    TRIM(product)                                               AS product,
    TRIM(category)                                              AS category,
    quantity::INTEGER                                           AS quantity,
    unit_price::NUMERIC(10,2)                                   AS unit_price,
    order_date::DATE                                            AS order_date,
    UPPER(TRIM(region))                                         AS region,
    LOWER(TRIM(status))                                         AS status

FROM source
