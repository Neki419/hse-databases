-- 1. Лучшие рестораны (средняя оценка больше 4.5)
CREATE OR REPLACE VIEW views.best_restaurants AS
SELECT
    rest.restaurant_id,
    rest.name AS restaurant_name,
    AVG(rev.rating) AS avg_rating,
    COUNT(rev.review_id) AS total_reviews
FROM restaurants rest
JOIN restaurant_review rr ON rest.restaurant_id = rr.restaurant_id
JOIN reviews rev ON rr.review_id = rev.review_id
GROUP BY rest.restaurant_id
HAVING AVG(rev.rating) > 4.5;

-- 2. Топ-3 компании с наибольшим количеством ресторанов
CREATE OR REPLACE VIEW views.top_companies AS
SELECT
    c.company_id,
    c.name AS company_name,
    COUNT(cr.restaurant_id) AS total_restaurants
FROM companies c
JOIN company_restaurant cr ON c.company_id = cr.company_id
GROUP BY c.company_id
ORDER BY total_restaurants DESC
LIMIT 3;

-- 3. Рестораны с общей вместимостью более 50 мест
CREATE OR REPLACE VIEW views.high_capacity_restaurants AS
SELECT
    rest.restaurant_id,
    rest.name AS restaurant_name,
    SUM(t.seats) AS total_capacity
FROM restaurants rest
JOIN restaurant_table rt ON rest.restaurant_id = rt.restaurant_id
JOIN tables t ON rt.table_id = t.table_id
GROUP BY rest.restaurant_id
HAVING SUM(t.seats) > 50;
