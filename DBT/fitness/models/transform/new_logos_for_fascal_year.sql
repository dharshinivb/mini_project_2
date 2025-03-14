WITH first_transactions AS (
    SELECT 
        customer_id,
        MIN(payment_month) AS first_payment_month
    FROM 
        {{ ref('stg_transactions') }}
    GROUP BY 
        customer_id
),
required_data AS (
    SELECT 
        customer_id,
        TO_CHAR(MIN(payment_month), 'yyyy') AS year
    FROM 
        {{ ref('stg_transactions') }}
    WHERE 
        customer_id IN (SELECT customer_id FROM first_transactions)
    GROUP BY 
        customer_id
)
SELECT 
    year,
    COUNT(DISTINCT customer_id) AS new_logos
FROM 
    required_data
GROUP BY 
    year
ORDER BY 
    year