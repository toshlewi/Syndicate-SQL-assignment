---

```markdown
# 📚 Bookstore Database Project

Welcome to the **Bookstore Database Project**, a MySQL-powered relational database system designed to manage and analyze the key operations of a bookstore — from book inventory and customer transactions to employee roles and payment records.

---

## 🗂️ Project Structure

The database consists of the following core tables:

- **Books** – Title, author, genre, price, and stock.
- **Authors** – Author name, biography, and nationality.
- **Customers** – Customer contact and purchase history.
- **Orders** – Customer orders with timestamps and status.
- **Order_Items** – Books linked to each order (many-to-many).
- **Employees** – Staff roles, names, and access control.
- **Payments** – Tracks how and when payments are made.

---

## 🧠 Objectives

- Create a normalized, scalable schema for a bookstore.
- Generate sample data for real-world simulations.
- Write SQL queries for business intelligence and analytics.
- Model real-life bookstore workflows with accuracy.

---

## 🖼️ Entity-Relationship Diagram (ERD)

This image illustrates the full ERD for the database schema:

![ERD](A_Entity-Relationship_Diagram_(ERD)_of_a_%22bookstor.png)

> **Tip**: Make sure the image file is in the same directory as your README or update the path accordingly.

---

## 🏗️ Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/bookstore-database.git
   cd bookstore-database
   ```

2. Import the SQL schema:
   ```bash
   mysql -u root -p < bookstore_schema.sql
   ```

3. (Optional) Load sample data:
   ```bash
   mysql -u root -p < sample_data.sql
   ```

---

## 🧪 Sample Data Includes

- 100+ book records across genres
- Authored by a variety of writers
- Simulated customer orders and payments
- Staff members assigned various roles

---

## 🔍 Useful SQL Queries

Here are some helpful SQL queries to get you started with analysis and reporting:

### 📈 1. Top 5 Best-Selling Books
```sql
SELECT b.title, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN books b ON oi.book_id = b.book_id
GROUP BY b.title
ORDER BY total_sold DESC
LIMIT 5;
```

### 💰 2. Total Revenue Per Day
```sql
SELECT DATE(o.order_date) AS order_day, SUM(p.amount) AS daily_revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY order_day
ORDER BY order_day;
```

### 🧍 3. Customers With Most Orders
```sql
SELECT c.name, COUNT(o.order_id) AS orders_placed
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY orders_placed DESC
LIMIT 10;
```

### 📚 4. Books That Are Low in Stock
```sql
SELECT title, stock_quantity
FROM books
WHERE stock_quantity < 10
ORDER BY stock_quantity ASC;
```

### 📝 5. Author-Wise Sales Summary
```sql
SELECT a.name AS author_name, SUM(oi.quantity * b.price) AS total_sales
FROM order_items oi
JOIN books b ON oi.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
GROUP BY a.name
ORDER BY total_sales DESC;
```

---

## 👥 User Roles & Access

- **Admin** – Full access: manage users, view and modify all records.
- **Employee** – Can manage orders, customers, and view inventory.
- **Analyst** – Read-only access for querying and reporting.

---

## 🤝 Contributions

Have ideas to improve this project? Found an issue or want to contribute?  
Open a pull request or raise an issue on GitHub.

---

## 📬 Contact

**Developer**: Lewis Gitonga  
**Email**: [adelewigitz@gmail.com]  
