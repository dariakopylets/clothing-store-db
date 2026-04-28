DROP TABLE IF EXISTS Product_Catalog_Denorm ;
DROP TABLE IF EXISTS Order_Info_Denorm ;

CREATE TABLE Product_Catalog_Denorm (
    product_id serial PRIMARY KEY,
    product_name varchar(32) NOT NULL,
    price decimal(10,2) NOT NULL,
    model varchar(32) NOT NULL,
    brand_name varchar(32) NOT NULL,
    brand_country varchar(32) NOT NULL,
    category_name varchar(32) NOT NULL 
);

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
