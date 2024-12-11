-- Логирование новых пользователей

CREATE TABLE user_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    username VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO user_logs (user_id, username)
    VALUES (NEW.user_id, NEW.username);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_new_user
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION log_new_user();

-- Автообновление статуса бронирования

CREATE OR REPLACE FUNCTION set_default_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status IS NULL THEN
        NEW.status := 'pending';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_default_status
BEFORE INSERT ON reservations
FOR EACH ROW
EXECUTE FUNCTION set_default_status();



