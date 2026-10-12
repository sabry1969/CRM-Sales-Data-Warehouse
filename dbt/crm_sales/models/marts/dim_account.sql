WITH accounts AS (
    SELECT *
    FROM {{ ref('stg_accounts') }}
),

dimension AS (
    SELECT
        hash(account) AS account_key,
        account,
        sector,
        year_established,
        revenue,
        employees,
        office_location,
        subsidiary_of
    FROM accounts
)

SELECT * FROM dimension

UNION ALL

SELECT
    0 AS account_key,
    'Unknown' AS account,
    'Unknown' AS sector,
    NULL AS year_established,
    NULL AS revenue,
    NULL AS employees,
    'Unknown' AS office_location,
    NULL AS subsidiary_of