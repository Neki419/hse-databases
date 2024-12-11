-- Переключение на схему hw1
CREATE SCHEMA IF NOT EXISTS hw1;
SET search_path TO hw1;


-- Создание таблицы users
CREATE TYPE user_role AS ENUM ('customer', 'admin');

CREATE TABLE users (
    CONSTRAINT chk_username_length CHECK (LENGTH(username) >= 3 AND LENGTH(username) <= 100),
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role user_role NOT NULL
);

-- Создание таблицы restaurants
CREATE TABLE restaurants (
    CONSTRAINT chk_phone_format CHECK (phone ~ '^\+?[0-9]{10,15}$'),
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

-- Создание таблицы reviews
CREATE TABLE reviews (
    CONSTRAINT chk_comment_length CHECK (LENGTH(comment) <= 1000),
    review_id SERIAL PRIMARY KEY,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы reservations
CREATE TYPE reservation_status AS ENUM ('pending', 'confirmed', 'canceled');

CREATE TABLE reservations (
    CONSTRAINT chk_num_guests_positive CHECK (num_guests > 0),
    reservation_id SERIAL PRIMARY KEY,
    reservation_date TIMESTAMP NOT NULL,
    num_guests INT NOT NULL,
    status reservation_status,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы tables
CREATE TABLE tables (
    CONSTRAINT chk_seats_positive CHECK (seats > 0),
    table_id SERIAL PRIMARY KEY,
    table_number INT NOT NULL,
    seats INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

-- Создание таблицы companies
CREATE TABLE companies (
    CONSTRAINT chk_company_name_length CHECK (LENGTH(name) >= 2 AND LENGTH(name) <= 200),
    company_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Промежуточные таблицы
-- Таблица company_restaurant
CREATE TABLE company_restaurant (
    company_id INT NOT NULL REFERENCES companies(company_id) ON DELETE CASCADE,
    restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    PRIMARY KEY (company_id, restaurant_id)
);

-- Таблица company_user
CREATE TABLE company_user (
    company_id INT NOT NULL REFERENCES companies(company_id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    PRIMARY KEY (company_id, user_id)
);

-- Таблица restaurant_table
CREATE TABLE restaurant_table (
    restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    table_id INT NOT NULL REFERENCES tables(table_id) ON DELETE CASCADE,
    PRIMARY KEY (restaurant_id, table_id)
);

-- Таблица table_reservation
CREATE TABLE table_reservation (
    table_id INT NOT NULL REFERENCES tables(table_id) ON DELETE CASCADE,
    reservation_id INT NOT NULL REFERENCES reservations(reservation_id) ON DELETE CASCADE,
    PRIMARY KEY (table_id, reservation_id)
);

-- Таблица user_reservation
CREATE TABLE user_reservation (
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    reservation_id INT NOT NULL REFERENCES reservations(reservation_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, reservation_id)
);

-- Таблица user_review
CREATE TABLE user_review (
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    review_id INT NOT NULL REFERENCES reviews(review_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, review_id)
);

-- Таблица restaurant_review
CREATE TABLE restaurant_review (
    restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    review_id INT NOT NULL REFERENCES reviews(review_id) ON DELETE CASCADE,
    PRIMARY KEY (restaurant_id, review_id)
);
