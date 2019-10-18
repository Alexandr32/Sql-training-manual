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
-- ����������� ����������� ������, ������� �� �������� ������� ������� ����� �������
-- ������� �� �������� id �� ������ ������ ������� �� ����������
-- https://geekbrains.ru/chapters/1166
ALTER TABLE `shop`.`category` 
ADD CONSTRAINT `fk_brend_product`
FOREIGN KEY (`brand_id`)
REFERENCES `shop`.`category` (`id`)
ON DELETE NO ACTION
UPDATE NO ACTION

-- ��������� �������� -��� �������� ������ �� ����� ������ ��������� ��������� ������ �� ������ 
https://geekbrains.ru/chapters/1166