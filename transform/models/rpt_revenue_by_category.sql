-- rpt_revenue_by_category.sql
-- ============================================================
-- REPORT MODEL: Revenue by Category
-- Aggregates fact_sales for a business summary.
-- ============================================================

SELECT
    category,
    COUNT(*)                AS order_count,
    SUM(total_revenue)      AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM {{ ref('fact_sales') }}
GROUP BY category
ORDER BY total_revenue DESC
