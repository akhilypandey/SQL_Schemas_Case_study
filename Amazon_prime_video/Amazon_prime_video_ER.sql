CREATE TYPE subscription_status AS ENUM ('active','expired','cancelled');

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150),
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plans (
    plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR(100),
    price DECIMAL(10,2),
    duration_months INT
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    plan_id INT REFERENCES plans(plan_id),
    start_date DATE,
    end_date DATE,
    status subscription_status DEFAULT 'active'
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) UNIQUE
);

CREATE TABLE content (
    content_id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    description TEXT,
    release_year INT,
    genre_id INT REFERENCES genres(genre_id)
);

CREATE TABLE watch_history (
    history_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    content_id INT REFERENCES content(content_id),
    watched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    content_id INT REFERENCES content(content_id),
    rating INT CHECK (rating BETWEEN 1 AND 5)
);