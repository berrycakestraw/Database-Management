CREATE TABLE categories (
    categoryID INT PRIMARY KEY,
    categoryName VARCHAR(50)
);

CREATE TABLE suppliers (
    supplierID INT PRIMARY KEY,
    supplierName VARCHAR(50)
);

CREATE TABLE products (
    productID INT PRIMARY KEY,
    productName VARCHAR(50),
    categoryID INT,
    supplierID INT
);

INSERT INTO categories VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Furniture'),
(4, 'Food'),
(5, 'Books');
INSERT INTO suppliers VALUES
(1, 'ABC Traders'),
(2, 'Global Supply'),
(3, 'Tech World'),
(4, 'Fresh Mart'),
(5, 'Book House');
INSERT INTO products VALUES
(101, 'Laptop', 1, 3),
(102, 'T-Shirt', 2, 1),
(103, 'Table', 3, 2),
(104, 'Chocolate', 4, 4),
(105, 'Novel', 5, 5);

create view single as
SELECT 
p.productID,
p.productName,
p.supplierID,
p.CategoryID
FROM products p
INNER JOIN categories c
ON p.categoryID = c.categoryID
INNER JOIN suppliers s
ON p.supplierID = s.supplierID;

select * from single

insert into single values (106, 'Bike', 4, 2); --works

delete from single where productID = 103; --doesn't work

update single set productName = 'Car' where productID = 104; --works




CREATE TABLE vehicle (
    vehicleID INT PRIMARY KEY,
    vehicleType VARCHAR(50),
    brand VARCHAR(50),
    price int not null
);
INSERT INTO vehicle (vehicleID, vehicleType, brand, price)
VALUES
(1, 'Car', 'Toyota', 25000),
(2, 'Bike', 'Yamaha', 1500),
(3, 'Bus', 'Volvo', 80000),
(4, 'Truck', 'Tata', 60000),
(5, 'Scooter', 'Honda', 1200);

create view Transportation as
select VehicleID, VehicleType from Vehicle

select * from transportation

insert into Transportation values (6, 'Bike'); --doesn't work not null price exists

delete from Transportation where VehicleId = 3; --works

update Transportation set VehicleType = 'Ship' where VehicleId = 4; --works