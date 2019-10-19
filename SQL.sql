-- создание базы данных shop
CREATE SCHEMA `shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

-- отобразить все базы данных
show databases;

-- работать с указанной базой данных (после выполнения этой команды вместо `shop`.`category` можно будет писать просто category )
use shop;

-- создание таблицы "категория товаров"
CREATE TABLE `shop`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `discount` TINYINT NOT NULL,
PRIMARY KEY (`id`));

-- добавление нового столбца
ALTER TABLE `shop`.`category` 
ADD COLUMN `alias_name` VARCHAR(128) NULL AFTER `discount`;

-- посмотреть структуру таблицы
SHOW COLUMNS FROM category;

-- удалить таблицу
DROP TABLE `shop`.`category`;

-- удалить базу данных
DROP DATABASE `shop`;

-- удалить значение
DELETE FROM category WHERE id = 5;

-- == SELECT == --
-- вывести все категории товаров
SELECT * FROM category;

-- == WHERE == -- (выборка по определенному значению)
-- вывести категорию товаров с идентификатором, равным 3 (выборка по определенному значению)
SELECT * FROM category WHERE id = 3;

-- вывести категории товаров, у которых скидка не равна 0 (выборка по определенному значению)
SELECT * FROM category WHERE discount <> 0;

-- вывести категории товаров, у которых скидка больше 5 (выборка по определенному значению)
SELECT * FROM category WHERE discount > 5;

-- вывести категории товаров, у которых скидка больше 5 и меньше 15 (выборка по двум определенным значениям)
SELECT * FROM category WHERE (discount > 5) AND (discount < 15);

-- вывести категории товаров, у которых скидка меньше 5 или больше или равен 10 (выборка по двум определенным значениям)
SELECT * FROM category WHERE (discount < 5) OR (discount >= 10);

-- вывести категории товаров, у которых скидка не меньше 5 (выборка по двум определенным значениям)
SELECT * FROM category WHERE NOT (discount < 5);

-- вывести категории товаров, у которых есть псевдоним (выборка по двум определенным значениям)
SELECT * FROM category WHERE alias_name IS NOT NULL;

-- вывести категории товаров, у которых нет псевдонима (выборка по двум определенным значениям)
SELECT * FROM category WHERE alias_name IS NULL;

-- == SELECT <столбец> == -- (выборка по столбцу)
-- вывести названя всех категорий товаров
SELECT name FROM category;

-- вывести названя и скидки товаров (выборка по столбцу)
SELECT discount, name  FROM category;

-- вывести все скидки (выборка по столбцу)
SELECT discount FROM category;

-- выборка данных
-- DISTINCT
-- вывести все уникальные значения скидок (выборка уникальных данных)
SELECT DISTINCT discount FROM category;

-- == ORDER BY == -- (сортировка извлеченных данных)
-- вывести все категории товаров, и отсортировать их по размеру скидки (сортировка извлеченных данных)
SELECT * FROM category ORDER BY discount; -- ASC;

-- вывести все категории товаров, и отсортировать их по размеру скидки в обратном порядке (сортировка извлеченных данных)
SELECT * FROM category ORDER BY discount DESC;

-- вывести все категории товаров с ненулевой скидкой, и отсортировать их по размеру скидки в обратном порядке (сортировка извлеченных данных)
SELECT * FROM category WHERE discount <> 0 ORDER BY discount DESC;

-- == LIMIT == -- (вывод определенного кол-ва)
-- вывести первые 2 категории товара (вывод определенного кол-ва)
SELECT * FROM category LIMIT 2;

-- вывести первые 2 категории товара со скдикой не равной нулю (вывод определенного кол-ва)
SELECT * FROM category WHERE discount <> 0 LIMIT 2;

-- == INSERT == -- (вставить новые данные)
use shop;
-- (вставить новые данные)
INSERT INTO category (id, name, discount, alias_name) VALUES (3, 'Женская обувь', 10, NULL);
-- (вставить новые данные)
INSERT INTO category (id, name, discount, alias_name) VALUES (4, 'Мужская обувь', 15, 'man''s shoes')
-- если id имеет автоинкремент (вставить новые данные)
INSERT INTO category (name, discount) VALUES ('Шляпы', 0);
-- Добавить новый бренд «Тетя Клава Company» (вставить новые данные)
INSERT INTO category (name, discount) VALUES ('Тетя Клава Company', 0);

-- == UPDATE ==-- (обновление данных)
-- обновляет поле у записи с id (обновление данных)
UPDATE category SET name = 'Головные уборы' WHERE id = 5;
-- обновляет поле у записи с диапозоном id (обновление данных)
UPDATE category SET discount = 3 WHERE id IN ( 2 , 5 );

-- С помощью команды UPDATE заполнить alias_name для всех категорий (обновление данных)
UPDATE category set alias_name = 'women''s clothing' WHERE id = 1;
UPDATE category set alias_name = 'man''s clothing' WHERE id = 2;
UPDATE category set alias_name = 'women''s shoes' WHERE id = 3;


-- ==Согласованность данных==
-- Ограничение вставляемых данных, правило по которому соеденены таблицы так чтобы главная таблица не содержала id из других таблиц которых не существует
-- https://geekbrains.ru/chapters/1166
ALTER TABLE `shop`.`category` 
ADD CONSTRAINT `fk_brend_product`
FOREIGN KEY (`brand_id`)
REFERENCES `shop`.`category` (`id`)
ON DELETE NO ACTION
UPDATE NO ACTION

-- каскадное удаление -при удалении данных из одной талицы удаляются связанные данные из другой 
-- https://geekbrains.ru/chapters/1166


--==inner INNER JOIN (Объеденение данных при выборке)
-- https://geekbrains.ru/chapters/1170
-- При выборе данных из таблицы product прикрепляем столбцы из category связыва их по определенным столбцам on product.category_id = category.id; 
select * from product 
	inner join category on product.category_id = category.id;

-- При выборе данных из таблицы product указываем нужные столбцы и прикрепляем столбцы из category связыва их по определенным столбцам on product.category_id = category.id;     
select product.id, price, name from product  
	inner join category on product.category_id = category.id; 

-- объеденение таблиц в обратном порядке сначала категории потом продукты
select * from category  
	 inner join product on product.category_id = category.id;
     
-- объеденение и ограничивание по where
select * from product  
	inner join category on product.category_id = category.id
    where discount <= 5;
    
-- множественное объеденение
select * from product  
	inner join category on product.category_id = category.id 
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id;
    
-- множественное объеденение с указанием столбцов
select product.id, brand.name, product_type.name, category.name, product.price from product  
	inner join category on product.category_id = category.id 
    inner join brand on brand.id = product.brand_id
    inner join product_type on product_type.id = product.product_type_id; 

-- https://geekbrains.ru/chapters/1171
-- объедение слева (в запрос обязаны попасть все данные из таблицы категории)
select * from category
	left join product on product.category_id = category.id;

-- объедение слева    
select * from category
	left join product on product.category_id = category.id
    where product.id is null;

-- объедение справа
select * from category
	right join product on product.category_id = category.id
    where product.id is null;
    
-- склейка двух выводов
select * from product_type where id = 1
-- (склейка)
union
select * from product_type where id = 2;


select * from `order`
	left join order_products on order_products.order_id = `order`.id
    left join product on order_products.product_id = product.id
-- (склейка)
union

select * from `order`	
	inner join order_products on order_products.order_id = `order`.id
    right join product on order_products.product_id = product.id

-- АГРЕГИРУЮЩИЕ ФУНКЦИИ
use shop;

SELECT * FROM product;
SELECT count(*) FROM product where product.price < 10000;
SELECT sum(price), min(price), max(price)  

-- count(*) - СКОЛЬКО ВСЕГО КОЛ-ВО
-- sum(price) - сумма для какого-то столбца
-- итд

SELECT * FROM product;
SELECT count(*) FROM product where product.price < 10000;

-- as total_price - переменование столбца в выводе
SELECT sum(price) as total_price, min(price) as min_price, max(price) as max_price FROM product;
    where `order`.id is null; 

-- ГРУПИРОВКА
-- https://geekbrains.ru/chapters/1174
-- группировка строк по повторяющемуся значению
SELECT `order`.user_name, sum(price * `count`) as total_price  from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    group by `order`.user_name;
    
SELECT `order`.user_name, max(price), sum(`count`)  from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    group by `order`.user_name;

-- having - ограничения для сгрупировных даных
SELECT `order`.user_name, max(price), sum(`count`) as order_count from `order` 
	inner join order_products on order_products.order_id = `order`.id
    inner join product on product.id = order_products.product_id
    -- where user_name like 'Р’%'
    
    group by `order`.user_name
    having order_count >= 5;

-- ИНДЕКСЫ ДЛЯ УСКОРЕНИЯ РАБОТЫ бд
-- https://geekbrains.ru/chapters/1175

-- ТРАНЗАКЦИИ
select * from `shop`.`user_bank_account`;

start transaction;
	update `shop`.`user_bank_account` set money = money - 100 where id = 1;
    	update `shop`.`user_bank_account` set money = money + 100 where id = 2;
commit;