INSERT INTO restaurants (name, address, phone)
VALUES ('The Gourmet Place', '101 Food Lane', '4445556666');

INSERT INTO reviews (rating, comment)
VALUES (1, 'Terrible service, will not return.');

SELECT r.comment, r.rating, r.comment
FROM reviews AS r;

SELECT r.restaurant_id, r.name
FROM restaurants AS r;

UPDATE companies
SET phone = '2221113333'
WHERE company_id = 1;

UPDATE restaurants
SET name = 'Pizza Paradise'
WHERE restaurant_id = 1;

DELETE FROM reviews WHERE rating < 4;

DELETE FROM users WHERE username LIKE 'A%';

