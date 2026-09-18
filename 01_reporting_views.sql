
CREATE OR REPLACE VIEW dim_product AS
SELECT DISTINCT
    upc,
    product,
    size,
    product || ' | ' || size || ' | ' || upc AS product_label
FROM sales;

CREATE OR REPLACE VIEW weekly_sales AS
SELECT
    upc,
    week,
    promo_recorded,
    SUM(units) AS units,
    SUM(revenue) AS revenue,
    COUNT(*) AS source_observations
FROM sales
GROUP BY
    upc,
    week,
    promo_recorded;
