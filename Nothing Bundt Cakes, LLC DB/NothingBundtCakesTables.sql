USE innodb;


DROP DATABASE IF EXISTS NothingBundtCakes; 

CREATE DATABASE NothingBundtCakes;
USE NothingBundtCakes;

-- Create the Customers table, no FKs
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
( CustomerID		INT NOT NULL AUTO_INCREMENT,
  FirstName			VARCHAR(25) NOT NULL,
  MiddleName		VARCHAR(25) DEFAULT NULL,
  LastName			VARCHAR(25) NOT NULL,
  StreetAddress		VARCHAR(35) NOT NULL,
  City				VARCHAR(25) NOT NULL,
  State				CHAR(2) NOT NULL,
  ZipCode			VARCHAR(10) NOT NULL,

  CONSTRAINT PK_Customers_CustomerID PRIMARY KEY ( CustomerID )
);



-- Create the Products table, no FK
DROP TABLE IF EXISTS Products;
CREATE TABLE Products
( ProductID				SMALLINT NOT NULL AUTO_INCREMENT,
  ProductName			VARCHAR(25) NOT NULL,
  ProductDescription	VARCHAR(100) NOT NULL,
  SalesPrice			DECIMAL(6,2) NOT NULL,
  InventoryOnHand		SMALLINT NOT NULL,

  CONSTRAINT PK_Products_ProductID PRIMARY KEY ( ProductID )
);




-- Create the Employees table, has FK for Employees 
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
( EmployeeID			SMALLINT NOT NULL AUTO_INCREMENT,
  ManagerEmployeeID		SMALLINT NOT NULL,
  SSN					CHAR(11) NOT NULL,
  FirstName				VARCHAR(25) NOT NULL,
  MiddleName			VARCHAR(25) DEFAULT NULL,
  LastName				VARCHAR(25) NOT NULL,
  StreetAddress			VARCHAR(35) NOT NULL,
  City					VARCHAR(25) NOT NULL,
  State			      	CHAR(2) NOT NULL,
  ZipCode				VARCHAR(10) NOT NULL,
  
  CONSTRAINT PK_Employees_EmployeeID PRIMARY KEY ( EmployeeID ),
  CONSTRAINT FK_Employees_ManagerEmployeeID FOREIGN KEY ( ManagerEmployeeID ) REFERENCES Employees ( EmployeeID )

);

-- Create the Schedules table no FK
DROP TABLE IF EXISTS Schedules;
CREATE TABLE Schedules
( ScheduleID			TINYINT NOT NULL AUTO_INCREMENT,
  ScheduleType			VARCHAR(30) NOT NULL,

 CONSTRAINT PK_Statuses_ScheduleID PRIMARY KEY ( ScheduleID )
);


-- Create the Schedules table FK OF EMPLOYEES AND SCHEDULES
DROP TABLE IF EXISTS Shifts;
CREATE TABLE Shifts
( EmployeeID			SMALLINT NOT NULL,
  ScheduleID			TINYINT NOT NULL,
  ShiftStart		   	TIME NOT NULL,
  ShiftEnd		 		TIME NOT NULL,

  CONSTRAINT PK_Shifts_EmployeeID_ScheduleID PRIMARY KEY ( EmployeeID, ScheduleID ),
  CONSTRAINT FK_Shifts_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID ),
  CONSTRAINT FK_Shifts_ScheduleID FOREIGN KEY ( ScheduleID ) REFERENCES Schedules ( ScheduleID )
);


-- Create the InventoryOrders FK on Employees
DROP TABLE IF EXISTS InventoryOrders;
CREATE TABLE InventoryOrders
( InventoryOrderID			INT NOT NULL AUTO_INCREMENT,
  EmployeeID		        SMALLINT NOT NULL,
  OrderDate		        	DATE NOT NULL,
  OrderTime					TIME NOT NULL,

  CONSTRAINT PK_InventoryOrders_InventoryOrderID PRIMARY KEY ( InventoryOrderID ),
  CONSTRAINT FK_InventoryOrders_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

-- Create the Suppliers table NO FK
DROP TABLE IF EXISTS Suppliers;
CREATE TABLE Suppliers
( SupplierID			SMALLINT NOT NULL AUTO_INCREMENT,
  SupplierName			VARCHAR(25) NOT NULL,
  SupplierDescription	VARCHAR(100) NOT NULL,

  CONSTRAINT PK_Suppliers_SupplierID PRIMARY KEY ( SupplierID )
);


-- Create  Ingredients Table FK SupplierID
DROP TABLE IF EXISTS Ingredients;
CREATE TABLE Ingredients
( 
  IngredientID	        SMALLINT NOT NULL AUTO_INCREMENT,
  SupplierID			SMALLINT NOT NULL,
  IngredientName		VARCHAR(25) NOT NULL,
  IngredientDescription	VARCHAR(100) NOT NULL,
  InventoryOnHand		SMALLINT NOT NULL,
  
   CONSTRAINT PK_Ingredients_IngredientID PRIMARY KEY (IngredientID),
   CONSTRAINT FK_Ingredients_SupplierID FOREIGN KEY ( SupplierID ) REFERENCES Suppliers ( SupplierID )
);

-- Create InventoryOrderLines Table FK InventoryOrderID IngredientID
DROP TABLE IF EXISTS InventoryOrderLines;
CREATE TABLE InventoryOrderLines
(  InventoryOrderID		INT NOT NULL,
   IngredientID			SMALLINT NOT NULL,
   Quantity             SMALLINT NOT NULL,
   SalesPrice           DECIMAL(6,2) NOT NULL,
   
   CONSTRAINT PK_InventoryOrderLines_InventoryOrderID_IngredientID PRIMARY KEY ( InventoryOrderID , IngredientID),
   CONSTRAINT FK_InventoryOrderLines_InventoryOrderID FOREIGN KEY ( InventoryOrderID ) REFERENCES InventoryOrders ( InventoryOrderID ),
   CONSTRAINT FK_InventoryOrderLines_IngredientID FOREIGN KEY ( IngredientID ) REFERENCES Ingredients ( IngredientID )
  
);




-- Create the Orders table fk on customers and employees 
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
( OrderID				INT NOT NULL AUTO_INCREMENT,
  EmployeeID			SMALLINT NOT NULL,
  CustomerID			INT NOT NULL,
  OrderType				CHAR(1) NOT NULL,
  OrderDate				DATE NOT NULL,
  OrderTime	 			TIME NOT NULL,
  CONSTRAINT PK_Orders_OrderID PRIMARY KEY ( OrderID ),
  CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID ),
  CONSTRAINT FK_Orders_CustomerID FOREIGN KEY ( CustomerID ) REFERENCES Customers ( CustomerID ),
    CONSTRAINT CHECK_Orders_OrderType CHECK ( OrderType IN ( 'D', 'P' ) )
);

-- Create the DeliveryOrders table fk on Orders
DROP TABLE IF EXISTS DeliveryOrders;
CREATE TABLE DeliveryOrders
( OrderID				INT NOT NULL,
  DeliveryDriver		VARCHAR(25) NOT NULL,
  DeliveryDate			DATE NOT NULL,
  DeliveryTime			TIME NOT NULL,
  CONSTRAINT PK_DeliveryOrders_OrderID PRIMARY KEY ( OrderID ),
  CONSTRAINT FK_Delivery_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID )
 

);
-- Create the Pickup table fk on Orders
DROP TABLE IF EXISTS PickupOrders;
CREATE TABLE PickupOrders
( OrderID				INT NOT NULL,
  PickupEmployee		VARCHAR(25) NOT NULL,
  PickupDate			DATE NOT NULL,
  PickupTime			TIME NOT NULL,
  CONSTRAINT PK_PickupOrders_OrderID PRIMARY KEY ( OrderID ),
  CONSTRAINT FK_PickupOrders_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID )
 

);

-- Create Orderlines Table FK OrderID ProductID
DROP TABLE IF EXISTS OrderLines;
CREATE TABLE OrderLines
(  OrderID				INT NOT NULL,
   ProductID			SMALLINT NOT NULL,
   Quantity             SMALLINT NOT NULL,
   SalesPrice           DECIMAL(6,2) NOT NULL,
   
  CONSTRAINT PK_OrderLines_OrderID_ProductID PRIMARY KEY ( OrderID , ProductID),
   CONSTRAINT FK_OrderLines_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
   CONSTRAINT FK_Orderlines_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID )
  
);
