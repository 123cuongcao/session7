CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(255) UNIQUE,
    productName VARCHAR(255),
    productPrice DECIMAL(10, 2),
    productAmount INT,
    productDescription TEXT,
    productStatus VARCHAR(50)
);

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
    ('P001', 'Product 1', 19.99, 100, 'Description 1', 'Active'),
    ('P002', 'Product 2', 29.99, 50, 'Description 2', 'Inactive'),
    ('P003', 'Product 3', 39.99, 75, 'Description 3', 'Active');
CREATE UNIQUE INDEX idx_productCode ON Products (productCode);

CREATE INDEX idx_productName_price ON Products (productName, productPrice);

EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';

CREATE VIEW productInfo AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;


ALTER VIEW productInfo AS
SELECT productCode, productName, productPrice, productStatus
FROM Products
WHERE productStatus = 'Active';


DROP VIEW IF EXISTS productInfo;

DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddNewProduct(
    IN pCode VARCHAR(255),
    IN pName VARCHAR(255),
    IN pPrice DECIMAL(10, 2),
    IN pAmount INT,
    IN pDescription TEXT,
    IN pStatus VARCHAR(50)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (pCode, pName, pPrice, pAmount, pDescription, pStatus);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateProductById(
    IN pId INT,
    IN pCode VARCHAR(255),
    IN pName VARCHAR(255),
    IN pPrice DECIMAL(10, 2),
    IN pAmount INT,
    IN pDescription TEXT,
    IN pStatus VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET productCode = pCode,
        productName = pName,
        productPrice = pPrice,
        productAmount = pAmount,
        productDescription = pDescription,
        productStatus = pStatus
    WHERE Id = pId;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeleteProductById(IN pId INT)
BEGIN
    DELETE FROM Products WHERE Id = pId;
END //
DELIMITER ;

