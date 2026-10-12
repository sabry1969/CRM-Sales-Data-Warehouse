SELECT
    product,
    series,
    sales_price
FROM {{ ref('products') }}