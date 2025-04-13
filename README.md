# Bookstore Database System

## Overview
This SQL database system provides a complete solution for managing bookstore operations, including inventory, customers, orders, and shipping. The database is designed to support both physical and online bookstore needs with comprehensive tables and relationships.

## Database Structure
```mermaid
[%% Database Schema Diagram for Bookstore
erDiagram
    book_language ||--o{ book : "1:N"
    book_language {
        INT language_id PK
        VARCHAR(50) language_name
    }
    
    publisher ||--o{ book : "1:N"
    publisher {
        INT publisher_id PK
        VARCHAR(25) first_name
        VARCHAR(25) last_name
        VARCHAR(50) email
        VARCHAR(30) phone
    }
    
    book ||--o{ book_author : "1:N"
    book {
        INT book_id PK
        VARCHAR(255) title
        DATE publication_date
        DECIMAL(10,2) price
        INT publisher_id FK
        INT language_id FK
    }
    
    author ||--o{ book_author : "1:N"
    author {
        INT author_id PK
        VARCHAR(100) author_name
    }
    
    book_author }|--|| book : "M:1"
    book_author }|--|| author : "M:1"
    book_author {
        INT book_id PK,FK
        INT author_id PK,FK
    }
    
    customer ||--o{ cust_order : "1:N"
    customer {
        INT customer_id PK
        VARCHAR(50) first_name
        VARCHAR(50) last_name
        VARCHAR(20) phone_number
        VARCHAR(50) email
        DATETIME registration_date
    }
    
    customer ||--o{ customer_address : "1:N"
    address ||--o{ customer_address : "1:N"
    address_status ||--o{ customer_address : "1:1"
    
    customer_address }|--|| customer : "M:1"
    customer_address }|--|| address : "M:1"
    customer_address }|--|| address_status : "M:1"
    customer_address {
        INT customer_id PK,FK
        INT address_id PK,FK
        INT status_id FK
    }
    
    address ||--o{ country : "N:1"
    address {
        INT address_id PK
        VARCHAR(100) street
        VARCHAR(50) city
        INT country_id FK
    }
    
    country {
        INT country_id PK
        VARCHAR(50) country_name
    }
    
    address_status {
        INT status_id PK
        VARCHAR(25) status_name
    }
    
    cust_order ||--o{ order_line : "1:N"
    cust_order ||--o{ order_history : "1:N"
    cust_order {
        INT order_id PK
        INT customer_id FK
        DATETIME order_date
        INT shipping_address_id
        DECIMAL(10,2) order_total
        INT status_id FK
    }
    
    order_status ||--o{ cust_order : "1:N"
    order_status ||--o{ order_history : "1:N"
    order_status {
        INT status_id PK
        VARCHAR(50) status_name
    }
    
    order_history {
        INT order_history_id PK
        INT order_id FK
        INT status_id FK
        DATETIME status_date
    }
    
    order_line }|--|| cust_order : "M:1"
    order_line }|--|| book : "M:1"
    order_line {
        INT order_id PK,FK
        INT book_id PK,FK
        INT quantity
        DECIMAL(10,2) price
    }
    
    shipping_method {
        INT method_id PK
        VARCHAR(50) method_name
        DECIMAL(10,2) cost
    }]
```

### Core Tables

#### Book Management
- **book_language**: Stores available languages (English, Swahili)
- **publisher**: Contains publisher details (name, contact info)
- **book**: Main inventory with titles, prices, publication dates
- **author**: Author information
- **book_author**: Junction table for book-author relationships

#### Customer Management
- **customer**: Customer profiles with contact details
- **address**: Physical address storage
- **country**: Supported countries
- **address_status**: Address types (Home, Work, etc.)
- **customer_address**: Customer-address relationships

#### Order Processing
- **order_status**: Order lifecycle states
- **cust_order**: Order headers
- **shipping_method**: Delivery options
- **order_history**: Order status changes
- **order_line**: Order details with book quantities

## Sample Data Included

### Books (50+ titles)
- Classic literature ("Les Misérables", "1984")
- African literature ("Long Walk to Freedom", "Blossoms of the Savannah")
- Swahili titles ("Chozi la Heri", "Siku Njema")

### Authors (30+)
- International authors (Victor Hugo, George Orwell)
- African authors (Ngũgĩ wa Thiong'o, Chinua Achebe)
- Kenyan authors (Margaret Ogola, Henry Ole Kulet)

### Customers
- 8 sample customer profiles with complete contact information
- Multiple address types per customer

### Orders
- Sample orders in various statuses (Pending, Shipped, Delivered)
- Detailed order line items with quantities and prices

## User Roles and Permissions

| Role | Permissions | Description |
|------|-------------|-------------|
| admin | ALL PRIVILEGES | Full database access |
| sales | SELECT + limited INSERT/UPDATE | Customer and order management |
| inventory | SELECT + INSERT/UPDATE/DELETE on book-related tables | Inventory management |
| user_view | SELECT only | Read-only reporting access |

## Example Queries

### 1. Get all books by a specific author
```sql
SELECT b.title, b.price 
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id 
JOIN author a ON ba.author_id = a.author_id
WHERE a.author_name = 'Ngũgĩ wa Thiong'o';
```

### 2. View customer order history
```sql
SELECT c.first_name, c.last_name, o.order_date, 
       SUM(ol.quantity * ol.price) AS order_total
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_line ol ON o.order_id = ol.order_id
GROUP BY o.order_id;
```

### 3. Find pending orders
```sql
SELECT o.order_id, c.first_name, c.last_name, o.order_date
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.status_id = 1; -- Pending status
```

## Setup Instructions

1. Create the database:
```sql
CREATE DATABASE bookstore;
USE bookstore;
```

2. Execute the provided SQL script to:
   - Create all tables
   - Establish relationships
   - Insert sample data
   - Configure user roles

3. Verify setup by running test queries

## Maintenance Notes

1. **Backup Recommendations**
   - Daily backups of critical tables (book, customer, cust_order)
   - Weekly full database backups

2. **Performance Tips**
   - Add indexes on frequently queried columns
   - Consider partitioning the order_history table

3. **Security**
   - Regularly review user permissions
   - Implement password rotation policies

## Support
For assistance with this database system:
- Email: adelewigitz@gmail.com
- Phone: +254 711527211

Conclusion
This bookstore database system is designed to be a flexible and scalable solution for managing the operations of a bookstore. Whether for small local bookstores or larger online bookstores, this schema can easily be adapted to meet the needs of any organization.

