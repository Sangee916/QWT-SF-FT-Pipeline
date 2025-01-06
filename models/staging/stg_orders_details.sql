{{ config(materialized = 'incremental', unique_key = ['orderid', 'lineno']) }}
 
select
od.order_id as orderid,
od.line_no as lineno,
product_id as productid,
quantity,
unit_price as unitprice,
discount,
o.order_date as orderdate
from
{{source("QWT_RAW", "Orders")}} as o inner join {{source("QWT_RAW", "OrderDetails")}} as od
on o.order_id = od.order_id
 
{% if is_incremental() %}
 
where o.order_date > (select max(orderdate)  from {{this}} )
 
{% endif %}