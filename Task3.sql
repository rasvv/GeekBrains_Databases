/*Задача 3*/
/*Написать cкрипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)*/

use vk;

/*Таблица типов знаковых мест: Детский сад; школа; институт; работа; секция; кружок; танцевальная студия; Музыкальная группа и т.д.*/
-- Если такая таблица есть, то удаляем
drop table if exists place_types;
-- создаем таблицу
create table place_types(
	id serial primary key,
    name varchar(150) not null
);

/* Знаковые места*/
drop table if exists places;
create table places(
	id serial primary key,
    name varchar(150) not null, -- название заведения
    sub_name varchar(100),	-- уточнение. Например № Группы в институте
    type_id bigint unsigned not null,
    date_beg date, -- дата поступления
    date_end date -- дата окончания
);

/* Таблица "Многие ко многим" - привязка пользователей и знаковых мест */
drop table if exists users_places;
create table users_places(
	user_id bigint unsigned not null,
	place_id bigint unsigned not null,
	primary key(user_id, place_id),
    foreign key (user_id) references users(id) on update cascade on delete cascade,
    foreign key (place_id) references places(id) on update cascade on delete cascade
);