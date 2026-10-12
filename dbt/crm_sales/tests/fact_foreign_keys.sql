SELECT *
FROM {{ ref('fact_sales_opportunity') }}
WHERE account_key NOT IN (
    SELECT account_key
    FROM {{ ref('dim_account') }}
)
OR product_key NOT IN (
    SELECT product_key
    FROM {{ ref('dim_product') }}
)
OR sales_agent_key NOT IN (
    SELECT sales_agent_key
    FROM {{ ref('dim_sales_agent') }}
)