select order_id
from {{ ref('orders') }}
where amount < 0
