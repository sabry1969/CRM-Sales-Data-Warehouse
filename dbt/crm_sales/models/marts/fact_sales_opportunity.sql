WITH opportunities AS (
    SELECT *
    FROM {{ ref('stg_sales_pipeline') }}
),

accounts AS (
    SELECT *
    FROM {{ ref('dim_account') }}
),

products AS (
    SELECT *
    FROM {{ ref('dim_product') }}
),

sales_agents AS (
    SELECT *
    FROM {{ ref('dim_sales_agent') }}
)

SELECT
    hash(o.opportunity_id) AS opportunity_key,
    o.opportunity_id,

    COALESCE(a.account_key, 0) AS account_key,
    COALESCE(p.product_key, 0) AS product_key,
    COALESCE(s.sales_agent_key, 0) AS sales_agent_key,

    o.deal_stage,

    CAST(strftime(o.engage_date, '%Y%m%d') AS INTEGER)
        AS engage_date_key,

    CAST(strftime(o.close_date, '%Y%m%d') AS INTEGER)
        AS close_date_key,

    o.close_value

FROM opportunities o

LEFT JOIN accounts a
    ON o.account = a.account

LEFT JOIN products p
    ON o.product = p.product

LEFT JOIN sales_agents s
    ON o.sales_agent = s.sales_agent