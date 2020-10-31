/* 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/
use shop;

SELECT name FROM users where id in
(Select distinct(user_id) from orders)

/* 2. Выведите список товаров products и разделов catalogs, который соответствует товару.*/
use shop;

SELECT 
p.Name as 'Товар'
, p.description as 'Описание'
, p.price as 'Цена'
,  c.name as 'Раздел каталога'
FROM products p
left join catalogs c on c.id = p.catalog_id;


/* 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.*/
use avia;

Select c.Name as 'Вылет из', s.Name as 'Прибытие в'
From flights f, cities c, cities s
Where c.label = f.from
and s.label = f.to
order by f.id;
