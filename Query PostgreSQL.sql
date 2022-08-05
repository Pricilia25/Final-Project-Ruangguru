-- Create tabel and impor data--
-- Create tabel and import data data inventory_item (primary data)--
select * from data_inventory
CREATE TABLE public.data_inventory
(
	inventory_id integer,
	product_id integer,
	created_at timestamp,
	sold_at timestamp,
	cost double precision,
	product_category character varying,
	product_name character varying,
	product_brand charachter varying,
	product_retail_price double precision,
	product_department text,
	product_sku text,
	product_distribution_center_id
);

select * from data_inventory

-- Create tabel and import data data distribution_centers (secondary data)--
CREATE TABLE public.distribution_centers
(
	id smallint,
	name character varying,
	latitude float,
	longitude float
);

select * from distribution_centers

--MENCARI NILAI NULL sold_at--
select * from data_inventory
where sold_at is null
--cara 1
select count(*) - count(sold_at), count(sold_at) from data_inventory

--cara 2
select sum(case when sold_at is null then 1 else 0 end) count_nulls
	, count(sold_at) count_not_nulls
	from data_inventory

--MENCARI NILAI NULL produk_brand--
select * from data_inventory
where product_brand is null

select sum(case when product_brand is null then 1 else 0 end) count_nulls
	, count(product_brand) count_not_nulls
	from data_inventory

--EXPLORASI DATA--
SELECT id, name, latitude, longitude, created_at, sold_at, product_category, cost, product_department, product_retail_price
from data_inventory
inner join distribution_centers
ON data_inventory.product_distribution_center_id= distribution_centers.id

--MENCARI COST TERTINGGI
SELECT id, name, SUM (cost)
FROM data_inventory
inner join distribution_centers
ON data_inventory.product_distribution_center_id= distribution_centers.id
GROUP BY (id, name);
--HOUSTON TX menjadi dc yang paling banyak/tinggi biaya nya—

--melihat poduct per category masing2 dc--
SELECT id, name, product_category
FROM data_inventory
inner join distribution_centers
ON data_inventory.product_distribution_center_id= distribution_centers.id
GROUP BY (id, name, product_category);

