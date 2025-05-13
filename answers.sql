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
