
  
    

        create or replace transient table FITNESS_TRACKER.staging.stg_country_region
         as
        (with source as(
      SELECT 
          *
      FROM 
          FITNESS_TRACKER.RAW.COUNTRY_REGION
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
        );
      
  