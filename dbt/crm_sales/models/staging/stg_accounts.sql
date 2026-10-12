SELECT
    account,
    sector,
    year_established,
    revenue,
    employees,
    office_location,
    subsidiary_of
FROM {{ ref('accounts') }}