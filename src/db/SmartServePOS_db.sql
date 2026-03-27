-- =========================
-- CREATE DATABASE
-- =========================
CREATE DATABASE SmartServePOS;
GO

USE SmartServePOS_db;
GO

-- =========================
-- USERS (Staff)
-- =========================
CREATE TABLE Users (
    user_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255),
    role_name VARCHAR(50),  -- ADMIN, MANAGER, CASHIER, WAITER, KITCHEN, DRIVER
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);

-- Sample Users (with example bcrypt hashed passwords "Admin123" / "Manager123" etc.)
INSERT INTO Users (first_name, last_name, email, phone, password, role_name)
VALUES
('Alice', 'Rockey', 'alice195@gmail.com', '0712345678', '$2b$10$XhG9h4Vp6OqV1J8f3n9k1u1YxQw1vZ6F7Q1oT0w2z4a5F6vL7pJ8K', 'ADMIN'),
('Bob', 'Donewy', 'bob76@gmail.com', '0722345678', '$2b$10$YgH2f5Vp6QzV2K9f4o0l2v2YxQw2vA7G8R1pU1x3y5b6H7qM8rN9K', 'MANAGER'),
('Charlie', 'Zamp', 'charlie54@gmail.com', '0732345678', '$2b$10$ZkI3g6Wp7RxW3L0g5p1m3w3YyRx3wB8H9S2qV2y4z6c7J8rN9sO0L', 'CASHIER'),
('Daisy', 'Kassim', 'daisy34@gmail.com', '0742345678', '$2b$10$AlJ4h7Xq8SyX4M1h6q2n4z4ZzSy4xC9I0T3rW3z5a7d8K9sO0tP1M', 'WAITER'),
('Eve', 'liz', 'eve32@gmail.com', '0752345678', '$2b$10$BmK5i8Yr9TzY5N2i7r3p5a5AaTz5yD0J1U4sX4a6b8e9L0uP1vQ2N', 'KITCHEN'),
('Frank', 'Wolf', 'frank79@gmail.com', '0762345678', '$2b$10$CnL6j9Zs0UzZ6O3j8s4q6b6BbUz6zE1K2V5tY5b7c9f0M1vQ2wR3O', 'DRIVER');


-- =========================
-- CUSTOMERS
-- =========================
CREATE TABLE Customers (
    customer_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);

-- Sample Customers
INSERT INTO Customers (first_name, last_name, phone, email, address)
VALUES 
('John', 'Doe', '0771111111', 'john@gmail.com', '123 Nairobi Street'),
('Jane', 'Doe', '0772222222', 'jane@gmail.com', '45 Nyeri Avenue'),
('Mary', 'Smith', '0773333333', 'mary@@gmail.com', '78 Thika Road'),
('Peter', 'Brown', '0774444444', 'peter@gmail.com', '9 Kiambu Street'),
('Lucy', 'Green', '0775555555', 'lucy@gmail.com', '34 Nakuru Avenue');


-- =========================
-- RESTAURANT TABLES
-- =========================
CREATE TABLE RestaurantTables (
    table_id INT IDENTITY PRIMARY KEY,
    table_number INT,
    qr_code VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Available'
);

-- Sample Tables
INSERT INTO RestaurantTables (table_number, qr_code, status)
VALUES
(1, 'QR_TABLE_1', 'Available'),
(2, 'QR_TABLE_2', 'Available'),
(3, 'QR_TABLE_3', 'Available'),
(4, 'QR_TABLE_4', 'Available'),
(5, 'QR_TABLE_5', 'Available'),
(6, 'QR_TABLE_6', 'Available'),
(7, 'QR_TABLE_7', 'Available'),
(8, 'QR_TABLE_8', 'Available'),
(9, 'QR_TABLE_9', 'Available'),
(10, 'QR_TABLE_10', 'Available');


-- =========================
-- CATEGORIES
-- =========================
CREATE TABLE Categories (
    category_id INT IDENTITY PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Sample Categories
INSERT INTO Categories (category_name)
VALUES 
('Burgers'),
('Pizzas'),
('Drinks'),
('Desserts'),
('Sides');


-- =========================
-- PRODUCTS / MENU ITEMS
-- =========================
CREATE TABLE Products (
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    stock INT,
    barcode VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Sample Products
INSERT INTO Products (product_name, price, category_id, stock, barcode)
VALUES
('Cheeseburger', 450.00, 1, 50, 'BRG001'),
('Veggie Burger', 400.00, 1, 40, 'BRG002'),
('Pepperoni Pizza', 1200.00, 2, 30, 'PIZ001'),
('Margherita Pizza', 1000.00, 2, 25, 'PIZ002'),
('Coke 500ml', 150.00, 3, 100, 'DRK001'),
('Fanta 500ml', 150.00, 3, 100, 'DRK002'),
('Chocolate Cake', 300.00, 4, 20, 'DES001'),
('Ice Cream', 250.00, 4, 20, 'DES002'),
('French Fries', 200.00, 5, 50, 'SIDE001'),
('Onion Rings', 180.00, 5, 50, 'SIDE002');


-- =========================
-- INVENTORY
-- =========================
CREATE TABLE Inventory (
    inventory_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    quantity INT,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Inventory
INSERT INTO Inventory (product_id, quantity)
VALUES
(1, 50),
(2, 40),
(3, 30),
(4, 25),
(5, 100),
(6, 100),
(7, 20),
(8, 20),
(9, 50),
(10, 50);


-- =========================
-- STOCK MOVEMENTS
-- =========================
CREATE TABLE StockMovements (
    movement_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    quantity INT,
    movement_type VARCHAR(20), -- IN / OUT
    movement_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Stock Movements
INSERT INTO StockMovements (product_id, quantity, movement_type)
VALUES
(1, 50, 'IN'),
(2, 40, 'IN'),
(3, 30, 'IN'),
(4, 25, 'IN'),
(5, 100, 'IN');


-- =========================
-- ORDERS
-- =========================
CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    order_type VARCHAR(20), -- DINE_IN, DELIVERY, TAKEAWAY
    table_id INT NULL,
    customer_id INT NULL,
    created_by INT NULL, -- Staff who created the order
    status VARCHAR(20),
    total_amount DECIMAL(10,2),
    order_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (table_id) REFERENCES RestaurantTables(table_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- Sample Orders
INSERT INTO Orders (order_type, table_id, customer_id, created_by, status, total_amount)
VALUES
('DINE_IN', 1, 1, 4, 'Pending', 450.00),
('DELIVERY', NULL, 2, 3, 'Preparing', 1200.00),
('TAKEAWAY', NULL, 3, 3, 'Ready', 1000.00);


-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE OrderItems (
    order_item_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Order Items
INSERT INTO OrderItems (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 450.00),
(2, 3, 1, 1200.00),
(3, 4, 1, 1000.00);


-- =========================
-- PAYMENTS
-- =========================
CREATE TABLE Payments (
    payment_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(20), -- CASH / MPESA
    payment_status VARCHAR(20),
    mpesa_code VARCHAR(50),
    phone_number VARCHAR(20),
    payment_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Sample Payments
INSERT INTO Payments (order_id, amount, payment_method, payment_status, phone_number)
VALUES
(1, 450.00, 'CASH', 'COMPLETED', NULL),
(2, 1200.00, 'MPESA', 'PENDING', '0772222222'),
(3, 1000.00, 'CASH', 'COMPLETED', NULL);
SELECT * FROM Payments;


-- =========================
-- DELIVERIES (with comment)
-- =========================
CREATE TABLE Deliveries (
    delivery_id INT IDENTITY PRIMARY KEY,
    order_id INT,
    driver_id INT,
    delivery_address VARCHAR(255),
    delivery_status VARCHAR(50),
    assigned_at DATETIME,
    delivered_at DATETIME NULL,
    delivery_comment VARCHAR(500) NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (driver_id) REFERENCES Users(user_id)
);

-- Sample Delivery
INSERT INTO Deliveries (order_id, driver_id, delivery_address, delivery_status, assigned_at, delivery_comment)
VALUES
(2, 6, '45 Nyeri Avenue', 'Assigned', GETDATE(), '');  