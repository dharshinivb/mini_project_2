WITH formatted_transactions AS (
    SELECT 
        customer_id,
        product_id,
        {{ format_date('payment_month', 'YYYY-MM') }} AS month,
        revenue
    FROM 
        {{ ref('stg_transactions') }}
)

SELECT 
    customer_id,
    product_id,
    month,
    SUM(revenue) AS MRR
FROM 
    formatted_transactions
GROUP BY 
    customer_id, product_id, month
ORDER BY 
    month