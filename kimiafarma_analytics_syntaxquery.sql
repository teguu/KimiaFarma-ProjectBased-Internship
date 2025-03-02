create table rakamin-kf-analytics-452112.kimia_farma.kf_analytics as
select
  t.transaction_id, 
  t.date, 
  c.branch_id, 
  c.branch_name, 
  c.kota, 
  c.provinsi, 
  c.rating, 
  t.customer_name, 
  p.product_id, 
  p.product_name, 
  p.price as actual_price, 
  t.discount_percentage, 
  t.rating as rating_transaksi,

  case
    when p.price <= 50000 then 0.10
    when p.price > 50000 and p.price <= 100000 then 0.15
    when p.price > 100000 and p.price <= 300000 then 0.20
    when p.price > 300000 and p.price <= 500000 then 0.25 
    else 0.30
  end as presentase_gross_laba,

 p.price * (1 - t.discount_percentage) AS nett_sales,

 (p.price * (1 - t.discount_percentage)) * 
  CASE
    WHEN p.price <= 50000 THEN 0.10
    WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
    WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
    WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25 
    ELSE 0.30
  END AS nett_profit,
  
from `rakamin-kf-analytics-452112.kimia_farma.kf_final_transaction`as t
join `rakamin-kf-analytics-452112.kimia_farma.kf_kantor_cabang`as c on t.branch_id = c.branch_id
join `rakamin-kf-analytics-452112.kimia_farma.kf_product`as p on t.product_id = p.product_id;