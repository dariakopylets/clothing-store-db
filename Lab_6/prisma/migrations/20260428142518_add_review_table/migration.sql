-- CreateEnum
CREATE TYPE "order_status" AS ENUM ('Доставлено', 'Підтверджено', 'Відправлено', 'Отримано', 'Скасовано', 'Оплачено', 'Повернуто');

-- CreateEnum
CREATE TYPE "payment_status" AS ENUM ('Оплачено', 'Не оплачено', 'В обробці');

-- CreateEnum
CREATE TYPE "payment_type" AS ENUM ('ApplePay', 'GooglePay', 'Готівкою при отриманні', 'LiqPay', 'PayPal');

-- CreateTable
CREATE TABLE "brand" (
    "brand_id" SERIAL NOT NULL,
    "brand_name" VARCHAR(32) NOT NULL,
    "country" VARCHAR(32) NOT NULL,

    CONSTRAINT "brand_pkey" PRIMARY KEY ("brand_id")
);

-- CreateTable
CREATE TABLE "cart" (
    "cart_id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "color" VARCHAR(10) NOT NULL,
    "size_" VARCHAR(15) NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "cart_pkey" PRIMARY KEY ("cart_id")
);

-- CreateTable
CREATE TABLE "category" (
    "category_id" SERIAL NOT NULL,
    "category_name" VARCHAR(32) NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "client" (
    "client_id" SERIAL NOT NULL,
    "first_name" VARCHAR(25) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "birthday" DATE NOT NULL,
    "phone_number" CHAR(12) NOT NULL,
    "email" VARCHAR(64) NOT NULL,
    "address" VARCHAR(128) NOT NULL,
    "login" VARCHAR(15) NOT NULL,
    "password" VARCHAR(100) NOT NULL,

    CONSTRAINT "client_pkey" PRIMARY KEY ("client_id")
);

-- CreateTable
CREATE TABLE "order_" (
    "order_id" SERIAL NOT NULL,
    "client_id" INTEGER NOT NULL,
    "order_date" DATE NOT NULL,
    "order_status" "order_status" NOT NULL,
    "price_at_the_moment" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "order__pkey" PRIMARY KEY ("order_id")
);

-- CreateTable
CREATE TABLE "products" (
    "product_id" SERIAL NOT NULL,
    "product_name" VARCHAR(32) NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "model" VARCHAR(32) NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("product_id")
);

-- CreateTable
CREATE TABLE "payment" (
    "payment_id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "payment_type" "payment_type" NOT NULL,
    "payment_status" "payment_status" NOT NULL,

    CONSTRAINT "payment_pkey" PRIMARY KEY ("payment_id")
);

-- CreateTable
CREATE TABLE "Review" (
    "review_id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "product_id" INTEGER NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("review_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "client_email_key" ON "client"("email");

-- CreateIndex
CREATE UNIQUE INDEX "client_login_key" ON "client"("login");

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order_"("order_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("product_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "order_" ADD CONSTRAINT "order__client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client"("client_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "brand"("brand_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "category"("category_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order_"("order_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("product_id") ON DELETE RESTRICT ON UPDATE CASCADE;
