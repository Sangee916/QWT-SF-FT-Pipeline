{{ config(materialized = 'table', schema = 'transforming')}}

select 
p.productid,
p.productname,
c.Categoryname,
s.companyname as suppliercompanyname,
s.contactname as suppliercontactnane,
s.city as suppliercity,
s.country as suppliercountry,
p.quantityperunit,
p.unitcost,
p.unitprice,
p.unitsinstock,
p.unitsonorder,
(p.unitprice-p.unitcost) as profit,
iff(p.unitsonorder<=p.unitsinstock,'Yes','No') as is_stock_available
from 
{{ref('stg_products')}} as p 
left join {{ref('lkp_categories')}} as c on p.categoryid=c.categoryid
left join {{ref('trf_suppliers')}} as s on p.supplierid = s.supplierid

