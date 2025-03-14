
  
    

        create or replace transient table FITNESS_TRACKER.transform.ARR
         as
        (WITH formatted_transactions AS (
    SELECT 
        customer_id,
        product_id,
        
    TO_CHAR(payment_month, 'YYYY')
 AS year,
        revenue
    FROM 
        FITNESS_TRACKER.staging.stg_transactions
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
        );
      
  