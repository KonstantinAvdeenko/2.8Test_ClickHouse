
CREATE TABLE IF NOT EXISTS Products
( product_id Int32 NOT NULL, 
  product_name FixedString (255) NOT NULL,
  price Float32 NOT NULL)
  engine = MergeTree() order by product_id settings index_granularity = 1;

CREATE TABLE IF NOT EXISTS Name_shop
( id_shop Int32 NOT NULL,
  name_shop FixedString (255) NOT NULL)
  engine = MergeTree() order by id_shop settings index_granularity = 1;

CREATE TABLE IF NOT EXISTS Plan
( 
  id_plan Int32 NOT NULL,
  product_id Int32 NOT NULL,
  id_shop Int32 NOT NULL,
  plan_cnt Int32 NOT NULL,
  plan_date DATE NOT NULL)
  engine = MergeTree() order by id_plan settings index_granularity = 1;

CREATE TABLE IF NOT EXISTS Shop_dns
( id_dns Int32 NOT NULL,
  product_id Int32 NOT NULL,
  sales_cnt Int32 NOT NULL,
  dates DATE NOT NULL)
  engine = MergeTree() order by id_dns settings index_granularity = 1;

CREATE TABLE IF NOT EXISTS Shop_mvideo
( id_mvideo Int32 NOT NULL,
  product_id Int32 NOT NULL,
  sales_cnt Int32 NOT NULL,
  dates DATE NOT NULL)
  engine = MergeTree() order by id_mvideo settings index_granularity = 1;

CREATE TABLE IF NOT EXISTS Shop_citilink
( id_citilink Int32 NOT NULL,
  product_id Int32 NOT NULL,
  sales_cnt Int32 NOT NULL,
  dates DATE NOT NULL)
  engine = MergeTree() order by id_citilink settings index_granularity = 1;




 