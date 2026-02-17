-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(50) DEFAULT 'Kathmandu',
    RegistrationDate DATE DEFAULT GETDATE()
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10,2) CHECK (Salary > 10000),
    HireDate DATE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    StockQuantity INT CHECK (StockQuantity >= 0)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert Customers
INSERT INTO Customers (FullName, Email, Phone, City)
VALUES 
('Aarav Sharma', 'aarav@gmail.com', '9800000001', 'Kathmandu'),
('Sita Rai', 'sita@gmail.com', '9800000002', 'Lalitpur'),
('Ram Thapa', 'ram@gmail.com', '9800000003', 'Bhaktapur'),
('Nabin Karki', 'nabin@gmail.com', '9800000004', 'Kathmandu'),
('Priya Shrestha', 'priya@gmail.com', '9800000005', 'Pokhara');

-- Insert Employees
INSERT INTO Employees (FullName, Position, Salary, HireDate)
VALUES
('Ramesh Adhikari', 'Manager', 60000, '2021-01-10'),
('Sunita Lama', 'Sales Executive', 35000, '2022-05-12'),
('Bikash Gurung', 'Sales Executive', 32000, '2023-02-15'),
('Anita KC', 'Cashier', 25000, '2024-01-01');

-- Insert Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES
('Laptop', 'Electronics', 80000, 10),
('Mobile', 'Electronics', 30000, 25),
('Headphones', 'Electronics', 2000, 50),
('Office Chair', 'Furniture', 7000, 15),
('Desk', 'Furniture', 12000, 5),
('Notebook', 'Stationery', 100, 200);

-- Insert Orders
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
VALUES
(1, 2, '2025-01-10'),
(2, 3, '2025-01-12'),
(3, 2, '2025-02-01'),
(1, 1, '2025-02-10');

-- Insert OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 80000),
(1, 3, 2, 2000),
(2, 2, 1, 30000),
(3, 4, 2, 7000),
(4, 6, 10, 100);


--1
Select FullName, City, RegistrationDate from Customers;

--2
Select 
o.OrderID, 
c.FullName as CustomerName, 
e.FullName as EmployeeName,
o.OrderDate 
from Orders o
inner join Customers c on c.CustomerID = o.CustomerID
inner join Employees e on e.EmployeeID = o.EmployeeID;

--3
Select 
p.ProductName, 
p.Category, 
od.Quantity, 
od.UnitPrice,
(od.Quantity*od.UnitPrice) as TotalPrice
from OrderDetails od
inner join Products p on p.ProductID = od.ProductID;

--4
Select CustomerID, FullName from Customers
where CustomerID not in(select CustomerID from Orders);

--5
Select ProductID, ProductName from Products
where ProductID not in(select ProductID from OrderDetails);

--6
Select 
OrderID, 
sum(Quantity*UnitPrice) as TotalSales
from OrderDetails group by OrderID;

--7
Select 
e.FullName as EmployeeName,
sum(od.quantity * od.unitprice) as TotalRev
from Employees e
inner join Orders o on o.EmployeeID = e.EmployeeID
inner join OrderDetails od on od.OrderID = o.OrderID
group by e.FullName;

--8
Select 
p.ProductName,
sum(od.Quantity) as TotalQuantity
from Products p
inner join OrderDetails od on p.ProductID = od.ProductID
group by p.ProductName order by 2 desc;

--9
Select Position, avg(Salary) as AvgSalary from Employees
group by Position;

--10
Select 
c.City,
sum(od.Quantity*od.unitprice) as TotalSales
from Customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join OrderDetails od on o.OrderID = od.OrderID
group by c.City;

--11
Select 
e.FullName,
sum(od.Quantity*od.UnitPrice) as TotalSales
from Employees e
inner join Orders o on o.EmployeeID = e.EmployeeID
inner join OrderDetails od on o.OrderID = od.OrderID
group by e.FullName
having sum(od.Quantity*od.UnitPrice) > 50000;

--12
Select 
p.ProductName,
sum(od.Quantity) as TotalQuantity
from Products p
inner join OrderDetails od on p.ProductID = od.ProductID
group by p.ProductName
having sum(od.Quantity) > 10;

--13
Select ProductName, Price from Products
where Price > (select avg(Price) from Products);

--14
Select CustomerID, count(OrderID) as TotalOrder
from Orders
group by CustomerID
having count(OrderID) > (select avg(orderc) from
(Select count(OrderID) as orderc
from Orders
group by CustomerID) as AvgOrder);

--15
Select top 1
e.FullName as EmployeeName,
sum(od.quantity * od.unitprice) as TotalRev
from Employees e
inner join Orders o on o.EmployeeID = e.EmployeeID
inner join OrderDetails od on od.OrderID = o.OrderID
group by e.FullName;

--16
Select 
upper(FullName) as NameInUpper,
left(FullName, 3) as First3
from Customers;

--17
Select 
left(FullName, CHARINDEX(' ', fullname) -1) as FirstNAme
from Employees;

--18
Select FullName from Customers
where FullName like 'A%';

--19
Select * from Orders
where MONTH(orderdate) = MONTH(getdate())
and YEAR(orderdate) = YEAR(getdate());

--20
Select 
OrderID,
DATEDIFF(day, orderdate, getdate()) as DaysTaken
from Orders;

--21
Select * from Employees
where HireDate >= DATEADD(year, -2 , getdate());

--22
Select top 1
year(o.OrderDate) as Year,
month(o.OrderDate) as Month,
sum(od.Quantity*od.UnitPrice) as TotalSales
from Orders o
inner join OrderDetails od on od.OrderID = o.OrderID
group by year(o.OrderDate), month(o.OrderDate);

--23
Create view vw_OrderSummary as
select 
o.OrderID,
c.FullName,
sum(od.Quantity*od.UnitPrice) as TotalOrderAmt, 
o.OrderDate
from orders o
inner join Customers c on o.CustomerID = c.CustomerID
inner join OrderDetails od on od.OrderID = o.OrderID
group by o.OrderID, c.FullName, o.OrderDate;

--24
Create view vw_EmployeeSales as
select 
e.FullName as EmployeeName,
sum(od.Quantity*od.UnitPrice) as TotalSales
from Orders o
inner join Employees e on e.EmployeeID = o.EmployeeID
inner join OrderDetails od on od.OrderID = o.OrderID
group by e.FullName;

--25
Create view vw_ProductSalesReport as
select 
p.ProductID,
p.Category,
sum(od.Quantity) as TotalQty,
sum(od.quantity * od.unitprice) as TotalRev
from Products p
inner join OrderDetails od on p.ProductID = od.ProductID
group by p.ProductID, p.Category;

--26
Select * from vw_OrderSummary
order by TotalOrderAmt desc;

--27
select * from vw_EmployeeSales
where TotalSales > 100000;

--28
Select * from vw_ProductSalesReport
where TotalRev > 20000;

--29
select 
c.FullName as CustomerName,
count(o.OrderID) as TotalOrder,
sum(od.quantity * od.unitprice) as TotalAmtSpent,
max(o.orderdate) as LastOrderDate,

(select top 1
em.FullName
from Orders os
inner join Employees em on em.EmployeeID = os.EmployeeID
where os.CustomerID = c.CustomerID
order by os.OrderDate desc) 
as LastHandledBy

from Orders o
inner join Customers c on o.customerId = c.customerId
inner join OrderDetails od on od.orderId = o.orderId
inner join Products p on p.productId = od.productId
group by c.CustomerID, c.FullName
order by TotalAmtSpent desc;