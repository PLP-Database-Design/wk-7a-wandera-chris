#Question 1 Achieving 1NF (First Normal Form) 🛠️

-- Create a new table to store the 1NF version of ProductDetail
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Populate the new table by splitting the Products column
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT
    OrderID,
    CustomerName,
    TRIM(value) AS Product  -- Trim to remove leading/trailing spaces
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');

-- Verify the result
SELECT * FROM ProductDetail_1NF;

-- Optionally, you might want to drop the original table
-- DROP TABLE ProductDetail;

#Question 2 Achieving 2NF (Second Normal Form) 🧩

-- Create a new table for Orders (OrderID, CustomerName)
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Populate the Orders table
INSERT INTO Orders_2NF (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a new table for OrderDetails (OrderID, Product, Quantity)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Populate the OrderDetails table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Verify the results
SELECT * FROM Orders_2NF;
SELECT * FROM OrderDetails_2NF;

-- Optionally, you might want to drop the original table
-- DROP TABLE OrderDetails;

