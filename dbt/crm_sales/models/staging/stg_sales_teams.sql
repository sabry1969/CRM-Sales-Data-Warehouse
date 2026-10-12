SELECT
    sales_agent,
    manager,
    regional_office
FROM {{ ref('sales_teams') }}