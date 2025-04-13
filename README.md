# Bookstore Database System

## Overview
This SQL database system provides a complete solution for managing bookstore operations, including inventory, customers, orders, and shipping. The database is designed to support both physical and online bookstore needs with comprehensive tables and relationships.

## Database Structure
```erDiagram
    book_language {
        int language_id
        varchar(50) language_name
        PRIMARY KEY
    }
    publisher {
        int publisher_id
        varchar(25) first_name
        varchar(25) last_name
        varchar(50) email
        varchar(30) phone
        PRIMARY KEY
    }
    book {
        int book_id
        varchar(255) title
        date publication_date
        decimal(10,2) price
        int publisher_id
        int language_id
        PRIMARY KEY
    }
    author {
        int author_id
        varchar(100) author_name
        PRIMARY KEY
    }
    book_author {
        int book_id
        int author_id
        PRIMARY KEY
    }
    customer {
        int customer_id
        varchar(50) first_name
        varchar(50) last_name
        varchar(20) phone_number
        varchar(50) email
        datetime registration_date
        PRIMARY KEY
    }
    address {
        int address_id
        varchar(100) street
        varchar(50) city
        int country_id
        PRIMARY KEY
    }
    country {
        int country_id
        varchar(50) country_name
        PRIMARY KEY
    }
    address_status {
        int status_id
        varchar(25) status_name
        PRIMARY KEY
    }
    customer_address {
        int customer_id
        int address_id
        int status_id
        PRIMARY KEY
    }
    order_status {
        int status_id
        varchar(50) status_name
        PRIMARY KEY
    }
    cust_order {
        int order_id
        int customer_id
        datetime order_date
        int shipping_address_id
        decimal(10,2) order_total
        int status_id
        PRIMARY KEY
    }
    shipping_method {
        int method_id
        varchar(50) method_name
        decimal(10,2) cost
        PRIMARY KEY
    }
    order_history {
        int order_history_id
        int order_id
        int status_id
        datetime status_date
        PRIMARY KEY
    }
    order_line {
        int order_id
        int book_id
        int quantity
        decimal(10,2) price
        PRIMARY KEY
    }

    book_language ||--o{ book : "FK"
    publisher ||--o{ book : "FK"
    book ||--o{ book_author : "FK"
    author ||--o{ book_author : "FK"
    book_author ||--o{ book : "FK"
    book_author ||--o{ author : "FK"
    customer ||--o{ customer_address : "FK"
    address ||--o{ customer_address : "FK"
    address_status ||--o{ customer_address : "FK"
    country ||--o{ address : "FK"
    customer_address ||--o{ customer : "FK"
    customer_address ||--o{ address : "FK"
    customer_address ||--o{ address_status : "FK"
    customer ||--o{ cust_order : "FK"
    order_status ||--o{ cust_order : "FK"
    address ||--o{ cust_order : "FK"
    order_status ||--o{ order_history : "FK"
    cust_order ||--o{ order_history : "FK"
    cust_order ||--o{ order_line : "FK"
    book ||--o{ order_line : "FK"

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

