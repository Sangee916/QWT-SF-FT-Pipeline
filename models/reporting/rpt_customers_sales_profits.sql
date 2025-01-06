{{ config(materialized = 'view',  schema = 'reporting') }}

select
c.companyname,
c.contactname,
min(f.orderdate) as first_order_date,
max(f.orderdate) as recent_order_date,
count(p.productid) as cnt_products,
sum(f.quantity) as sum_quantity,
sum(f.linesalesamount) as sum_linesalesamount,
avg(f.margin) as avg_margin
from
{{ ref('fct_orders')}} as f 
left join {{ ref('dim_customers')}} as c on f.customerid = c.customerid
left join {{ref('dim_products')}} as p on p.productid=f.productid
group by c.companyname, c.contactname
order by c.companyname, c.contactname




