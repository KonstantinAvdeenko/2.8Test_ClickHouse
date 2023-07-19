
CREATE TABLE IF NOT EXISTS shop (
    "shop_id" UInt32 NOT NULL,
    "shop_name" String NOT NULL
)
ENGINE = MergeTree()
PRIMARY KEY (shop_id);

CREATE TABLE IF NOT EXISTS products (
    "product_id" UInt32 NOT NULL,
    "product_name" String NOT NULL,
    "price" Float32 NOT NULL
)
ENGINE = MergeTree()
PRIMARY KEY (product_id)

CREATE TABLE IF NOT EXISTS plan (
    "plan_id" UInt32 NOT NULL,
    "shop_id" UInt32 NOT NULL,
    "product_id" UInt32 NOT NULL,
    "plan_cnt" UInt32 NOT NULL,
    "plan_date" date NOT NULL
);
ENGINE = MergeTree()
PRIMARY KEY (plan_id)
ORDER BY (plan_id, shop_id, product_id);

CREATE TABLE IF NOT EXISTS shop_dns (
    "shop_dns_id" UInt32 NOT NULL,
    "sales_date" date NOT NULL,
    "product_id" UInt32 NOT NULL,
    "sales_cnt" UInt32 NOT NULL
)
ENGINE = MergeTree()
PRIMARY KEY (shop_dns_id)
ORDER BY (shop_dns_id, product_id);

CREATE TABLE IF NOT EXISTS shop_mvideo (
    "shop_mvideo_id" UInt32 NOT NULL,
    "sales_date" date,
    "product_id" UInt32 NOT NULL,
    "sales_cnt" UInt32 NOT NULL
)
ENGINE = MergeTree()
PRIMARY KEY (shop_mvideo_id)
ORDER BY (shop_mvideo_id, product_id);

CREATE TABLE IF NOT EXISTS shop_citilink (
    "shop_citilink_id" UInt32 NOT NULL,
    "sales_date" date,
    "product_id" UInt32 NOT NULL,
    "sales_cnt" UInt32 NOT NULL
);
ENGINE = MergeTree()
PRIMARY KEY (shop_citilink_id)
ORDER BY (shop_citilink_id, product_id);




 