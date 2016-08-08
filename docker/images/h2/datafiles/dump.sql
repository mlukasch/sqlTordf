DROP TABLE Customers IF EXISTS;
DROP TABLE Employees IF EXISTS;
DROP TABLE Offices IF EXISTS;
DROP TABLE OrderDetails IF EXISTS;
DROP TABLE Orders IF EXISTS;
DROP TABLE Payments IF EXISTS;
DROP TABLE Products IF EXISTS;

/* Create the full set of Classic Models Tables */

CREATE TABLE Customers (
  customerNumber INTEGER NOT NULL,
  customerName VARCHAR(50) NOT NULL,
  contactLastName VARCHAR(50) NOT NULL,
  contactFirstName VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  addressLine1 VARCHAR(50) NOT NULL,
  addressLine2 VARCHAR(50) NULL,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50) NULL,
  postalCode VARCHAR(15) NULL,
  country VARCHAR(50) NOT NULL,
  salesRepEmployeeNumber INTEGER NULL,
  creditLimit DOUBLE NULL,
  PRIMARY KEY (customerNumber)
) AS SELECT * FROM CSVREAD('./datafiles/Customers.txt');

CREATE TABLE Employees (
  employeeNumber INTEGER NOT NULL,
  lastName VARCHAR(50) NOT NULL,
  firstName VARCHAR(50) NOT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  officeCode VARCHAR(20) NOT NULL,
  reportsTo INTEGER NULL,
  jobTitle VARCHAR(50) NOT NULL,
  PRIMARY KEY (employeeNumber)
) AS SELECT * FROM CSVREAD('./datafiles/Employees.txt');

CREATE TABLE Offices (
  officeCode VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  addressLine1 VARCHAR(50) NOT NULL,
  addressLine2 VARCHAR(50) NULL,
  state VARCHAR(50) NULL,
  country VARCHAR(50) NOT NULL,
  postalCode VARCHAR(10) NOT NULL,
  territory VARCHAR(10) NOT NULL,
  PRIMARY KEY (officeCode)
) AS SELECT * FROM CSVREAD('./datafiles/Offices.txt');

CREATE TABLE OrderDetails (
  orderNumber INTEGER NOT NULL,
  productCode VARCHAR(50) NOT NULL,
  quantityOrdered INTEGER NOT NULL,
  priceEach DOUBLE NOT NULL,
  orderLineNumber SMALLINT NOT NULL,
  PRIMARY KEY (orderNumber, productCode)
) AS SELECT * FROM CSVREAD('./datafiles/OrderDetails.txt');

CREATE TABLE Orders (
  orderNumber INTEGER NOT NULL,
  orderDate DATETIME NOT NULL,
  requiredDate DATETIME NOT NULL,
  shippedDate DATETIME NULL,
  status VARCHAR(15) NOT NULL,
  comments TEXT NULL,
  customerNumber INTEGER NOT NULL,
  PRIMARY KEY (orderNumber)
) AS SELECT orderNumber,
        convert(parseDateTime(orderDate,'yyyy/MM/dd hh:mm:ss'), timestamp),
        convert(parseDateTime(requiredDate,'yyyy/MM/dd hh:mm:ss'), timestamp),
        convert(parseDateTime(shippedDate,'yyyy/MM/dd hh:mm:ss'), timestamp),
        status,
        comments,
        customerNumber
      FROM CSVREAD('./datafiles/Orders.txt', 'ORDERNUMBER,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,STATUS,COMMENTS,CUSTOMERNUMBER','charset=UTF-8 fieldSeparator=,');

CREATE TABLE Payments (
  customerNumber INTEGER NOT NULL,
  checkNumber VARCHAR(50) NOT NULL,
  paymentDate DATETIME NOT NULL,
  amount DOUBLE NOT NULL,
  PRIMARY KEY (customerNumber, checkNumber)
) AS SELECT customerNumber,
        checkNumber,
        convert(parseDateTime(paymentDate,'yyyy/MM/dd hh:mm:ss'), timestamp),
        amount
     FROM CSVREAD('./datafiles/Payments.txt', 'CUSTOMERNUMBER,CHECKNUMBER,PAYMENTDATE,AMOUNT','charset=UTF-8 fieldSeparator=,');

CREATE TABLE Products (
  productCode VARCHAR(50) NOT NULL,
  productName VARCHAR(70) NOT NULL,
  productLine VARCHAR(50) NOT NULL,
  productScale VARCHAR(10) NOT NULL,
  productVendor VARCHAR(50) NOT NULL,
  productDescription TEXT NOT NULL,
  quantityInStock SMALLINT NOT NULL,
  buyPrice DOUBLE NOT NULL,
  MSRP DOUBLE NOT NULL,
  PRIMARY KEY (productCode)
) AS SELECT * FROM CSVREAD('./datafiles/Products.txt');
