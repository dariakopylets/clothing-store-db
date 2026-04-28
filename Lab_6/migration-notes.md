# Лабораторна робота №6
## Тема: Міграції
## Мета: Використати Prisma ORM для керування схемами та дослідити, як Prisma може аналізувати та змінювати схему вашої бази даних.

## 1. Міграція add-review-table
Було створено нову таблицю `Review` для зберігання відгуків користувачів про товари. Також було налаштовано зв'язок "один-до-багатьох" між моделями `products` та `Review` (один товар може мати багато відгуків).

**schema.prisma:**
```prisma
// Додано нову модель Review
model Review {
  review_id  Int      @id @default(autoincrement())
  rating     Int
  comment    String?
  product_id Int
  products   products @relation(fields: [product_id], references: [product_id])
}
// До моделі products додано зв'язок
model products {
  product_id   Int      @id @default(autoincrement())
  product_name String   @db.VarChar(32)
  price        Decimal  @db.Decimal(10, 2)
  brand_id     Int
  category_id  Int
  reviews      Review[] // Додано поле
}
```

**migration.sql:**

```sql
-- Створення таблиці
CREATE TABLE "Review" (
    "review_id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "product_id" INTEGER NOT NULL,
    CONSTRAINT "Review_pkey" PRIMARY KEY ("review_id")
);
-- Додавання зовнішнього ключа
ALTER TABLE "Review" ADD CONSTRAINT "Review_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("product_id") ON DELETE RESTRICT ON UPDATE CASCADE;
```

## 2. Міграція add-is-available
До існуючої таблиці товарів (products) було додано нове логічне поле is_available, яке за замовчуванням має значення true. Це дозволяє відстежувати наявність товару в магазині.

**schema.prisma:**
```prisma
model products {
  product_id   Int      @id @default(autoincrement())
  product_name String   @db.VarChar(32)
  price        Decimal  @db.Decimal(10, 2)
  brand_id     Int
  category_id  Int
  is_available Boolean  @default(true) // Додано нове поле
  reviews      Review[]
  cart         cart[]
  brand        brand    @relation(fields: [brand_id], references: [brand_id], onDelete: NoAction, onUpdate: NoAction)
  category     category @relation(fields: [category_id], references: [category_id], onDelete: NoAction, onUpdate: NoAction)
}
```

**migration.sql:**
```sql
-- AlterTable
ALTER TABLE "products" ADD COLUMN "is_available" BOOLEAN NOT NULL DEFAULT true;
```

## 3. Міграція remove-model-column
З моделі products було видалено стовпець model (модель товару), оскільки він більше не потрібен для бізнес-логіки магазину.

**schema.prisma:**
```prisma
model products {
  product_id   Int      @id @default(autoincrement())
  product_name String   @db.VarChar(32)
  price        Decimal  @db.Decimal(10, 2)
  brand_id     Int
  category_id  Int
  // Поле model успішно видалено з цієї структури
  is_available Boolean  @default(true)
  reviews      Review[]
}
```

**migration.sql:**
```sql
-- AlterTable
ALTER TABLE "products" DROP COLUMN "model";
```
## 4. Результати перевірки (Prisma Studio)

Для перевірки коректності застосованих міграцій було використано інтерфейс **Prisma Studio**. 

**1. Перевірка створення таблиці Review:**

У нову таблицю успішно додано запис відгуку, який пов'язаний із товаром (`product_id: 1`).

<img width="1266" height="228" alt="image" src="https://github.com/user-attachments/assets/c93477c1-6e4c-43d3-bc6e-c2eb98da41ae" />


**2. Перевірка зміни таблиці products:**

Як видно на знімку екрана нижче, у таблиці товарів успішно з'явилося нове поле `is_available` зі значенням `true` за замовчуванням. Також можна переконатися, що поле `model` було успішно видалено зі структури бази даних.

<img width="333" height="479" alt="image" src="https://github.com/user-attachments/assets/7568cbd3-e316-4946-ab3c-643279d02987" />

<img width="2428" height="596" alt="image" src="https://github.com/user-attachments/assets/f793407e-5ee4-4d7f-bf83-1cc6e0a9d3f5" />





