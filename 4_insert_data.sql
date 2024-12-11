-- Генерация синтетических данных для тренировок

-- Заполнение таблицы users
INSERT INTO users (username, email, password, phone, role)
VALUES
('Alice', 'alice@example.com', 'password123', '1234567890', 'customer'),
('Bob', 'bob@example.com', 'securepass', '0987654321', 'admin'),
('Charlie', 'charlie@example.com', 'mypassword', '1122334455', 'customer'),
('Diana', 'diana@example.com', 'password456', '2233445566', 'customer'),
('Eve', 'eve@example.com', 'hunter2', '3344556677', 'customer'),
('Frank', 'frank@example.com', 'passw0rd', '4455667788', 'customer'),
('Grace', 'grace@example.com', 'qwerty', '5566778899', 'admin'),
('Hank', 'hank@example.com', 'letmein', '6677889900', 'customer'),
('Ivy', 'ivy@example.com', 'trustno1', '7788990011', 'customer'),
('Jack', 'jack@example.com', 'abc123', '8899001122', 'customer'),
('Karen', 'karen@example.com', 'iloveyou', '9900112233', 'customer');

-- Заполнение таблицы companies
INSERT INTO companies (name, email, phone, address)
VALUES
('TechCorp', 'info@techcorp.com', '1112223333', '123 Tech Street'),
('Foodies Inc.', 'contact@foodies.com', '2223334444', '456 Culinary Road'),
('HealthCare Ltd.', 'support@healthcare.com', '3334445555', '789 Wellness Ave'),
('EcoWorld', 'eco@ecoworld.com', '4445556666', '12 Green Ave'),
('AutoDrive', 'sales@autodrive.com', '5556667777', '56 Drive Blvd'),
('TravelNow', 'contact@travelnow.com', '6667778888', '34 Adventure St'),
('MediaPro', 'info@mediapro.com', '7778889999', '78 Broadcast Ln');

-- Заполнение таблицы restaurants
INSERT INTO restaurants (name, address, phone)
VALUES
('Pizza King', '202 Pizza Blvd', '5556667777'),
('Burger Haven', '303 Burger Way', '6667778888'),
('Sushi Spot', '404 Sushi Street', '7778889999'),
('Vegan Bistro', '505 Plant Ave', '8889990000'),
('Taco Fiesta', '606 Fiesta Rd', '9990001111'),
('BBQ Central', '707 Grill St', '0001112222'),
('Noodle House', '808 Asia Ln', '1112223334'),
('Dessert Corner', '909 Sweet St', '2223334445');

-- Заполнение таблицы reviews
INSERT INTO reviews (rating, comment)
VALUES
(5, 'Excellent food and great service!'),
(4, 'Tasty but a bit expensive.'),
(3, 'Average experience, nothing special.'),
(2, 'Food was cold when served.'),
(5, 'Amazing atmosphere and friendly staff.'),
(4, 'Good food, but service could be faster.'),
(3, 'Decent place, but nothing exceptional.'),
(2, 'Overpriced and underwhelming dishes.'),
(1, 'Very disappointing experience.');

-- Заполнение таблицы reservations
INSERT INTO reservations (reservation_date, num_guests, status)
VALUES
('2024-12-10 18:30:00', 4, 'confirmed'),
('2024-12-11 20:00:00', 2, 'pending'),
('2024-12-12 19:00:00', 6, 'canceled'),
('2024-12-13 21:00:00', 3, 'confirmed'),
('2024-12-14 17:30:00', 5, 'confirmed'),
('2024-12-15 18:45:00', 2, 'pending'),
('2024-12-16 19:15:00', 8, 'confirmed'),
('2024-12-17 20:00:00', 4, 'canceled'),
('2024-12-18 18:00:00', 6, 'pending'),
('2024-12-19 19:30:00', 3, 'confirmed'),
('2024-12-20 21:00:00', 10, 'confirmed');

-- Заполнение таблицы tables
INSERT INTO tables (table_number, seats, is_available)
VALUES
(1, 4, TRUE),
(2, 6, FALSE),
(3, 2, TRUE),
(4, 8, TRUE),
(5, 10, FALSE);

-- Заполнение промежуточных таблиц
INSERT INTO company_restaurant (company_id, restaurant_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

INSERT INTO company_user (company_id, user_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(3, 4);

INSERT INTO restaurant_table (restaurant_id, table_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

INSERT INTO table_reservation (table_id, reservation_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO user_reservation (user_id, reservation_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO user_review (user_id, review_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO restaurant_review (restaurant_id, review_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);
