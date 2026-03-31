# Звіт лабораторної роботи №4

## Частина 1: Базова агрегація

Запит 1.1: Використовує COUNT(DISTINCT client_id) для підрахунку загальної кількості унікальних клієнтів у таблиці client.

```sql
SELECT COUNT(DISTINCT client_id) as total_clients
 FROM client;
```
<img width="142" height="69" alt="4_1 1" src="https://github.com/user-attachments/assets/db613ea0-25e4-45ac-8144-433ee12d153c" />

Запит 1.2: Використовує COUNT(*) для підрахунку загальної кількості всіх замовлень, зафіксованих у таблиці order_.

```sql
SELECT COUNT(*) as total_orders
 FROM order_;
```
<img width="139" height="67" alt="4_1 2" src="https://github.com/user-attachments/assets/bb4ec4bc-ec1c-4597-941d-1f5291745109" />

Запит 1.3: Використовує SUM() для обчислення загальної суми вартості всіх товарів, доданих у корзину (таблиця cart).

```sql
SELECT SUM(price * quantity) as total_cart_value
 FROM cart;
```
<img width="160" height="68" alt="4_1 3" src="https://github.com/user-attachments/assets/d4cd9397-b1c3-4d28-9124-ae68c2013b49" />

Запит 1.4: Використовує AVG() та ROUND() для розрахунку середньої ціни товару у таблиці products.

```sql
SELECT ROUND(AVG(price), 2) as average_product_price
 FROM products;
```
<img width="196" height="64" alt="4_1 4" src="https://github.com/user-attachments/assets/61362b12-9e7d-4749-970d-ce50ec5817c1" />

Запит 1.5: Використовує MIN() для знаходження найстарішої дати народження клієнта (найстаршого клієнта) у системі.

```sql
SELECT MIN(birthday) as oldest_client
 FROM client;
```
<img width="143" height="65" alt="4_1 5" src="https://github.com/user-attachments/assets/7030fdf3-1f02-4293-bf91-63d80890a0ae" />

Запит 1.6: Використовує MAX() для знаходження найбільшої ціни товару у каталозі.

```sql
SELECT MAX(price) as highest_price
 FROM products;
```
<img width="149" height="68" alt="4_1 6" src="https://github.com/user-attachments/assets/c5895f9a-0667-4334-825b-13cfe80a540b" />

## Частина 2: Групування даних (GROUP BY)

Запит 2.1: Використовує GROUP BY order_status та COUNT(order_id) для групування замовлень за статусами та підрахунку їх кількості.

```sql
SELECT order_status, COUNT(order_id) as num_orders
  FROM order_
 GROUP BY order_status;
```
<img width="237" height="215" alt="4_2 1" src="https://github.com/user-attachments/assets/d4d1c147-4fe4-4bc3-a3aa-04255754c680" />

Запит 2.2: Використовує GROUP BY brand_id для групування товарів за ідентифікатором бренду та підрахунку кількості товарів.

```sql
SELECT brand_id, COUNT(product_id) as num_products
  FROM products
 GROUP BY brand_id
ORDER BY num_products DESC;
```
<img width="225" height="287" alt="4_2 2" src="https://github.com/user-attachments/assets/c770be05-d2cf-4d90-b251-6668767f6161" />

Запит 2.3: Групування товарів у корзині за розміром та підрахунок кількості проданих одиниць для кожного розміру.

```sql
SELECT size_, COUNT(*) as size_count
  FROM cart
 GROUP BY size_;
```
<img width="280" height="162" alt="4_2 3" src="https://github.com/user-attachments/assets/52229ed3-fcf0-4515-9b3a-bdfa0c07ae2e" />

## Частина 3: Фільтрування груп (HAVING)

Запит 3.1: Знайти клієнтів, які зробили більше ніж 1 замовлення.

```sql
SELECT client_id, COUNT(*) as orders_made_count
  FROM order_
 GROUP BY client_id
HAVING COUNT(*) > 1;

```
<img width="254" height="77" alt="4_3 1" src="https://github.com/user-attachments/assets/213228a4-0bf8-4f54-822e-4f507b96b262" />

(Таких клієнтів немає.)

Запит 3.2: Знайти розміри товарів, які додані в корзину 2 або більше разів.

```sql
SELECT size_, COUNT(*) as size_popularity
  FROM cart
 GROUP BY size_
HAVING COUNT(*) >= 2;
```
<img width="301" height="113" alt="4_3 2" src="https://github.com/user-attachments/assets/c2627097-cc3c-4526-b3db-8fdf6511535a" />

## Частина 4: Запити JOIN

Запит 4.1: Показати імена клієнтів та дати їхніх замовлень за допомогою INNER JOIN.

```sql
SELECT c.first_name as client_name, c.surname as client_surname, o.order_date
  FROM client as c
 INNER JOIN order_ o ON c.client_id = o.client_id;
```
<img width="426" height="289" alt="4_4 1" src="https://github.com/user-attachments/assets/6d017c9b-f2b4-466e-ac73-c2593dc4faea" />

Запит 4.2: Показати всі бренди та назви їхніх товарів за допомогою LEFT JOIN.

```sql
SELECT b.brand_name, b.country, p.product_name
  FROM brand as b
 LEFT JOIN products p ON b.brand_id = p.brand_id;
```
<img width="486" height="338" alt="4_4 2" src="https://github.com/user-attachments/assets/e918609c-3cbe-48a9-bb8e-1f7cadf90d45" />

Запит 4.3: Показати всі товари та назви категорій за допомогою RIGHT JOIN.

```sql
SELECT p.product_name, c.category_name
  FROM category as c
 RIGHT JOIN products p ON c.category_id = p.category_id;
```
<img width="343" height="286" alt="4_4 3" src="https://github.com/user-attachments/assets/83250468-ba00-4882-b537-2fb3ecd9b930" />

Запит 4.4: Створити список комбінацій брендів та категорій за допомогою CROSS JOIN.

```sql
SELECT b.brand_name, c.category_name
  FROM brand as b
 CROSS JOIN category as c;
```
<img width="329" height="481" alt="4_4 4" src="https://github.com/user-attachments/assets/86a5990d-3f47-4ac2-9246-42b0c716363b" />

## Частина 5: Багатотаблична агрегація

Запит 5.1: Знайти загальну суму покупок для кожного клієнта.

```sql
SELECT c.first_name, c.surname, SUM(cr.price * cr.quantity) as total_spent
  FROM client as c
 JOIN order_ o ON c.client_id = o.client_id
 JOIN cart cr ON o.order_id = cr.order_id
GROUP BY c.client_id, c.first_name, c.surname
ORDER BY total_spent DESC;
```
<img width="427" height="232" alt="4_5 1" src="https://github.com/user-attachments/assets/e58e89bf-37e4-493c-b037-cda221f2922f" />

Запит 5.2: Порахувати, скільки товарів з кожної категорії було додано в корзину.

```sql
SELECT cat.category_name, COUNT(cr.cart_id) as times_in_cart
  FROM category as cat
 JOIN products p ON cat.category_id = p.category_id
 JOIN cart cr ON p.product_id = cr.product_id
GROUP BY cat.category_id, cat.category_name
ORDER BY times_in_cart DESC;
```
<img width="292" height="238" alt="4_5 2" src="https://github.com/user-attachments/assets/db484018-d601-43e6-890f-812a674e29e4" />

## Частина 6: Підзапити

Запит 6.1: Знайти клієнтів, які замовили товар "Шовкова спідниця" (підзапит у WHERE).

```sql
SELECT first_name, surname
  FROM client
 WHERE client_id IN ( 
    SELECT client_id
    FROM order_
    WHERE order_id IN (
        SELECT order_id
        FROM cart
        WHERE product_id = (
            SELECT product_id
            FROM products
            WHERE product_name = 'Шовкова спідниця'
        )
    )
);
```
<img width="337" height="64" alt="4_6 1" src="https://github.com/user-attachments/assets/9ce48d92-f773-4d62-9400-2e5c06e2ae1e" />

Запит 6.2: Показати кожного клієнта та загальну кількість його замовлень (підзапит у SELECT).

```sql
SELECT c.first_name, c.surname,
    (SELECT COUNT(*) 
	 FROM order_ as o 
	 WHERE o.client_id = c.client_id) as total_orders
FROM client as c;
```
<img width="438" height="289" alt="4_6 2" src="https://github.com/user-attachments/assets/7a66473c-ff93-4604-a1a4-ead697eded60" />

Запит 6.3: Знайти середню кількість товарів у замовленні (підзапит у FROM).

```sql
SELECT AVG(items_in_order) as avg_items_per_order
FROM ( SELECT order_id, COUNT(*) as items_in_order
       FROM cart
       GROUP BY order_id
) as order_stats;
```<img width="186" height="64" alt="4_6 3" src="https://github.com/user-attachments/assets/62538f71-b52f-4381-a0d9-e9e403e6d236" />

