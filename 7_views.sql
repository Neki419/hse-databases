-- Создание схемы для представлений
CREATE SCHEMA IF NOT EXISTS views;

-- Представление для таблицы users
CREATE OR REPLACE VIEW views.users_view AS
SELECT
    username,
    CONCAT(SUBSTRING(email FROM 1 FOR POSITION('@' IN email) - 1), '****', SUBSTRING(email FROM POSITION('@' IN email))) AS email_masked,
    CONCAT('******', SUBSTRING(phone FROM LENGTH(phone) - 3 FOR 4)) AS phone_masked,
    role,
    created_at
FROM hw1.users;

-- Представление для таблицы restaurants
CREATE OR REPLACE VIEW views.restaurants_view AS
SELECT
    name,
    address,
    CONCAT('****', SUBSTRING(phone FROM LENGTH(phone) - 3 FOR 4)) AS phone_masked
FROM hw1.restaurants;

-- Представление для таблицы reviews
CREATE OR REPLACE VIEW views.reviews_view AS
SELECT
    rating,
    CASE
        WHEN LENGTH(comment) > 50 THEN CONCAT(SUBSTRING(comment FROM 1 FOR 50), '...')
        ELSE comment
    END AS comment_short,
    created_at
FROM hw1.reviews;

-- Представление для таблицы reservations
CREATE OR REPLACE VIEW views.reservations_view AS
SELECT
    reservation_date,
    num_guests,
    status
FROM hw1.reservations;

-- Представление для таблицы tables
CREATE OR REPLACE VIEW views.tables_view AS
SELECT
    table_number,
    seats,
    is_available
FROM hw1.tables;

-- Представление для таблицы companies
CREATE OR REPLACE VIEW views.companies_view AS
SELECT
    name,
    CONCAT(SUBSTRING(email FROM 1 FOR POSITION('@' IN email) - 1), '****', SUBSTRING(email FROM POSITION('@' IN email))) AS email_masked,
    CONCAT('******', SUBSTRING(phone FROM LENGTH(phone) - 3 FOR 4)) AS phone_masked,
    address
FROM hw1.companies;
