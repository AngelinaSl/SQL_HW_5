USE HW_4_ultraplus;

-- Получите друзей пользователя с id=1
-- (решение задачи с помощью представления “друзья”)

CREATE OR REPLACE VIEW friends_1
AS
SELECT initiator_user_id AS "friends(id_1)"
FROM friend_requests
WHERE target_user_id = 1 AND status = "approved"
UNION SELECT target_user_id
FROM friend_requests
WHERE initiator_user_id = 1 AND status = "approved";

SELECT * 
FROM friends_1;

-- Создайте представление, в котором будут выводится все сообщения, в которых принимал
-- участие пользователь с id = 1.

CREATE OR REPLACE VIEW msg_1 
AS
SELECT id, body AS "msg"
FROM messages
WHERE from_user_id = 1 OR to_user_id = 1;

SELECT *
FROM msg_1;

-- Получите список медиафайлов пользователя с количеством лайков(media m, likes l ,users u)

-- количество лайков
CREATE OR REPLACE VIEW likes1 
AS  
SELECT l.media_id, COUNT(l.media_id) AS likes FROM likes l
GROUP BY l.media_id;

SELECT * 
FROM likes1;


CREATE OR REPLACE VIEW users_likes AS
SELECT CONCAT(u.firstname, " ", u.lastname) AS "username",  m.filename, IFNULL(l.likes, "0") AS likes
FROM media m
LEFT JOIN llikes l
ON l.media_id = m.id
JOIN users u 
ON u.id = m.user_id
ORDER BY user_id;

SELECT * 
FROM users_likes;

-- Получите количество групп у пользователей

CREATE OR REPLACE VIEW community 
AS
SELECT uc.user_id, COUNT(community_id) AS count_community
FROM users_communities uc
GROUP BY uc.user_id;

SELECT * 
FROM community;

SELECT CONCAT(u.firstname, " ", u.lastname) AS "name", c.count_community
FROM users u
LEFT JOIN community c
ON c.user_id = u.id;

-- Вывести 3 пользователей с наибольшим количеством лайков за медиафайлы

SELECT username, sum(likes) AS	 sum_likes
FROM users_likes
GROUP BY username
ORDER BY sum_likes DESC
LIMIT 3;



