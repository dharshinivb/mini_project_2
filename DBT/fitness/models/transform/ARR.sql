WITH formatted_transactions AS (
    SELECT 
        customer_id,
        product_id,
        {{ format_date('payment_month', 'YYYY') }} AS year,
        revenue
    FROM 
        {{ ref('stg_transactions') }}
)

SELECT 
    customer_id,
    product_id,
    year,
    SUM(revenue) AS ARR
FROM 
    formatted_transactions
GROUP BY 
    customer_id, product_id, year
ORDER BY 
    year