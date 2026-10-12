WITH date_spine AS (
    SELECT
        generate_series AS full_date
    FROM generate_series(
        DATE '2015-01-01',
        DATE '2030-12-31',
        INTERVAL '1 day'
    )
)

SELECT
    CAST(strftime(full_date, '%Y%m%d') AS INTEGER) AS date_key,
    full_date,
    EXTRACT(DAY FROM full_date)::INTEGER AS day,
    EXTRACT(MONTH FROM full_date)::INTEGER AS month,
    strftime(full_date, '%B') AS month_name,
    EXTRACT(QUARTER FROM full_date)::INTEGER AS quarter,
    EXTRACT(YEAR FROM full_date)::INTEGER AS year
FROM date_spine