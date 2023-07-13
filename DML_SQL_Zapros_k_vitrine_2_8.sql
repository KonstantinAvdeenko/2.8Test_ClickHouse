SELECT Name_shop.name_shop, Products.product_name, Shop_dns.product_id, Plan.product_id, Shop_dns.sales_cnt, Plan.plan_cnt, Shop_mvideo.sales_cnt, Shop_citilink.sales_cnt, Products.price,
IF (Name_shop.name_shop = 'DNS', (SELECT SUM(Shop_dns.sales_cnt) FROM Shop_dns WHERE Shop_dns.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Mvideo', (SELECT SUM(Shop_mvideo.sales_cnt) FROM Shop_mvideo WHERE Shop_mvideo.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Citilink', (SELECT SUM(Shop_citilink.sales_cnt) FROM Shop_citilink WHERE Shop_citilink.product_id = Plan.product_id), Name_shop.name_shop = NULL)))  
AS Sales_fact, 
Plan.plan_cnt AS Sales_plan, 
IF (Name_shop.name_shop = 'DNS', (SELECT SUM(Shop_dns.sales_cnt :: double precision)/Plan.plan_cnt :: double precision FROM Shop_dns WHERE Shop_dns.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Mvideo', (SELECT SUM(Shop_mvideo.sales_cnt :: double precision)/Plan.plan_cnt :: double precision FROM Shop_mvideo WHERE Shop_mvideo.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Citilink', (SELECT SUM(Shop_citilink.sales_cnt :: double precision)/Plan.plan_cnt :: double precision FROM Shop_citilink WHERE Shop_citilink.product_id = Plan.product_id), Name_shop.name_shop = NULL))) 
AS Sales_fact_del_sales_plan,
IF (Name_shop.name_shop = 'DNS', (SELECT SUM(Shop_dns.sales_cnt) * Products.price FROM Shop_dns WHERE Shop_dns.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Mvideo', (SELECT SUM(Shop_mvideo.sales_cnt) * Products.price FROM Shop_mvideo WHERE Shop_mvideo.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Citilink', (SELECT SUM(Shop_citilink.sales_cnt) * Products.price FROM Shop_citilink WHERE Shop_citilink.product_id = Plan.product_id), Name_shop.name_shop = NULL))) 
AS Income_fact,
Plan.plan_cnt * Products.price AS Income_plan,
IF (Name_shop.name_shop = 'DNS', (SELECT SUM(Shop_dns.sales_cnt :: double precision * Products.price)/(Plan.plan_cnt :: double precision * Products.price) FROM Shop_dns WHERE Shop_dns.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Mvideo', (SELECT SUM(Shop_mvideo.sales_cnt :: double precision * Products.price)/(Plan.plan_cnt :: double precision * Products.price) FROM Shop_mvideo WHERE Shop_mvideo.product_id = Plan.product_id), IF (Name_shop.name_shop = 'Citilink', (SELECT SUM(Shop_citilink.sales_cnt :: double precision * Products.price)/(Plan.plan_cnt :: double precision * Products.price) FROM Shop_citilink WHERE Shop_citilink.product_id = Plan.product_id), Name_shop.name_shop = NULL)))
AS Income_fact_del_income_plan
FROM Products
INNER JOIN Plan
ON Products.product_id = Plan.product_id
INNER JOIN Shop_dns
ON Products.product_id = Shop_dns.product_id
INNER JOIN Shop_mvideo
ON Products.product_id = Shop_mvideo.product_id
INNER JOIN Shop_citilink
ON Products.product_id = Shop_citilink.product_id
INNER JOIN Name_shop
ON Plan.id_shop = Name_shop.id_shop 
GROUP BY Name_shop.name_shop, Products.product_name, Shop_dns.product_id, Shop_mvideo.product_id, 
Shop_citilink.product_id, Plan.plan_cnt, Products.price, Plan.product_id
ORDER BY Sales_fact, Sales_plan, Sales_fact_del_sales_plan, Income_fact, 
Income_plan, Income_fact_del_income_plan