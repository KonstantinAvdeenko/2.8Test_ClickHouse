(SELECT
        product_id,
        SUM(sales_cnt) AS Sales_fact
    FROM
        Shop_dns
    GROUP BY
        product_id) AS Shop_dns_sum ON Plan.product_id = Shop_dns_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt) AS Sales_fact
    FROM
        Shop_mvideo
    GROUP BY
        product_id) AS Shop_mvideo_sum ON Plan.product_id = Shop_mvideo_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt) AS Sales_fact
    FROM
        Shop_citilink
    GROUP BY
        product_id) AS Shop_citilink_sum ON Plan.product_id = Shop_citilink_sum.product_id
(SELECT Plan.plan_cnt FROM Plan AS Sales_plan) 
LEFT JOIN
(SELECT
product_id,
        SUM(sales_cnt)/Plan.plan_cnt AS Sales_fact_del_sales_plan
    FROM
        Shop_dns
    GROUP BY
        product_id) AS Shop_dns_sum ON Plan.product_id = Shop_dns_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt)/Plan.plan_cnt AS Sales_fact_del_sales_plan
    FROM
        Shop_mvideo
    GROUP BY
        product_id) AS Shop_mvideo_sum ON Plan.product_id = Shop_mvideo_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(Float32(sales_cnt))/Float32(Plan.plan_cnt)  AS Sales_fact_del_sales_plan
    FROM
        Shop_citilink
    GROUP BY
        product_id) AS Shop_citilink_sum ON Plan.product_id = Shop_citilink_sum.product_id
LEFT JOIN
(SELECT
product_id,
        SUM(sales_cnt)* Products.price AS Income_fact
    FROM
        Shop_dns
    GROUP BY
        product_id) AS Shop_dns_sum ON Plan.product_id = Shop_dns_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt)* Products.price AS Income_fact
    FROM
        Shop_mvideo
    GROUP BY
        product_id) AS Shop_mvideo_sum ON Plan.product_id = Shop_mvideo_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt)* Products.price AS Income_fact
    FROM
        Shop_citilink
    GROUP BY
        product_id) AS Shop_citilink_sum ON Plan.product_id = Shop_citilink_sum.product_id
(SELECT Plan.plan_cnt * Products.price AS Income_plan FROM Plan, Products
GROUP BY
        Plan.plan_cnt * Products.price) AS Income_plan ON Plan.product_id = Products.product_id
LEFT JOIN
(SELECT
product_id,
        SUM(sales_cnt * Products.price)/(Plan.plan_cnt * Products.price) AS Income_fact_del_income_plan
    FROM
        Shop_dns
    GROUP BY
        product_id) AS Shop_dns_sum ON Plan.product_id = Shop_dns_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt * Products.price)/(Plan.plan_cnt * Products.price) AS Income_fact_del_income_plan
    FROM
        Shop_mvideo
    GROUP BY
        product_id) AS Shop_mvideo_sum ON Plan.product_id = Shop_mvideo_sum.product_id
LEFT JOIN
    (SELECT
        product_id,
        SUM(sales_cnt * Products.price)/(Plan.plan_cnt * Products.price) AS Income_fact_del_income_plan
    FROM
        Shop_citilink
    GROUP BY
        product_id) AS Shop_citilink_sum ON Plan.product_id = Shop_citilink_sum.product_id