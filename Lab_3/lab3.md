# ЗВІТ З ЛАБОРАТОРНОЇ РОБОТИ №3

## Тема: Маніпулювання даними SQL (OLTP)

### Працювали над лабораторною роботою:
* Копилець Дар'я Сергіївна IО-44
* Савченко Руслана Володимирівна IО-44

### SQL-скрипт(и)

#### SELECT

```sql
-- Вибираємо назви брендів та їхні країни, фільтруючи лише ті, що з Франції
SELECT brand_name, country 
  FROM brand 
 WHERE country = 'Франція';
```
<img width="428" height="210" alt="image" src="https://github.com/user-attachments/assets/8e01b110-1656-476a-a095-eba3a6b18539" />

```sql
-- Отримуємо імена, прізвища та дати народження клієнтів, які народилися після 1 січня 1995 року
SELECT first_name, surname, birthday 
  FROM client 
 WHERE birthday > '1995-01-01';
```

<img width="519" height="201" alt="image" src="https://github.com/user-attachments/assets/1ba819ec-fc8d-4ab9-b095-29b573805ae7" />

```sql
-- Виводимо назви товарів та їхні ціни, відсортовані від найдорожчого до найдешевшого (за спаданням)
SELECT product_name, price 
  FROM products 
 ORDER BY price DESC;
```

<img width="378" height="360" alt="image" src="https://github.com/user-attachments/assets/a88fa5aa-a093-4bbe-a3de-bca8826541b7" />

```sql
-- Отримуємо інформацію про замовлення, які вже мають статус 'Отримано' або 'Доставлено'
SELECT order_id, order_date, order_status 
  FROM order_ 
 WHERE order_status IN ('Отримано', 'Доставлено');
```
<img width="409" height="151" alt="image" src="https://github.com/user-attachments/assets/6aafb96c-9c23-4d49-a393-3509579d8a8b" />

```sql
-- Шукаємо в корзині деталі про товари чорного кольору та розмірів 'M' або 'L'
SELECT product_id, color, size_, price 
  FROM cart 
 WHERE color = 'Black' 
  AND size_ IN ('M', 'L');
```
<img width="672" height="114" alt="image" src="https://github.com/user-attachments/assets/23c72b79-ef38-49ca-824c-20d82a01ab86" />

```sql
-- Об'єднуємо таблиці клієнтів та замовлень (JOIN), щоб побачити ім'я клієнта поруч з датою та статусом його замовлення
SELECT c.first_name, c.surname, o.order_date, o.order_status 
  FROM client c 
 JOIN order_ o ON c.client_id = o.client_id;
```
<img width="664" height="359" alt="image" src="https://github.com/user-attachments/assets/cbfeff31-15f4-41cf-bab5-6c2a19529182" />

```sql
-- Виводимо назву товару разом із зрозумілою назвою його бренду та категорії
SELECT p.product_name, b.brand_name, c.category_name 
  FROM products p 
 JOIN brand b ON p.brand_id = b.brand_id 
 JOIN category c ON p.category_id = c.category_id;
```
<img width="617" height="362" alt="image" src="https://github.com/user-attachments/assets/0ebe639f-a676-486d-96e7-2891fe6d3bb0" />

#### INSERT

```sql
-- Додаємо нового клієнта з його персональними даними до таблиці client
INSERT INTO client (
    first_name, surname, birthday, phone_number, email, address, login, password
) 
VALUES (
    'Артем', 'Сидоренко', '1998-11-05', '380731234567', 'artem.s@example.com', 'Київ, вул. Садова, 12', 'artem_s', 'pass123'
);
```
<img width="1435" height="183" alt="image" src="https://github.com/user-attachments/assets/2af3f2b7-e7c2-47c4-8b85-7efd1e2069a9" />


```sql
-- Додаємо новий бренд 'Burberry' з Великобританії до каталогу
INSERT INTO brand (brand_name, country) 
VALUES ('Burberry', 'Великобританія');
```
<img width="535" height="207" alt="image" src="https://github.com/user-attachments/assets/b92baf2a-f1dd-42f9-bed3-2cbe4b071704" />


```sql
-- Створюємо нове замовлення для клієнта з ID 11 зі статусом 'Підтверджено'
INSERT INTO order_ (
    client_id, order_date, order_status, price_at_the_moment
) 
VALUES (
    11, '2023-10-15', 'Підтверджено', 4500.00
);
```
<img width="683" height="201" alt="image" src="https://github.com/user-attachments/assets/bd33bc95-4d12-4612-9d71-1642b1887790" />


```sql
-- Створюємо нову категорію товарів 'Головні убори'
INSERT INTO category (category_name) 
  VALUES ('Головні убори');
```
<img width="344" height="160" alt="image" src="https://github.com/user-attachments/assets/e930382b-7b66-44d7-95aa-63339df39e0d" />


```sql
-- Додаємо ще один новий бренд 'Ralph Lauren' із США
INSERT INTO brand (brand_name, country) 
  VALUES ('Ralph Lauren', 'США');
```
<img width="528" height="162" alt="image" src="https://github.com/user-attachments/assets/92f3d5e1-5921-4c85-a1b0-65f4f9d15337" />

#### UPDATE

```sql
-- Оновлюємо номер телефону для клієнта Артема, шукаючи його запис за унікальним email
UPDATE client 
  SET phone_number = '380739999999' 
 WHERE email = 'artem.s@example.com';
```
<img width="1177" height="165" alt="image" src="https://github.com/user-attachments/assets/89a03196-bd76-4ab2-b265-a99f93d2f7e5" />

```sql
-- Виправляємо назву країни для бренду 'Burberry'
UPDATE brand 
   SET country = 'Англія' 
 WHERE brand_name = 'Burberry';
```
<img width="558" height="189" alt="image" src="https://github.com/user-attachments/assets/8c2c5bd1-3f15-4a7e-9735-f0280fe35974" />

```sql
-- Змінюємо статус замовлення на 'Відправлено' для клієнта з ID 11
UPDATE order_ 
  SET order_status = 'Відправлено' 
 WHERE client_id = 11;
```
<img width="682" height="143" alt="image" src="https://github.com/user-attachments/assets/9c594cac-cdb8-4737-b0c4-fec0d89cf15a" />

```sql
-- Змінюємо назву категорії з 'Головні убори' на 'Шапки та капелюхи'
UPDATE category 
  SET category_name = 'Шапки та капелюхи' 
 WHERE category_name = 'Головні убори';
```
<img width="357" height="142" alt="image" src="https://github.com/user-attachments/assets/250d8d22-477b-4ad1-b472-37ac8d53e85e" />

```sql
-- Виправляємо назву країни для бренду 'Ralph Lauren'
UPDATE brand 
  SET country = 'Сполучені Штати' 
 WHERE brand_name = 'Ralph Lauren';
```
<img width="543" height="147" alt="image" src="https://github.com/user-attachments/assets/7f6854ac-2fcb-4916-97a0-d02495160e3d" />

```sql
-- Встановлюємо нову ціну для товару з назвою 'Джинси Slim Fit'
UPDATE products 
  SET price = 40000.00 
 WHERE product_name = 'Джинси Slim Fit';
```
<img width="883" height="147" alt="image" src="https://github.com/user-attachments/assets/53d6c327-14aa-4edd-a03e-d76307843a3d" />

```sql
-- Змінюємо кількість замовленого товару на 2 для чорних речей розміру 'S' у корзині
UPDATE cart 
  SET quantity = 2 
 WHERE color = 'Black' 
  AND size_ = 'S';
```
<img width="974" height="148" alt="image" src="https://github.com/user-attachments/assets/84460c10-e4b7-4d8d-a606-4483940a3b3c" />

#### DELETE

```sql
-- Видаляємо з корзини всі рожеві речі розміру 'XS'
DELETE FROM cart 
  WHERE color = 'Pink' 
 AND size_ = 'XS';
```
<img width="977" height="382" alt="image" src="https://github.com/user-attachments/assets/086adfcd-59ef-4bd1-bc53-0f17f1826a4c" />

```sql
-- Видаляємо всі замовлення, які належать клієнту з ID 11
DELETE FROM order_ 
  WHERE client_id = 11;
```
<img width="683" height="381" alt="image" src="https://github.com/user-attachments/assets/5c90e377-a512-4de5-b098-e0d5083b6418" />

```sql
-- Видаляємо клієнта Артема з бази за його email
DELETE FROM client 
  WHERE email = 'artem.s@example.com';
```
<img width="1531" height="383" alt="image" src="https://github.com/user-attachments/assets/182c1564-4eda-4847-8232-1ad8552f59da" />

```sql
-- Видаляємо бренд 'Ralph Lauren' з каталогу
DELETE FROM brand 
  WHERE brand_name = 'Ralph Lauren';
```
<img width="539" height="448" alt="image" src="https://github.com/user-attachments/assets/632f6c06-5834-426a-b495-390682cc0515" />

```sql
-- Видаляємо категорію 'Шапки та капелюхи'
DELETE FROM category 
  WHERE category_name = 'Шапки та капелюхи';
```
<img width="365" height="391" alt="image" src="https://github.com/user-attachments/assets/a557fd0c-96a8-4228-ac39-bf20f63d6dad" />

```sql
-- Видаляємо з корзини всі світло-блакитні речі розміру 'S'
DELETE FROM cart 
  WHERE color = 'LightBlue' 
 AND size_ = 'S';
```
<img width="965" height="378" alt="image" src="https://github.com/user-attachments/assets/8a265503-4416-4088-bc26-c1ab41636f4b" />



