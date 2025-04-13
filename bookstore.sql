-- Create database bookstore
CREATE DATABASE bookstore;

USE bookstore;

-- Create table for book language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- Create table for publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(30)
);

-- Create table for books
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_date DATE,
    price DECIMAL(10, 2) NOT NULL,
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Create table for authors
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

-- Create table for book_author as junction table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Create table for customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(20),
    email VARCHAR(50) NOT NULL UNIQUE,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create table for address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50),
    country_id INT
);

-- Create table for country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50)
);

-- Create table for address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(25) NOT NULL
);

-- Create table for customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Create table for order status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Create table for cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_address_id INT,
    order_total DECIMAL(10, 2),
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Create table for shipping_method
CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- Create table for order_history
CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Create table for order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Insert supported languages for the bookstore.
-- Includes English and Swahili.
INSERT INTO book_language (language_id, language_name)
VALUES 
(1, 'English'),
(2, 'Swahili');

-- Insert publisher details including name, email, and phone number.
-- These represent various Kenyan and international publishers.
INSERT INTO publisher (publisher_id, first_name, last_name, email, phone)
VALUES 
(1, 'East', 'African', 'info@eafrica.com', '+254701234567'),
(2, 'SA', 'Books', 'contact@sabooks.co.za', '+27123456789'),
(3, 'Global', 'Press', 'support@globalpress.com', '+442071234567'),
(4, 'Story', 'House', 'hello@storyhouse.com', '+12125551234'),
(5, 'Swahili', 'Writers', 'contact@swahiliwriters.co.ke', '+254701234568');

-- Add books to the bookstore.
-- Includes title, publication date, price, publisher_id, and language_id used
INSERT INTO book (book_id, title, publication_date, price, publisher_id, language_id)
VALUES 
(1, 'Les Misérables', '1862-01-01', 24.97, 5, 1),
(2, 'Chozi la Heri', '2010-04-10', 21.01, 5, 2),
(3, 'Cry, the Beloved Country', '1948-01-01', 7.83, 4, 1),
(4, 'Nairobi Heat', '2009-09-15', 18.50, 1, 1),
(5, 'Facing Mount Kenya', '1938-01-01', 15.30, 1, 1),
(6, 'Siku Njema', '1996-05-01', 12.40, 5, 2),
(7, 'Disgrace', '1999-01-01', 13.75, 2, 1),
(8, 'Long Walk to Freedom', '1994-11-12', 14.60, 2, 1),
(9, 'Blossoms of the Savannah', '2008-01-01', 10.99, 1, 1),
(10, 'The River and The Source', '1994-01-01', 11.70, 1, 1),
(11, '1984', '1949-06-08', 9.99, 3, 1),
(12, 'To Kill a Mockingbird', '1960-07-11', 10.50, 3, 1),
(13, 'One Hundred Years of Solitude', '1967-05-30', 11.95, 3, 1),
(14, 'The Alchemist', '1988-01-01', 8.80, 3, 1),
(15, 'The Little Prince', '1943-04-06', 7.90, 3, 1),
(16, 'The Kite Runner', '2003-05-29', 12.75, 3, 1),
(17, 'Pride and Prejudice', '1813-01-28', 9.40, 3, 1),
(18, 'Born a Crime', '2016-11-15', 13.99, 2, 1),
(19, 'Utengano', '1980-01-01', 10.30, 5, 2),
(20, 'Chozi la Heri', '2010-04-10', 14.60, 5, 2);

-- Insert a list of unique authors into the 'author' table.
-- Each author gets a unique author_id and their full name is stored.
INSERT INTO author (author_id, author_name)
VALUES 
(1, 'Victor Hugo'),
(2, 'Assumpta K. Matei'),
(3, 'Alan Paton'),
(4, 'Mukoma wa Ngugi'),
(5, 'Jomo Kenyatta'),
(6, 'Ken Walibora'),
(7, 'J.M. Coetzee'),
(8, 'Nelson Mandela'),
(9, 'Henry Ole Kulet'),
(10, 'Margaret Ogola'),
(11, 'George Orwell'),
(12, 'Harper Lee'),
(13, 'Gabriel Garcia Marquez'),
(14, 'Paulo Coelho'),
(15, 'Antoine de Saint-Exupéry'),
(16, 'Khaled Hosseini'),
(17, 'Jane Austen'),
(18, 'Trevor Noah'),
(19, 'Said A. Mohamed');

-- Create links between books and authors in a many-to-many relationship.
-- Each entry references a specific book_id and author_id
INSERT INTO book_author (book_id, author_id)
VALUES 
(1, 1),   -- Les Misérables - Victor Hugo
(2, 2),   -- Chozi la Heri - Assumpta K. Matei
(3, 3),   -- Cry, the Beloved Country - Alan Paton
(4, 4),   -- Nairobi Heat - Mukoma wa Ngugi
(5, 5),   -- Facing Mount Kenya - Jomo Kenyatta
(6, 6),   -- Siku Njema - Ken Walibora
(7, 7),   -- Disgrace - J.M. Coetzee
(8, 8),   -- Long Walk to Freedom - Nelson Mandela
(9, 9),   -- Blossoms of the Savannah - Henry Ole Kulet
(10, 10), -- The River and The Source - Margaret Ogola
(11, 11), -- 1984 - George Orwell
(12, 12), -- To Kill a Mockingbird - Harper Lee
(13, 13), -- One Hundred Years of Solitude - Gabriel Garcia Marquez
(14, 14), -- The Alchemist - Paulo Coelho
(15, 15), -- The Little Prince - Antoine de Saint-Exupéry
(16, 16), -- The Kite Runner - Khaled Hosseini
(17, 17), -- Pride and Prejudice - Jane Austen
(18, 18), -- Born a Crime - Trevor Noah
(19, 19), -- Utengano - Said A. Mohamed
(20, 2);  -- Chozi la Heri (again) - Assumpta K. Matei

-- Insert sample customers into the database.
-- Each customer has a name, phone, email, and registration date.
INSERT INTO customer (customer_id, first_name, last_name, phone_number, email, registration_date)
VALUES 
(1, 'Daniel', 'Wamithi', '+254792619410', 'daniel1@example.com', '2024-05-18 10:19:07'),
(2, 'Samuel', 'Njoroge', '+254751506110', 'samuel2@example.com', '2024-10-14 10:19:07'),
(3, 'Joseph', 'Odhiambo', '+254789188897', 'joseph3@example.com', '2025-02-12 10:19:07'),
(4, 'Mary', 'Kariuki', '+254759123456', 'mary4@example.com', '2023-11-20 08:30:00'),
(5, 'Fatma', 'Mutua', '+254758654321', 'fatma5@example.com', '2024-01-15 09:45:30'),
(6, 'Peter', 'Muthoni', '+254757777777', 'peter6@example.com', '2024-03-22 14:15:00'),
(7, 'Zainab', 'Ochieng', '+254756888888', 'zainab7@example.com', '2023-06-11 17:40:00'),
(8, 'Wanjiru', 'Odhiambo', '+254755999999', 'wanjiru8@example.com', '2024-07-05 11:00:00');


-- User accounts and roles
-- Create 'admin' user
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_1234';
GRANT ALL PRIVILEGES ON bookstore.* TO 'admin'@'localhost';

-- Create 'sales' user with limited privileges
CREATE USER 'sales'@'localhost' IDENTIFIED BY 'sales_1234';
GRANT SELECT ON bookstore.* TO 'sales'@'localhost';
GRANT INSERT, UPDATE ON bookstore.customer_address TO 'sales'@'localhost';
GRANT INSERT, UPDATE ON bookstore.customer TO 'sales'@'localhost';
GRANT INSERT, UPDATE ON bookstore.cust_order TO 'sales'@'localhost';
GRANT INSERT, UPDATE ON bookstore.order_line TO 'sales'@'localhost';
GRANT INSERT, UPDATE ON bookstore.order_history TO 'sales'@'localhost';
GRANT INSERT, UPDATE ON bookstore.shipping_method TO 'sales'@'localhost';

-- Create 'inventory' user for managing book and author data
CREATE USER 'inventory'@'localhost' IDENTIFIED BY 'inventory_1234';
GRANT SELECT ON bookstore.* TO 'inventory'@'localhost';
GRANT INSERT, UPDATE, DELETE ON bookstore.book TO 'inventory'@'localhost';
GRANT INSERT, UPDATE, DELETE ON bookstore.book_author TO 'inventory'@'localhost';
GRANT INSERT, UPDATE, DELETE ON bookstore.author TO 'inventory'@'localhost';
GRANT INSERT, UPDATE, DELETE ON bookstore.publisher TO 'inventory'@'localhost';

-- Create 'user_view' user for read-only access
CREATE USER 'user_view'@'localhost' IDENTIFIED BY 'user_1234';
GRANT SELECT ON bookstore.* TO 'user_view'@'localhost';
