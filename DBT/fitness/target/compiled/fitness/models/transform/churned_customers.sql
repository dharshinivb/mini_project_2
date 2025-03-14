with reference as (
    select
        *
    from
        FITNESS_TRACKER.staging.stg_transactions
),
 
last_transaction as (
    select
        customer_id,
        max(payment_month) as last_payment_month
    from reference
    group by customer_id
),
 
churned_customers as (
    select
        customer_id,
        last_payment_month,
        month(last_payment_month) as churn_month,
        year(last_payment_month) as churn_year
    from last_transaction
    where last_payment_month < dateadd('month', -1, current_date)
)
select
    churn_year,
    churn_month,
    count(customer_id) as churned_customers_count
from churned_customers
group by churn_year, churn_month
order by churn_year, churn_month