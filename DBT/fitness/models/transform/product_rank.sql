select
    t.product_id,
    p.product_family,
    sum(t.revenue) as total_revenue,
    rank() over (order by sum(t.revenue) desc) as product_rank
from
    {{ ref('stg_transactions') }} t
    join {{ ref('stg_products') }} p
    on t.product_id = p.product_id
group by
    t.product_id,
    p.product_family
order by
    total_revenue desc