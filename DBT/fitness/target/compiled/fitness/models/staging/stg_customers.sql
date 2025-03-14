with source as(
      SELECT 
          *
      FROM 
          FITNESS_TRACKER.RAW.CUSTOMERS
),
eliminate_null_rows as(
      SELECT 
          CAST(CUSTOMER_ID AS INT) AS CUSTOMER_ID,
          CUSTOMERNAME,
          COMPANY
      FROM 
          source
      WHERE 
          COMPANY IS NOT NULL
          AND CUSTOMER_ID IS NOT NULL
          AND CUSTOMERNAME IS NOT NULL
)

SELECT * FROM eliminate_null_rows