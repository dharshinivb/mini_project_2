with source as(
      SELECT 
          *
      FROM 
          FITNESS_TRACKER.RAW.TRANSACTIONS
),
eliminate_null_rows as(
      SELECT 
          *
      FROM 
          source
      WHERE 
          COMPANIES IS NOT NULL
          AND CUSTOMER_ID IS NOT NULL
          AND DIMENSION_1 IS NOT NULL
          AND DIMENSION_2 IS NOT NULL
          AND DIMENSION_3 IS NOT NULL
          AND DIMENSION_4 IS NOT NULL
          AND DIMENSION_5 IS NOT NULL
          AND DIMENSION_6 IS NOT NULL
          AND DIMENSION_7 IS NOT NULL
          AND DIMENSION_8 IS NOT NULL
          AND DIMENSION_9 IS NOT NULL
          AND DIMENSION_10 IS NOT NULL
          AND QUANTITY IS NOT NULL
          AND REVENUE IS NOT NULL
          AND REVENUE_TYPE IS NOT NULL
)

SELECT * FROM eliminate_null_rows