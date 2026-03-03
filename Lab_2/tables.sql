CREATE TYPE order_status AS ENUM ('Доставлено', 'Підтверджено', 'Відправлено', 'Отримано', 'Скасовано', 'Оплачено', 'Повернуто');
CREATE TYPE payment_status AS ENUM ('Оплачено', 'Не оплачено', 'В обробці');
CREATE TYPE payment_type AS ENUM ('ApplePay', 'GooglePay', 'Готівкою при отриманні', 'LiqPay', 'PayPal');

CREATE TABLE IF NOT EXISTS client (
    client_id SERIAL PRIMARY KEY,
    first_name varchar(25) NOT NULL,
    surname varchar(32) NOT NULL,
    birthday date NOT NULL,
    phone_number char(12) NOT NULL,
    email varchar(64) UNIQUE NOT NULL,
    address varchar(128) NOT NULL,
    login varchar(15) UNIQUE NOT NULL,
    password varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS category (
    category_id SERIAL PRIMARY KEY,
    category_name varchar(32) NOT NULL
); 

CREATE TABLE IF NOT EXISTS brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name varchar(32) NOT NULL,
    country varchar(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS order_ (
    order_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES client(client_id),
    order_date date NOT NULL, 
    order_status order_status NOT NULL, 
    price_at_the_moment decimal(10,2) NOT NULL CHECK(price_at_the_moment > 0) 
);

CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name varchar(32) NOT NULL,
    price decimal(10,2) NOT NULL CHECK(price > 0),
    model varchar(32) NOT NULL,
    brand_id INT NOT NULL REFERENCES brand(brand_id),
    category_id INT NOT NULL REFERENCES category(category_id)
);

CREATE TABLE IF NOT EXISTS payment (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES order_(order_id),
    payment_type payment_type NOT NULL, 
    payment_status payment_status NOT NULL 
);

CREATE TABLE IF NOT EXISTS cart (
    cart_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id),
    order_id INT NOT NULL REFERENCES order_(order_id),
    price decimal(10,2) NOT NULL CHECK(price > 0),
    color varchar(10) NOT NULL,
    size_ varchar(15) NOT NULL,
    quantity int NOT NULL CHECK(quantity > 0) 
);
