
  
    

        create or replace transient table FITNESS_TRACKER.transform.new_customers
         as
        (WITH first_transactions AS (
    SELECT 
        customer_id,
        MIN(payment_month) AS first_payment_month
    FROM 
        FITNESS_TRACKER.staging.stg_transactions
    GROUP BY 
        customer_id
),
required_data AS (
    SELECT 
        ft.customer_id,
        
    TO_CHAR(ft.first_payment_month, 'YYYY-MM')
 AS year_month,
        
    TO_CHAR(ft.first_payment_month, 'YYYY')
 AS year,
        
    TO_CHAR(ft.first_payment_month, 'MM')
 AS month
    FROM 
        first_transactions ft
)

SELECT 
    year,
    month,
    COUNT(DISTINCT customer_id) AS new_logos
FROM 
    required_data
GROUP BY 
    year, month
ORDER BY 
    year, month
        );
      
  