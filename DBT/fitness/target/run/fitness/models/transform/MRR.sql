
  
    

        create or replace transient table FITNESS_TRACKER.transform.MRR
         as
        (WITH formatted_transactions AS (
    SELECT 
        customer_id,
        product_id,
        TO_CHAR(payment_month, 'YYYY-MM') AS month,
        revenue
    FROM 
        FITNESS_TRACKER.staging.stg_transactions
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
        );
      
  