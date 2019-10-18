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
-- Ограничение вставляемых данных, правило по которому соедены таблицы чтобы главная
-- таблица не содерала id из других таблиц которых не существует
-- https://geekbrains.ru/chapters/1166
ALTER TABLE `shop`.`category` 
ADD CONSTRAINT `fk_brend_product`
FOREIGN KEY (`brand_id`)
REFERENCES `shop`.`category` (`id`)
ON DELETE NO ACTION
UPDATE NO ACTION

-- каскадное удаление -при удалении данных из одной талицы удаляются связанные данные из другой 
https://geekbrains.ru/chapters/1166