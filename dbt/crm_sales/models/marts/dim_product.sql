WITH products AS (
    SELECT *
    FROM {{ ref('stg_products') }}
),

dimension AS (
    SELECT
        hash(product) AS product_key,
        product,
        series,
        sales_price
    FROM products
)

SELECT * FROM dimension

UNION ALL

SELECT
    0 AS product_key,
    'Unknown' AS product,
    'Unknown' AS series,
    NULL AS sales_price