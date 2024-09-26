## Example Balto project: `jaffle_shop`

`jaffle_shop` is a fictional ecommerce store. This Balto project transforms raw data from an app database into a customers and orders model ready for analytics.

### What is this repo?
What this repo _is_:
- A self-contained example Balto project, useful for testing out scripts, and communicating some of the core Balto concepts.

### What's in this repo?
This repo contains some (fake) raw data from a fictional app.

The raw data consists of customers, orders, and payments, with the following entity-relationship diagram:

![Jaffle Shop ERD](/etc/jaffle_shop_erd.png)


### Running this project
To get up and running with this project:
1. Clone this repo

2. Install the Balto Snowflake Native app.

3. Once it's installed, initiate the installation of the Balto Github integration:
```
call balto.config.setup_github();
```

4. Create a new database/schema and grant it to the Balto app:
```
create database jaffle
create schema jaffle.test
grant all on database jaffle to application balto;
grant all on schema jaffle.test to application balto;
```

5. Add a new resource, commit it, and merge to `main`:
``` title="models/schedules.yml"
version: 2

schedules:
    - name: hourly_orders_refresh
      schedule: 0 * * * *
      selector: model.jaffle_shop.orders+
```

6. Confirm that your change was deployed and that the new schedule is running:

```
select
    bt.triggered_at,
    bt.trigger_type,
    bt.triggered_by,
    b.selector_stmt,
    b.status
from system.builds b
join system.build_triggers bt on b.trigger_id = bt.trigger_id
order by bt.triggered_at desc;
---
TRIGGERED_AT	TRIGGER_TYPE	TRIGGERED_BY	SELECTOR_STMT	STATUS
2024-09-26 13:00:02.952	SCHEDULED_BUILD	schedules.jaffle_shop.hourly_orders_refresh	model.jaffle_shop.orders+	SUCCESS
2024-09-26 12:00:01.594	SCHEDULED_BUILD	schedules.jaffle_shop.hourly_orders_refresh	model.jaffle_shop.orders+	SUCCESS
2024-09-26 11:00:02.437	SCHEDULED_BUILD	schedules.jaffle_shop.hourly_orders_refresh	model.jaffle_shop.orders+	SUCCESS
2024-09-26 10:56:42.372	DEPLOY	togo@baltodatatool.com	state:modified+	SUCCESS
```


### What is a jaffle?
A jaffle is a toasted sandwich with crimped, sealed edges. Invented in Bondi in 1949, the humble jaffle is an Australian classic. The sealed edges allow jaffle-eaters to enjoy liquid fillings inside the sandwich, which reach temperatures close to the core of the earth during cooking. Often consumed at home after a night out, the most classic filling is tinned spaghetti, while my personal favourite is leftover beef stew with melted cheese.
