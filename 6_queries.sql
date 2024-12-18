-- 1. Найти средний рейтинг ресторанов, у которых больше 3 отзывов, и отсортировать по рейтингу
-- Запрос использует GROUP BY + HAVING и ORDER BY
SELECT 
    r.restaurant_id,
    rest.name AS restaurant_name,
    AVG(rev.rating) AS avg_rating,
    COUNT(rev.review_id) AS total_reviews
FROM restaurant_review r
JOIN restaurants rest ON r.restaurant_id = rest.restaurant_id
JOIN reviews rev ON r.review_id = rev.review_id
GROUP BY r.restaurant_id, rest.name
HAVING COUNT(rev.review_id) > 3
ORDER BY avg_rating DESC;
-- Ожидается: список ресторанов с их средним рейтингом, отсортированный от лучшего к худшему.

-- 2. Найти всех пользователей и количество их бронирований, отсортировав по убыванию
-- Запрос использует GROUP BY и ORDER BY
SELECT 
    u.user_id,
    u.username,
    COUNT(r.reservation_id) AS total_reservations
FROM users u
LEFT JOIN user_reservation ur ON u.user_id = ur.user_id
LEFT JOIN reservations r ON ur.reservation_id = r.reservation_id
GROUP BY u.user_id, u.username
ORDER BY total_reservations DESC;
-- Ожидается: список пользователей и количество их бронирований, отсортированный от активных к менее активным.

-- 3. Найти среднее количество гостей на бронирование по статусу
-- Запрос использует GROUP BY и оконные функции
SELECT 
    status,
    AVG(num_guests) OVER (PARTITION BY status) AS avg_guests
FROM reservations
GROUP BY status, num_guests;
-- Ожидается: список статусов бронирований и среднее количество гостей для каждого статуса.

-- 4. Для каждого ресторана определить количество бронирований в статусе 'pending', 'confirmed' и 'canceled'.
-- Запрос использует GROUP BY и HAVING
SELECT 
    rest.restaurant_id,
    rest.name AS restaurant_name,
    COUNT(CASE WHEN r.status = 'pending' THEN 1 ELSE NULL END) AS pending_reservations,
    COUNT(CASE WHEN r.status = 'confirmed' THEN 1 ELSE NULL END) AS confirmed_reservations,
    COUNT(CASE WHEN r.status = 'canceled' THEN 1 ELSE NULL END) AS canceled_reservations
FROM restaurants rest
JOIN restaurant_table rt ON rest.restaurant_id = rt.restaurant_id
JOIN table_reservation tr ON rt.table_id = tr.table_id
JOIN reservations r ON tr.reservation_id = r.reservation_id
GROUP BY rest.restaurant_id, rest.name
ORDER BY pending_reservations DESC;
-- Ожидается: количество каждого статуса бронирования для каждого ресторана.

-- 5. Найти рестораны с общим количеством мест по столикам и доступностью
-- Запрос использует GROUP BY и HAVING
SELECT 
     rest.restaurant_id,
     rest.name AS restaurant_name,
     SUM(t.seats) AS total_seats,
     SUM(CASE WHEN t.is_available THEN t.seats ELSE 0 END) AS available_seats
 FROM restaurant_table rt
 JOIN restaurants rest ON rt.restaurant_id = rest.restaurant_id
 JOIN tables t ON rt.table_id = t.table_id
 GROUP BY rest.restaurant_id, rest.name
 HAVING SUM(t.seats) > 50;
-- Ожидается: список ресторанов с общим количеством мест и доступных мест, где общая вместимость более 50.
