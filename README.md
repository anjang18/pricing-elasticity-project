# Cereal Pricing and Price Elasticity Analysis

This project examines how cereal prices relate to demand and explores the tradeoff between sales volume, revenue, and approximate gross profit.

## Tools
- Python: data cleaning, exploratory analysis, and elasticity modeling
- DuckDB SQL: reporting tables, aggregation, and validation
- Power BI: interactive reporting and pricing scenario visualization

## Analysis
The project estimates price elasticities for the ten highest-revenue cereal products using promotion controls, store and week fixed effects, and standard errors clustered by store.

A separate Cheerios 15 oz case study evaluates price-change scenarios using a reference price of $3.35 and approximate unit cost of $2.824.

## Key Findings
- Estimated price sensitivity varies across products.
- Eight of the ten product point estimates are below −1.
- Some confidence intervals cross −1, making elastic-versus-inelastic classifications uncertain.
- For Cheerios 15 oz, a modeled 5% price increase reduces revenue by approximately 2.9% while increasing approximate gross profit by 22%.
- Modeled gross profit reaches its highest value at the upper boundary of the tested price grid; the analysis does not establish an optimal price.

## Project Structure
- `notebooks/`: cleaning, exploration, modeling, and SQL reporting
- `sql/`: reporting view definitions
- `outputs/python_results/`: exported model estimates and scenarios
- `outputs/powerbi/`: SQL reporting exports used in Power BI
- `dashboard/`: report screenshots and PDF

## Dashboard Preview
![Sales Overview](dashboard/sales_overview.png)

![Price Sensitivity](dashboard/price_sensitivity.png)

![Pricing Scenarios](dashboard/pricing_scenarios.png)

## Run the analysis

Raw data, processed Parquet files, and the local database are not included. The committed CSVs, screenshots, and PDF contain the original analysis results. Notebooks are stored without execution output to keep the walkthrough readable; run them to generate current tables and charts.

Use a Python environment with `pandas`, `numpy`, `matplotlib`, `statsmodels`, `pyarrow`, `duckdb`, and Jupyter installed. Open the notebooks with the kernel's working directory set to the repository root or `notebooks/`; project paths are resolved automatically.

1. Create `data/raw/` and add `wcer.zip` (containing `wcer.csv`) and `upccer.csv`.
2. Run [01 · Data cleaning](notebooks/01_data_cleaning.ipynb) to join product metadata, apply the final sample rules, check quality, and save processed Parquet files.
3. Run [02 · Exploratory analysis](notebooks/02_eda.ipynb) to examine product performance, price variation, promotions, and store/week differences.
4. Run [03 · Elasticity modeling](notebooks/03_elasticity_modeling.ipynb) to compare specifications, check sensitivity, evaluate price scenarios, and export three tables to `outputs/python_results/`.
5. Run [04 · SQL reporting](notebooks/04_sql_reporting.ipynb) to load DuckDB, apply [the reporting views](sql/01_reporting_views.sql), reconcile totals, and export five tables to `outputs/powerbi/`.

Run each notebook from top to bottom. The workflow creates output directories and overwrites generated files on rerun. Only the two sales-reporting exports are currently committed in `outputs/powerbi/`; notebook 04 also copies the three model tables there for Power BI. Import UPC as text to preserve it as a join key.

Each notebook explains its inputs, decisions, and outputs. Historical numerical interpretations refer to the original dataset run and should be checked against new results when rerunning with different data. The cleanup preserves the original sample rules, model specifications, scenario formulas, and export schemas; it adds checks for ambiguous product joins, failed portfolio fits, and reporting totals.

[View the Cereal Pricing Analysis report](dashboard/Cereal%20Pricing%20Analysis.pdf)

## Limitations
Sales analysis retains valid positive-sales observations. Elasticity estimates are observational rather than causal. Pricing scenarios assume constant elasticity and fixed approximate unit cost derived from the dataset’s accounting margin field.

The portfolio and Cheerios scenario models use different promotion-control specifications.

