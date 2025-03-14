
  
    

        create or replace transient table FITNESS_TRACKER.transform.revenue_table
         as
        (WITH formatted_transactions AS (
    SELECT 
        t.customer_id,
        t.product_id,
        c.customername,
        p.PRODUCT_Family,
        p.product_sub_family,
        
    TO_CHAR(t.payment_month, 'YYYY-MM')
 AS month,
        t.revenue
    FROM 
        FITNESS_TRACKER.staging.stg_transactions t
    JOIN 
        FITNESS_TRACKER.staging.stg_customers c ON t.customer_id = c.customer_id
    JOIN 
        FITNESS_TRACKER.staging.stg_products p ON t.product_id = p.product_id
),
mrr_data AS (
    SELECT 
        customer_id,
        product_id,
        month,
        MRR
    FROM 
        FITNESS_TRACKER.transform.MRR
),
arr_data AS (
    SELECT 
        customer_id,
        product_id,
        year,
        ARR
    FROM 
        FITNESS_TRACKER.transform.ARR
)

SELECT 
    ft.customer_id,
    ft.product_id,
    ft.customername,
    ft.PRODUCT_Family,
    ft.product_sub_family,
    ft.month,
    mrr_data.MRR,
    arr_data.ARR
FROM 
    formatted_transactions ft
JOIN 
    mrr_data ON ft.customer_id = mrr_data.customer_id AND ft.product_id = mrr_data.product_id AND ft.month = mrr_data.month
JOIN 
    arr_data ON ft.customer_id = arr_data.customer_id AND ft.product_id = arr_data.product_id AND ft.month = arr_data.year
ORDER BY 
    ft.month
        );
      
  