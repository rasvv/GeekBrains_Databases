/*1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.*/

/* Этот запрос выводит только друга, который больше всего с пользователем общается  */

Select user_id, sum(mes) from
(SELECT m_to.to_user_id as user_id, Count(m_to.body) as mes FROM vk.messages  as m_to
WHERE m_to.from_user_id = 1
group by m_to.to_user_id
union
SELECT m_from.from_user_id as user_id, Count(m_from.body) as mes FROM vk.messages as m_from
WHERE m_from.to_user_id = 1
group by m_from.from_user_id) as sel
group by user_id

having user_id in 
(
  SELECT user_id
  FROM profiles as sel2
  WHERE user_id IN (
	  SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved'
	  union
	  SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' 
  ) )
  order by sum(mes) desc
  limit 1;
  
  /* Чтобы найти просто человека, который больше всего с пользователем общается, получим такой запрос */

Select user_id, sum(mes) from
(SELECT m_to.to_user_id as user_id, Count(m_to.body) as mes FROM vk.messages  as m_to
WHERE m_to.from_user_id = 1
group by m_to.to_user_id
union
SELECT m_from.from_user_id as user_id, Count(m_from.body) as mes FROM vk.messages as m_from
WHERE m_from.to_user_id = 1
group by m_from.from_user_id) as sel
group by user_id
  order by sum(mes) desc
  limit 1;
  
  
  
  
/*2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/

/*Сначала ищем всех пользователей моложе 10 лет. Затем находим медиа, которые они загружали. После суммируем количество набранных лайков*/

Select sum(id) as likes  from likes where media_id in
(Select id from media where user_id in
(Select user_id from profiles
where TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10)); 


/*3. Определить кто больше поставил лайков (всего): мужчины или женщины.*/


/*Сначала выбираем все записи из лайков. Потом смотрим какому полу соответствуют user_id из  */
Select count(user_id) as likes, 	
    CASE (gender)
         WHEN 'm' THEN 'мужчины'
         WHEN 'f' THEN 'женщины'
         ELSE 'другой'
    END AS gender 
from profiles
where user_id in (Select user_id from likes)
group by gender 
order by likes DESC; 

/*Можно в конец добавить limit 1, чтобы оставить только "победителей"*/


