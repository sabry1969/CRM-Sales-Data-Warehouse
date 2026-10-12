WITH agents AS (
    SELECT *
    FROM {{ ref('stg_sales_teams') }}
),

dimension AS (
    SELECT
        hash(sales_agent) AS sales_agent_key,
        sales_agent,
        manager,
        regional_office
    FROM agents
)

SELECT * FROM dimension

UNION ALL

SELECT
    0 AS sales_agent_key,
    'Unknown' AS sales_agent,
    'Unknown' AS manager,
    'Unknown' AS regional_office