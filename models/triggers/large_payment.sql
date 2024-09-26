-- Count payments over $1000 as large
select
    'jaffle_shop.payments.large_payments' as metric_name,
    'count' as metric_type,
    1 as metric_value,
    object_construct('payment_method', payment_method) as metric_tags
from {{ ref('stg_payments') }}
where amount > 1000
-- debugging
-- debugging
-- debugging
-- debugging
-- debugging
