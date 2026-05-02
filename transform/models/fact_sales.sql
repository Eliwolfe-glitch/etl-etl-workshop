-- fact_sales.sql
-- ============================================================
-- FACT TABLE MODEL
-- Reads from stg_sales, applies business rules, and adds
-- derived columns. This is your analytics-ready table.
-- ============================================================

WITH staged AS (
    SELECT * FROM {{ ref('stg_sales') }}
)

SELECT
    order_id,
    customer_name,
    email,
    product,
    category,
    quantity,
    unit_price,

    -- Derived column: total revenue per order line
    ROUND(quantity * unit_price, 2)         AS total_revenue,

    order_date,

    -- Derived column: year-month for trend analysis
    TO_CHAR(order_date, 'YYYY-MM')          AS order_month,

    region,
    status

FROM staged

-- Business rule: exclude refunded orders from the fact table
WHERE status != 'refunded'
