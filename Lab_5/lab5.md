# Нормалізація бази даних магазину одягу

Усі таблиці, які створені у фінальному SQL-скрипті (файл `new.sql`), вже перебувають у 3NF. Для демонстрації процесу нормалізації нижче наведено шлях перетворення з гіпотетичної денормалізованої версії БД (файл `old.sql`).

---

## 1. Початковий денормалізований варіант та його аналіз

**Найвища нормальна форма початкової схеми:** Ненормалізована форма (UNF / 0NF). Схема не досягає навіть 1NF через наявність неатомарних/дубльованих даних у категоріях.

### Денормалізована таблиця `Product_Catalog_Denorm`
Зберігає інформацію про товари, їхні бренди та категорії в одному місці.

```sql
CREATE TABLE Product_Catalog_Denorm (
    product_id serial PRIMARY KEY,
    product_name varchar(32) NOT NULL,
    price decimal(10,2) NOT NULL,
    model varchar(32) NOT NULL,
    brand_name varchar(32) NOT NULL,
    brand_country varchar(32) NOT NULL,
    category_name varchar(32) NOT NULL 
);
```

**Функціональні залежності (ФЗ):**
* `{product_id} -> {product_name, price, model, brand_name, brand_country, category_name}` *(Основна ФЗ)*
* `{brand_name} -> {brand_country}` *(Транзитивна залежність)*

**Порушення нормальних форм:**
* **Порушення 1NF/2NF:** Категорії та бренди дублюються текстовими значеннями, що створює надмірність.
* **Порушення 3NF:** Атрибут `brand_country` залежить від неключового атрибута `brand_name`.

### Денормалізована таблиця `Order_Info_Denorm`
Зберігає дані про замовлення разом із повними даними клієнта.

```sql
CREATE TABLE Order_Info_Denorm (
    order_id serial PRIMARY KEY,
    order_date date NOT NULL,
    order_status varchar(20) NOT NULL,
    price_at_the_moment decimal(10,2) NOT NULL,
    client_login varchar(15) NOT NULL,
    first_name varchar(25) NOT NULL,
    surname varchar(32) NOT NULL,
    birthday date NOT NULL,
    phone_number char(12) NOT NULL,
    email varchar(64) NOT NULL,
    address varchar(128) NOT NULL,
    password varchar(100) NOT NULL
);
```

**Функціональні залежності (ФЗ):**
* `{order_id} -> {order_date, order_status, price_at_the_moment, client_login, first_name, surname, birthday, phone_number, email, address, password}` *(Основна ФЗ)*
* `{client_login} -> {first_name, surname, birthday, phone_number, email, address, password}` *(Транзитивна залежність)*

**Порушення нормальних форм:**
* **Порушення 3NF:** Усі персональні дані клієнта залежать від його логіна, а не безпосередньо від номера замовлення (`order_id`).

---

## 2. Покрокова нормалізація

### Крок 1: Перехід до Першої нормальної форми (1NF)

**Мета:** Усунути дублювання текстових даних категорій та забезпечити атомарність.

**Дія:** Створюємо окрему таблицю для категорій (доменник) і додаємо зовнішній ключ до таблиці товарів.

**Результат:**
* **`category`** (Нова таблиця): `category_id` (PK), `category_name`
* **`Product_1NF`**: `product_id` (PK), `product_name`, `price`, `model`, `brand_name`, `brand_country`, `category_id` (FK)

```sql
-- Створення нової таблиці для категорій
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name varchar(32) NOT NULL
);

-- Зміна оригінальної таблиці
ALTER TABLE Product_Catalog_Denorm DROP COLUMN category_name;
ALTER TABLE Product_Catalog_Denorm ADD COLUMN category_id INT REFERENCES category(category_id);
```

### Крок 2: Перехід до Другої нормальної форми (2NF)

**Мета:** Усунути часткові залежності.

**Дія:** Оскільки в наших таблицях використовуються прості (одинарні) первинні ключі (`product_id` та `order_id`), часткових залежностей не існує. 
**Висновок:** Схема автоматично задовольняє вимоги 2NF.

### Крок 3: Перехід до Третьої нормальної форми (3NF)

**Мета:** Усунути транзитивні залежності.

**Проблема 1: Таблиця `Product_1NF`** Залежність: `product_id -> brand_name -> brand_country`

**Виправлення:** Виносимо інформацію про бренд в окрему таблицю.

* **`brand`** (Нова таблиця): `brand_id` (PK), `brand_name`, `country`
* **`products`** (Оновлена таблиця): `product_id` (PK), `product_name`, `price`, `model`, `brand_id` (FK), `category_id` (FK)

```sql
CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name varchar(32) NOT NULL,
    country varchar(32) NOT NULL
);

ALTER TABLE Product_Catalog_Denorm DROP COLUMN brand_name;
ALTER TABLE Product_Catalog_Denorm DROP COLUMN brand_country;
ALTER TABLE Product_Catalog_Denorm ADD COLUMN brand_id INT REFERENCES brand(brand_id);
ALTER TABLE Product_Catalog_Denorm RENAME TO products;
```

**Проблема 2: Таблиця `Order_Info_Denorm`** Залежність: `order_id -> client_login -> дані клієнта`
**Виправлення:** Виносимо дані клієнта в окрему таблицю.

* **`client`** (Нова таблиця): `client_id` (PK), `first_name`, `surname`, `birthday`, `phone_number`, `email`, `address`, `login`, `password`
* **`order_`** (Оновлена таблиця): `order_id` (PK), `order_date`, `order_status`, `price_at_the_moment`, `client_id` (FK)

```sql
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

ALTER TABLE Order_Info_Denorm DROP COLUMN client_login, DROP COLUMN first_name, DROP COLUMN surname, DROP COLUMN birthday, DROP COLUMN phone_number, DROP COLUMN email, DROP COLUMN address, DROP COLUMN password;
ALTER TABLE Order_Info_Denorm ADD COLUMN client_id INT REFERENCES client(client_id);
ALTER TABLE Order_Info_Denorm RENAME TO order_;
```
---

## 3. Оновлена ER-діаграма

<img width="1244" height="684" alt="image" src="https://github.com/user-attachments/assets/a47f5ee7-7922-4e0b-8c69-b131724b7961" />
