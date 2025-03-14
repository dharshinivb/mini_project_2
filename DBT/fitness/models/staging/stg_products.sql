
with source as(
      SELECT 
          *
      FROM 
          {{source('source_fitness','PRODUCTS')}}
),
eliminate_null_rows as(
      SELECT 
          *
      FROM 
          source
      WHERE 
          PRODUCT_FAMILY IS NOT NULL
          AND PRODUCT_ID IS NOT NULL
          AND PRODUCT_SUB_FAMILY IS NOT NULL
)

SELECT * FROM eliminate_null_rows