-- Добавление нового ресторана

CREATE OR REPLACE PROCEDURE add_new_restaurant(
    restaurant_name VARCHAR,
    restaurant_address VARCHAR,
    restaurant_phone VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO restaurants (name, address, phone)
    VALUES (restaurant_name, restaurant_address, restaurant_phone);
END;
$$;

-- Добавление новой компании с имеющимися ресторанами

CREATE OR REPLACE PROCEDURE add_company_with_restaurants(
    p_company_name TEXT,
    p_email TEXT,
    p_phone TEXT,
    p_address TEXT,
    p_restaurant_ids INT[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    company_id INT;
    restaurant_id INT;
BEGIN
    -- 1. Создаём новую компанию
    INSERT INTO companies (name, email, phone, address)
    VALUES (p_company_name, p_email, p_phone, p_address)
    RETURNING company_id INTO company_id;

    -- 2. Привязываем рестораны к новой компании
    FOREACH restaurant_id IN ARRAY p_restaurant_ids LOOP

        IF EXISTS (SELECT 1 FROM restaurants WHERE restaurant_id = restaurant_id) THEN
            INSERT INTO company_restaurant (company_id, restaurant_id)
            VALUES (company_id, restaurant_id);
        ELSE
            RAISE NOTICE 'Restaurant ID % does not exist, skipping.', restaurant_id;
        END IF;
    END LOOP;

    RAISE NOTICE 'Company % added with % restaurants.', p_company_name, ARRAY_LENGTH(p_restaurant_ids, 1);
END;
$$;


