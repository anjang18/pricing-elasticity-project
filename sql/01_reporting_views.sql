-- Reporting views over the cleaned, positive-sales `sales` table.
-- Expected product dimension grain: one row per UPC. Notebook 04 checks this.
CREATE OR REPLACE VIEW dim_product AS
SELECT DISTINCT
    upc,
    product,
    size,
    product || ' | ' || size || ' | ' || upc AS product_label
FROM sales;

-- Aggregate across stores while retaining the recorded-promotion split.
-- Summed units and revenue must reconcile to sales; source_observations counts
-- input records, not unique stores. Average selling price is revenue / units.
CREATE OR REPLACE VIEW weekly_sales AS
SELECT
    upc,
    week,
    promo_recorded,
    SUM(units) AS units,
    SUM(revenue) AS revenue,
    COUNT(*) AS source_observations
FROM sales
GROUP BY upc, week, promo_recorded;
