
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

