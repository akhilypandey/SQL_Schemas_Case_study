CREATE TYPE booking_status AS ENUM ('confirmed','completed','cancelled');

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150),
    email VARCHAR(150) UNIQUE
);

CREATE TABLE hosts (
    host_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE REFERENCES users(user_id)
);

CREATE TABLE listings (
    listing_id SERIAL PRIMARY KEY,
    host_id INT REFERENCES hosts(host_id),
    title VARCHAR(200),
    location TEXT,
    price_per_night DECIMAL(10,2)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    listing_id INT REFERENCES listings(listing_id),
    start_date DATE,
    end_date DATE,
    total_price DECIMAL(10,2),
    status booking_status DEFAULT 'confirmed'
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id INT UNIQUE REFERENCES bookings(booking_id),
    amount DECIMAL(10,2),
    payment_status VARCHAR(50)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    booking_id INT UNIQUE REFERENCES bookings(booking_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);