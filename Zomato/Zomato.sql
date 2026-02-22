CREATE TYPE order_status AS ENUM ('placed','preparing','out_for_delivery','delivered','cancelled');

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150),
    phone VARCHAR(20) UNIQUE
);

CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    location TEXT
);

CREATE TABLE menu_items (
    menu_id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants(restaurant_id),
    item_name VARCHAR(150),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    restaurant_id INT REFERENCES restaurants(restaurant_id),
    status order_status DEFAULT 'placed',
    total_amount DECIMAL(10,2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    menu_id INT REFERENCES menu_items(menu_id),
    quantity INT CHECK (quantity > 0)
);

CREATE TABLE delivery_partners (
    delivery_id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    phone VARCHAR(20) UNIQUE
);

CREATE TABLE deliveries (
    delivery_record_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE REFERENCES orders(order_id),
    delivery_id INT REFERENCES delivery_partners(delivery_id),
    delivery_status VARCHAR(50)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    restaurant_id INT REFERENCES restaurants(restaurant_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);