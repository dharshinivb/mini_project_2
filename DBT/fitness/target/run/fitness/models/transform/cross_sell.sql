
  
    

        create or replace transient table FITNESS_TRACKER.transform.cross_sell
         as
        (WITH customer_purchases AS (
    SELECT 
        customer_id,
        product_id,
        payment_month
    FROM 
        FITNESS_TRACKER.staging.stg_transactions
),
cross_sells AS (
    SELECT 
        cp1.customer_id,
        cp1.product_id AS current_product,
        cp1.payment_month AS current_month,
        cp2.product_id AS next_product,
        cp2.payment_month AS next_month
    FROM 
        customer_purchases cp1
    JOIN 
        customer_purchases cp2 ON cp1.customer_id = cp2.customer_id 
        AND DATEADD(MONTH, 1, cp1.payment_month) = cp2.payment_month
        AND cp1.product_id != cp2.product_id
)
SELECT 
    customer_id,
    COUNT(DISTINCT next_product) AS cross_sell_count
FROM 
    cross_sells
GROUP BY 
    customer_id
ORDER BY 
    cross_sell_count DESC
        );
      
  