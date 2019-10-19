-- �������� ���� ������ shop
CREATE SCHEMA `shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

-- ���������� ��� ���� ������
show databases;

-- �������� � ��������� ����� ������ (����� ���������� ���� ������� ������ `shop`.`category` ����� ����� ������ ������ category )
use shop;

-- �������� ������� "��������� �������"
CREATE TABLE `shop`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `discount` TINYINT NOT NULL,
PRIMARY KEY (`id`));

-- ���������� ������ �������
ALTER TABLE `shop`.`category` 
ADD COLUMN `alias_name` VARCHAR(128) NULL AFTER `discount`;

-- ���������� ��������� �������
SHOW COLUMNS FROM category;

-- ������� �������
DROP TABLE `shop`.`category`;

-- ������� ���� ������
DROP DATABASE `shop`;

-- ������� ��������
DELETE FROM category WHERE id = 5;

-- == SELECT == --
-- ������� ��� ��������� �������
SELECT * FROM category;

-- == WHERE == -- (������� �� ������������� ��������)
-- ������� ��������� ������� � ���������������, ������ 3 (������� �� ������������� ��������)
SELECT * FROM category WHERE id = 3;

-- ������� ��������� �������, � ������� ������ �� ����� 0 (������� �� ������������� ��������)
SELECT * FROM category WHERE discount <> 0;

-- ������� ��������� �������, � ������� ������ ������ 5 (������� �� ������������� ��������)
SELECT * FROM category WHERE discount > 5;

-- ������� ��������� �������, � ������� ������ ������ 5 � ������ 15 (������� �� ���� ������������ ���������)
SELECT * FROM category WHERE (discount > 5) AND (discount < 15);

-- ������� ��������� �������, � ������� ������ ������ 5 ��� ������ ��� ����� 10 (������� �� ���� ������������ ���������)
SELECT * FROM category WHERE (discount < 5) OR (discount >= 10);

-- ������� ��������� �������, � ������� ������ �� ������ 5 (������� �� ���� ������������ ���������)
SELECT * FROM category WHERE NOT (discount < 5);

-- ������� ��������� �������, � ������� ���� ��������� (������� �� ���� ������������ ���������)
SELECT * FROM category WHERE alias_name IS NOT NULL;

-- ������� ��������� �������, � ������� ��� ���������� (������� �� ���� ������������ ���������)
SELECT * FROM category WHERE alias_name IS NULL;

-- == SELECT <�������> == -- (������� �� �������)
-- ������� ������� ���� ��������� �������
SELECT name FROM category;

-- ������� ������� � ������ ������� (������� �� �������)
SELECT discount, name  FROM category;

-- ������� ��� ������ (������� �� �������)
SELECT discount FROM category;

-- ������� ������
-- DISTINCT
-- ������� ��� ���������� �������� ������ (������� ���������� ������)
SELECT DISTINCT discount FROM category;

-- == ORDER BY == -- (���������� ����������� ������)
-- ������� ��� ��������� �������, � ������������� �� �� ������� ������ (���������� ����������� ������)
SELECT * FROM category ORDER BY discount; -- ASC;

-- ������� ��� ��������� �������, � ������������� �� �� ������� ������ � �������� ������� (���������� ����������� ������)
SELECT * FROM category ORDER BY discount DESC;

-- ������� ��� ��������� ������� � ��������� �������, � ������������� �� �� ������� ������ � �������� ������� (���������� ����������� ������)
SELECT * FROM category WHERE discount <> 0 ORDER BY discount DESC;

-- == LIMIT == -- (����� ������������� ���-��)
-- ������� ������ 2 ��������� ������ (����� ������������� ���-��)
SELECT * FROM category LIMIT 2;

-- ������� ������ 2 ��������� ������ �� ������� �� ������ ���� (����� ������������� ���-��)
SELECT * FROM category WHERE discount <> 0 LIMIT 2;

-- == INSERT == -- (�������� ����� ������)
use shop;
-- (�������� ����� ������)
INSERT INTO category (id, name, discount, alias_name) VALUES (3, '������� �����', 10, NULL);
-- (�������� ����� ������)
INSERT INTO category (id, name, discount, alias_name) VALUES (4, '������� �����', 15, 'man''s shoes')
-- ���� id ����� ������������� (�������� ����� ������)
INSERT INTO category (name, discount) VALUES ('�����', 0);
-- �������� ����� ����� ����� ����� Company� (�������� ����� ������)
INSERT INTO category (name, discount) VALUES ('���� ����� Company', 0);

-- == UPDATE ==-- (���������� ������)
-- ��������� ���� � ������ � id (���������� ������)
UPDATE category SET name = '�������� �����' WHERE id = 5;
-- ��������� ���� � ������ � ���������� id (���������� ������)
UPDATE category SET discount = 3 WHERE id IN ( 2 , 5 );

-- � ������� ������� UPDATE ��������� alias_name ��� ���� ��������� (���������� ������)
UPDATE category set alias_name = 'women''s clothing' WHERE id = 1;
UPDATE category set alias_name = 'man''s clothing' WHERE id = 2;
UPDATE category set alias_name = 'women''s shoes' WHERE id = 3;


-- ==��������������� ������==
-- ����������� ����������� ������, ������� �� �������� ��������� ������� ��� ����� ������� ������� �� ��������� id �� ������ ������ ������� �� ����������
-- https://geekbrains.ru/chapters/1166
ALTER TABLE `shop`.`category` 
ADD CONSTRAINT `fk_brend_product`
FOREIGN KEY (`brand_id`)
REFERENCES `shop`.`category` (`id`)
ON DELETE NO ACTION
UPDATE NO ACTION

-- ��������� �������� -��� �������� ������ �� ����� ������ ��������� ��������� ������ �� ������ 
-- https://geekbrains.ru/chapters/1166


--==inner INNER JOIN (����������� ������ ��� �������)
-- https://geekbrains.ru/chapters/1170
-- ��� ������ ������ �� ������� product ����������� ������� �� category ������� �� �� ������������ �������� on product.category_id = category.id; 
select * from product 
	inner join category on product.category_id = category.id;

-- ��� ������ ������ �� ������� product ��������� ������ ������� � ����������� ������� �� category ������� �� �� ������������ �������� on product.category_id = category.id;     
select product.id, price, name from product  
	inner join category on product.category_id = category.id; 

-- ����������� ������ � �������� ������� ������� ��������� ����� ��������
select * from category  
	 inner join product on product.category_id = category.id;
     
-- ����������� � ������������� �� where
select * from product  
	inner join category on product.category_id = category.id
    where discount <= 5;
    
-- ������������� �����������
select * from product  
	inner join category on product.category_id = category.id 
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id;
    
-- ������������� ����������� � ��������� ��������
select product.id, brand.name, product_type.name, category.name, product.price from product  
	inner join category on product.category_id = category.id 
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id; 

-- https://geekbrains.ru/chapters/1171
-- ��������� ����� (� ������ ������� ������� ��� ������ �� ������� ���������)
select * from category
	left join product on product.category_id = category.id;

-- ��������� �����    
select * from category
	left join product on product.category_id = category.id
    where product.id is null;

-- ��������� ������
select * from category
	right join product on product.category_id = category.id
    where product.id is null;
    
-- ������� ���� �������
select * from product_type where id = 1
-- (�������)
union
select * from product_type where id = 2;


select * from `order`
	left join order_products on order_products.order_id = `order`.id
    left join product on order_products.product_id = product.id
-- (�������)
union

select * from `order`	
	inner join order_products on order_products.order_id = `order`.id
    right join product on order_products.product_id = product.id

-- ������������ �������
use shop;

SELECT * FROM product;
SELECT count(*) FROM product where product.price < 10000;
SELECT sum(price), min(price), max(price)  

-- count(*) - ������� ����� ���-��
-- sum(price) - ����� ��� ������-�� �������
-- ���

SELECT * FROM product;
SELECT count(*) FROM product where product.price < 10000;

-- as total_price - ������������� ������� � ������
SELECT sum(price) as total_price, min(price) as min_price, max(price) as max_price FROM product;
    where `order`.id is null; 

-- ����������
-- https://geekbrains.ru/chapters/1174
-- ����������� ����� �� �������������� ��������
SELECT `order`.user_name, sum(price * `count`) as total_price  from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    group by `order`.user_name;
    
SELECT `order`.user_name, max(price), sum(`count`)  from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    group by `order`.user_name;

-- having - ����������� ��� ������������ �����
SELECT `order`.user_name, max(price), sum(`count`) as order_count from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    -- where user_name like 'В%'
    
    group by `order`.user_name
    having order_count >= 5;

-- ������� ��� ��������� ������ ��
-- https://geekbrains.ru/chapters/1175

-- ����������
select * from `shop`.`user_bank_account`;

start transaction;
	update `shop`.`user_bank_account` set money = money - 100 where id = 1;
    	update `shop`.`user_bank_account` set money = money + 100 where id = 2;
commit;