-- Count payments less than $1.00 as small
select
    'jaffle_shop.payments.small_payments' as metric_name,
    'count' as metric_type,
    1 as metric_value,
    object_construct('payment_method', payment_method) as metric_tags
from {{ ref('stg_payments') }}
where amount < 1
