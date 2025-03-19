{% snapshot orders_snapshot_timestamp %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='order_id',
          check_cols='all',
        )
    }}

    select * from {{ ref('orders') }}

{% endsnapshot %}
