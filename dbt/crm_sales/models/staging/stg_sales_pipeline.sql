SELECT
    opportunity_id,
    sales_agent,
    product,
    account,
    deal_stage,
    engage_date,
    close_date,
    close_value
FROM {{ ref('sales_pipeline') }}