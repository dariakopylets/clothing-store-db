DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS order_ ;
DROP TABLE IF EXISTS brand;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS client;
DROP TYPE IF EXISTS order_status;
DROP TYPE IF EXISTS payment_status;
DROP TYPE IF EXISTS payment_type;
CREATE TYPE order_status as ENUM ('Доставлено', 'Підтверджено', 'Відправлено', 'Отримано', 'Скасовано', 'Оплачено', 'Повернуто');
CREATE TYPE payment_status as ENUM ('Оплачено', 'Не оплачено', 'В обробці');
CREATE TYPE payment_type as ENUM ('ApplePay', 'GooglePay', 'Готівкою при отриманні', 'LiqPay', 'PayPal');

CREATE TABLE client (
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

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name varchar(32) NOT NULL
); 

CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name varchar(32) NOT NULL,
    country varchar(32) NOT NULL
);

CREATE TABLE order_ (
    order_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES client(client_id),
    order_date date NOT NULL, 
    order_status order_status NOT NULL, 
    price_at_the_moment decimal(10,2) NOT NULL CHECK(price_at_the_moment > 0) 
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name varchar(32) NOT NULL,
    price decimal(10,2) NOT NULL CHECK(price > 0),
    model varchar(32) NOT NULL,
    brand_id INT NOT NULL REFERENCES brand(brand_id),
    category_id INT NOT NULL REFERENCES category(category_id)
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES order_(order_id),
    payment_type payment_type NOT NULL, 
    payment_status payment_status NOT NULL 
);

CREATE TABLE cart (
    cart_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id),
    order_id INT NOT NULL REFERENCES order_(order_id),
    price decimal(10,2) NOT NULL CHECK(price > 0),
    color varchar(10) NOT NULL,
    size_ varchar(15) NOT NULL,
    quantity int NOT NULL CHECK(quantity > 0) 
);

INSERT INTO client (first_name, surname, birthday, phone_number, email, address, login, password) VALUES
('Олександр', 'Шевченко', '1990-05-15', '380501234561', 'alex.sh@example.com', 'Київ, вул. Хрещатик, 1', 'alex_sh', 'hash1'),
('Марія', 'Коваленко', '1985-11-22', '380671234562', 'maria.k@example.com', 'Львів, пл. Ринок, 5', 'masha_k', 'hash2'),
('Іван', 'Бойко', '2000-01-10', '380631234563', 'ivan.b@example.com', 'Одеса, вул. Дерибасівська, 10', 'ivan_b', 'hash3'),
('Анна', 'Ткаченко', '1998-08-30', '380991234564', 'anna.t@example.com', 'Дніпро, пр. Яворницького, 20', 'anna_t', 'hash4'),
('Дмитро', 'Кравченко', '1992-12-05', '380501234565', 'dima.k@example.com', 'Харків, вул. Сумська, 15', 'dima_k', 'hash5'),
('Олена', 'Лисенко', '1995-03-18', '380671234566', 'olena.l@example.com', 'Запоріжжя, пр. Соборний, 30', 'olena_l', 'hash6'),
('Віктор', 'Мельник', '1988-07-25', '380631234567', 'viktor.m@example.com', 'Вінниця, вул. Соборна, 8', 'viktor_m', 'hash7'),
('Наталія', 'Мороз', '1999-09-12', '380991234568', 'nata.m@example.com', 'Івано-Франківськ, вул. Незалежності, 3', 'nata_m', 'hash8'),
('Сергій', 'Вовк', '1983-02-14', '380501234569', 'serg.v@example.com', 'Тернопіль, вул. Руська, 12', 'serg_v', 'hash9'),
('Юлія', 'Павленко', '2001-06-20', '380671234570', 'yulia.p@example.com', 'Чернівці, вул. Головна, 25', 'yulia_p', 'hash10');

INSERT INTO category (category_name) VALUES
('Джинси'), ('Спідниці'), ('Футболки'), ('Сукні'), ('Куртки'),
('Светри'), ('Худі'), ('Шорти'), ('Пальта'), ('Сорочки');

INSERT INTO brand (brand_name, country) VALUES
('Gucci', 'Італія'), ('Prada', 'Італія'), ('Balenciaga', 'Франція'),
('Louis Vuitton', 'Франція'), ('Dior', 'Франція'), ('Chanel', 'Франція'),
('Hermes', 'Франція'), ('Versace', 'Італія'), ('Armani', 'Італія'),
('Tom Ford', 'США');

INSERT INTO order_ (client_id, order_date, order_status, price_at_the_moment) VALUES
(1, '2023-10-01', 'Отримано', 35000.00),
(2, '2023-10-02', 'Відправлено', 45000.00),
(3, '2023-10-03', 'Підтверджено', 53000.00),
(4, '2023-10-04', 'Доставлено', 120000.00),
(5, '2023-10-05', 'Скасовано', 25000.00),
(6, '2023-10-06', 'Оплачено', 85000.00),
(7, '2023-10-07', 'Повернуто', 42000.00),
(8, '2023-10-08', 'Отримано', 145000.00),
(9, '2023-10-09', 'Відправлено', 54000.00),
(10, '2023-10-10', 'Підтверджено', 25000.00);

INSERT INTO products (product_name, price, model, brand_id, category_id) VALUES
('Джинси Slim Fit', 35000.00, 'Slim-01', 8, 1),
('Шовкова спідниця', 45000.00, 'Silk-Midi', 1, 2),
('Брендова футболка', 28000.00, 'Logo-T', 4, 3),
('Джинси Vintage', 42000.00, 'Vint-OG', 5, 1),
('Оверсайз худі', 35000.00, 'Oversize-BB', 3, 7),
('Вечірня сукня', 120000.00, 'Night-Dress', 2, 4),
('Шкіряна куртка', 85000.00, 'Leather-J', 9, 5),
('Кашемірове пальто', 110000.00, 'Cashmere-Coat', 7, 9),
('Твідова спідниця', 54000.00, 'Tweed-02', 6, 2),
('Класична сорочка', 25000.00, 'Classic-Fit', 10, 10);

INSERT INTO payment (order_id, payment_type, payment_status) VALUES
(1, 'ApplePay', 'Оплачено'),
(2, 'LiqPay', 'В обробці'),
(3, 'Готівкою при отриманні', 'Не оплачено'),
(4, 'GooglePay', 'Оплачено'),
(5, 'PayPal', 'Не оплачено'),
(6, 'ApplePay', 'Оплачено'),
(7, 'LiqPay', 'Оплачено'),
(8, 'Готівкою при отриманні', 'В обробці'),
(9, 'GooglePay', 'Оплачено'),
(10, 'PayPal', 'В обробці');

INSERT INTO cart (product_id, order_id, price, color, size_, quantity) VALUES
(1, 1, 35000.00, 'Blue', 'M', 1),
(2, 2, 45000.00, 'Red', 'S', 1),
(3, 3, 28000.00, 'White', 'L', 1),
(10, 3, 25000.00, 'Black', 'M', 1),
(6, 4, 120000.00, 'Black', 'S', 1),
(10, 5, 25000.00, 'White', 'XL', 1),
(7, 6, 85000.00, 'Black', 'L', 1),
(4, 7, 42000.00, 'LightBlue', 'S', 1),
(5, 8, 35000.00, 'Black', 'Oversize', 1),
(8, 8, 110000.00, 'Beige', 'M', 1),
(9, 9, 54000.00, 'Green', 'L', 1),
(10, 10, 25000.00, 'Pink', 'XS', 1);
