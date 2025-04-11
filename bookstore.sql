
--create database bookstore;
create database bookstore;

-- create table for books with the following fields:
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_date DATE,
    price DECIMAL(10, 2) NOT NULL,
    publisher_id INT,
    language_id INT
    );

    -- create table for authors with the following fields:

CREATE TABLE book_author (
    book_id INT primary key,
    authorName Varchar(50)
    );

-- create table for book author:

CREATE TABLE book_author(
    author_id INT,
    book_id INT,
    author_name VARCHAR(50),
    PRIMARY KEY(author_id, book_id)
    );
 -- create table for customer with the following fields:
create table customer(
customer_id int primary key auto_increment,
first_name varchar (50),
last_name varchar (50),
phone_number VARCHAR(20),
email varchar (50) NOT NULL UNIQUE, 
registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
--INSERT INTO customer(first_name, last_name, phone_number,email) VALUES ("Daniel", "Wamithi", +254759851627, "danielwainaina588@gmail.com");
--select * from customer;

-- create table for customer address with the following fields:
CREATE TABLE customer_address(
customer_id INT,
address_id INT,
status_id INT,
PRIMARY KEY(customer_id, address_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

--SELECT * FROM customer_address;

-- create table for address with the following fields:
CREATE TABLE address(
address_id INT AUTO_INCREMENT PRIMARY KEY,
street VARCHAR (100),
city VARCHAR(50),
country_id INT
);

-- add foreign key to customer_address table
ALTER TABLE customer_address 
ADD FOREIGN KEY (address_id) REFERENCES address(address_id);

-- create table for country with the following fields:
CREATE TABLE country (
country_id INT PRIMARY KEY AUTO_INCREMENT,
country_name VARCHAR (50)
);

-- add foreign key to address table 
ALTER TABLE address 
ADD FOREIGN KEY (country_id) REFERENCES country(country_id);


-- create table for address status with the following fields:
CREATE TABLE address_status(
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(25) NOT NULL
);

-- add foreign key to customer_address table
ALTER TABLE customer_address
ADD FOREIGN KEY(status_id) REFERENCES address_status(status_id);

-- create table for book status with the following fields:
CREATE TABLE cust_order(
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
shipping_address_id INT,
order_total DECIMAL(10, 2),
status_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- create table for order status with the following fields:
CREATE TABLE order_status(
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50) NOT NULL
);

-- add foreign key to cust_order table
ALTER TABLE cust_order
ADD FOREIGN KEY (status_id) REFERENCES order_status(status_id);

-- create table for order status with the following fields:
CREATE TABLE shippig_method(
method_id INT PRIMARY KEY AUTO_INCREMENT,
method_name VARCHAR (50) NOT NULL,
cost DECIMAL (10, 2 ) NOT NULL
);

/*ALTER TABLE cust_order
--ADD FOREIGN KEY(method_id) REFERENCES shipping_method(method_id);*/

 -- create table for order history with the following fields:
 CREATE TABLE order_history(
 order_history_id INT AUTO_INCREMENT PRIMARY KEY,
 order_id INT,
 status_id INT,
 status_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
 FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
 );
 
 -- create table order_line
 CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
    );