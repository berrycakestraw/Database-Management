/* =========================================
   TABLE CREATION
========================================= */

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(150) NOT NULL,
    ContactEmail VARCHAR(150)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQty INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,customer
    FullName VARCHAR(150) NOT NULL,
    Phone VARCHAR(20),
    City VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

/* =========================================
   INSERT DATA
========================================= */

INSERT INTO Categories VALUES
(1, 'Groceries'),
(2, 'Beverages'),
(3, 'Electronics'),
(4, 'Clothing');

INSERT INTO Suppliers VALUES
(1, 'Dabur Nepal', 'dabur@gmail.com'),
(2, 'CG Electronics', 'cg@gmail.com'),
(3, 'Unilever Nepal', 'unilever@gmail.com'),
(4, 'Local Textile House', 'textile@gmail.com');

INSERT INTO Products VALUES
(1, 'Rice 5KG', 1, 1, 1200, 100),
(2, 'Coca Cola 1L', 2, 3, 120, 200),
(3, 'LED TV 42 Inch', 3, 2, 45000, 15),
(4, 'Jeans Pant', 4, 4, 2500, 50),
(5, 'Sunflower Oil 1L', 1, 3, 350, 120),
(6, 'Bluetooth Speaker', 3, 2, 3000, 30);

INSERT INTO Customers VALUES
(1, 'Ramesh Shrestha', '9811111111', 'Kathmandu'),
(2, 'Sita Koirala', '9822222222', 'Pokhara'),
(3, 'Anil Gurung', '9833333333', 'Chitwan'),
(4, 'Mina Rai', '9844444444', 'Biratnagar');

INSERT INTO Orders VALUES
(1, 1, '2025-01-10'),
(2, 2, '2025-01-12'),
(3, 1, '2025-02-01'),
(4, 3, '2025-02-05'),
(5, 4, '2025-02-10');

INSERT INTO OrderDetails VALUES
(1, 1, 1, 2),
(2, 1, 2, 5),
(3, 2, 3, 1),
(4, 3, 5, 3),
(5, 4, 4, 2),
(6, 5, 6, 1),
(7, 2, 2, 10);

--Design a SQL Server view that combines customer, order, and product information to generate a transactional sales report.

--The view should:

--Join the necessary tables.

--Display the following columns:

--OrderID

--FullName

--ProductName

--Quantity

--Price

--TotalAmount (calculated column)

--Use proper table aliases.

--Name the view vw_OrderDetailsFull.

create view vw_OrderDetailsFull as
select 
orders.orderID, 
customers.fullname,

from orders
inner join customers on orders.customerId = customers.customerId
inner join orderdetails on orderdetails.orderId = orders.orderId
inner join products on products.productId = orderdetails.productId

create view vw_customerspending as

select 
customers.fullname,
sum(orderdetails.quantity * products.price) as TotalSpending
from orders
inner join customers on orders.customerId = customers.customerId
inner join orderdetails on orderdetails.orderId = orders.orderId
inner join products on products.productId = orderdetails.productId
group by customers.fullname;