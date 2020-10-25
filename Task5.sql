use vk;

/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/


update users set created_at = now(), updated_at = now() where created_at is null and updated_at is null;

select * from users;


/* Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

ALTER TABLE users 
CHANGE created_at created_at DATETIME,
CHANGE updated_at updated_at DATETIME;

/*В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако нулевые запасы должны выводиться в конце, после всех*/

select * from users where is_deleted >0 order by id 
union
select * from users where is_deleted =0 order by id;