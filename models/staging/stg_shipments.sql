{{ config(materialized = 'table')}}

select 
Order_ID as OrderID,
Line_no  as LineNo,
Shipper_ID as ShipperID,
Customer_id as CustomerID,
Product_id as ProductID,
Employee_id as EmployeeID,
Shipment_date as ShipmentDate,
Status 
from
{{source('QWT_RAW','Shipments')}}
 