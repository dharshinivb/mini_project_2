
  
    

        create or replace transient table FITNESS_TRACKER.transform.product_churn
         as
        (WITH customer_purchases AS (
    SELECT 
        customer_id,
        product_id,
        payment_month
    FROM 
        FITNESS_TRACKER.staging.stg_transactions
),
last_purchases AS (
    SELECT 
        customer_id,
        product_id,
        MAX(payment_month) AS last_purchase_month
    FROM 
        customer_purchases
    GROUP BY 
        customer_id, product_id
),
churned_products AS (
    SELECT 
        lp.customer_id,
        lp.product_id,
        lp.last_purchase_month,
        DATEADD(MONTH, 3, lp.last_purchase_month) AS churn_threshold
    FROM 
        last_purchases lp
    WHERE 
        DATEADD(MONTH, 3, lp.last_purchase_month) < GETDATE()
)
SELECT 
    customer_id,
    product_id,
    last_purchase_month,
    churn_threshold
FROM 
    churned_products
ORDER BY 
    customer_id, product_id
        );
      
  