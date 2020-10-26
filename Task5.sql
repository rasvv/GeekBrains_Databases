/*Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»*/

use shop;

/*1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/

update users set created_at = now(), updated_at = now() where created_at is null and updated_at is null;


/*2. Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

ALTER TABLE users 
CHANGE created_at created_at DATETIME,
CHANGE updated_at updated_at DATETIME;


/*3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако нулевые запасы должны выводиться в конце, после всех*/

select * from storehouses_products
ORDER BY 
IF(value > 0,  1,  0) DESC,
value ASC;


/*4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)*/

SELECT * FROM users
Where monthname(birthday_at) in ('may', 'august');


/*5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/

SELECT * FROM catalogs 
WHERE id IN (5, 1, 2)
ORDER BY CASE id 
WHEN 5 THEN 1 
WHEN 1 THEN 2 
WHEN 2 THEN 3 
END ASC;



/*=======================================================================================================================================================================*/
/*Практическое задание теме «Агрегация данных»*/


/*1. Подсчитайте средний возраст пользователей в таблице users.*/

SELECT ROUND(
	AVG(
		TIMESTAMPDIFF(YEAR, birthday_at, NOW())
	),
2) as AVG_AGE 
FROM shop.users;


/*2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

/*Сначала функцией CONCAT() создаю дату дня рождения в этом году. Перевожу в дату STR_TO_DATE(). С помощью DATE_FORMAT() извлекаю день недели*/

Select Us.DoW, Count(DoW)  From(
SELECT DATE_FORMAT(STR_TO_DATE(CONCAT(YEAR(Now()),'-', Month(birthday_at),'-', Day(birthday_at)), '%Y-%m-%d'),'%W') as DoW FROM shop.users) as Us
GROUP BY Us.DoW; 
  
  
/*3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.*/

SELECT exp(SUM(log(price))) as proizv FROM shop.products;





