
with source as(
      SELECT 
          *
      FROM 
          {{source('source_fitness','COUNTRY_REGION')}}
),
eliminate_null_rows as(
      SELECT 
          *
      FROM 
          source
      WHERE 
          COUNTRY IS NOT NULL
          AND CUSTOMER_ID IS NOT NULL
          AND REGION IS NOT NULL
)

SELECT * FROM eliminate_null_rows