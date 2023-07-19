WITH
	sales_total AS (
		SELECT product_id, sales_date, sales_cnt,
		       (SELECT shop_id FROM shop WHERE shop_name = 'DNS') AS shop_id
		FROM shop_dns
		UNION DISTINCT SELECT product_id, sales_date, sales_cnt,
			  	      (SELECT shop_id FROM shop WHERE shop_name = 'М.Видео') AS shop_id
			       FROM shop_mvideo
		UNION DISTINCT SELECT product_id, sales_date, sales_cnt,
				      (SELECT shop_id FROM shop WHERE shop_name = 'Ситилинк') AS shop_id
			       FROM shop_citilink
	),
	sales AS (
		SELECT s.shop_id, s.product_id, s.last_date_of_month, SUM(s.sales_cnt) AS sales_of_month
		FROM (
		      SELECT shop_id, product_id, sales_cnt, 
			     (date_trunc('month', sales_date) + INTERVAL 1 MONTH - INTERVAL 1 DAY) AS last_date_of_month
		      FROM sales_total
		) AS s
		GROUP BY shop_id, product_id, last_date_of_month
		ORDER BY shop_id, product_id
	)


SELECT sh.shop_name,
	   pr.product_name,
	   p.plan_date,
	   s.sales_of_month AS sales_fact,
	   p.plan_cnt AS sales_plan,
	   round(s.sales_of_month / p.plan_cnt, 2) AS "sales_fact/sales_plan",
	   s.sales_of_month * pr.price AS income_fact,
	   p.plan_cnt * pr.price AS income_plan,
	   round(((s.sales_of_month * pr.price) / (p.plan_cnt * pr.price)), 2) AS "income_fact/income_plan"
FROM plan AS p
JOIN shop AS sh ON p.shop_id = sh.shop_id
JOIN sales AS s ON p.shop_id = s.shop_id AND p.product_id = s.product_id AND p.plan_date = s.last_date_of_month
JOIN products AS pr ON p.product_id = pr.product_id;