-- How many hours did each employee work?
SELECT E.EmployeeID,
	   CONCAT( E.FirstName, ' ', COALESCE( E.MiddleName, '' ), ' ', E.LastName ) AS EmployeeName,
       ADDTIME( TIMEDIFF( SH.ShiftEnd, SH.ShiftStart ), (TIMEDIFF( SH.ShiftEnd, SH.ShiftStart ))) AS WorkedTime
FROM Employees AS E
INNER JOIN Shifts AS SH ON E.EmployeeID = SH.EmployeeID
INNER JOIN Schedules AS SC ON SH.ScheduleID = SC.ScheduleID
GROUP BY EmployeeID,
	     EmployeeName
ORDER BY WorkedTime DESC;

-- What ingredient is purchased most frequently?
SELECT I.IngredientName,
	   COUNT(IOL.IngredientID) AS PurchaseFrequency
FROM InventoryOrderLines AS IOL
INNER JOIN Ingredients as I ON IOL.IngredientID = I.IngredientID
GROUP BY I.IngredientName
ORDER BY COUNT(IOL.IngredientID) DESC;

-- Which customer orders the most frequently?
SELECT CONCAT( C.FirstName, ' ', COALESCE( C.MiddleName, '' ), ' ', C.LastName ) AS CustomerName,
	   COUNT( O.CustomerID ) AS OrderCount
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY CONCAT( C.FirstName, ' ', COALESCE( C.MiddleName, '' ), ' ', C.LastName )
ORDER BY COUNT( O.CustomerID ) DESC;

-- Which products have the highest sales volume ? 
SELECT P.ProductID,
	   P.ProductName,
	   SUM( OL.Quantity * OL.SalesPrice ) AS SalesVolume
FROM Products AS P
INNER JOIN OrderLines AS OL ON P.ProductID = OL.ProductID
GROUP BY P.ProductID,	
	        P.ProductName
ORDER BY SUM( OL.Quantity * OL.SalesPrice ) DESC;

-- What ingredients have we bought the most of and from which suppliers? 
SELECT S.SupplierID,
	   S.SupplierName,
       I.IngredientName,
	  COUNT( I.IngredientID ) AS TimesPurchased,
	   SUM( IOL.Quantity * IOL.SalesPrice ) AS IngredientOrderTotal
FROM Suppliers AS S
INNER JOIN Ingredients AS I ON S.SupplierID = I.SupplierID
INNER JOIN InventoryOrderLines AS IOL ON I.IngredientID = IOL.IngredientID 
GROUP BY S.SupplierID,
	        S.SupplierName,
	        I.IngredientName
ORDER BY SUM( Quantity * SalesPrice ) DESC, 
         COUNT( IngredientID ) DESC;

-- Create a way to update the amount of ingredients that are on hand in inventory (SPROC)
DELIMITER //
CREATE PROCEDURE UpdateIngredients
( IN $IngredientID 			SMALLINT,
  IN $InventoryOnHand		SMALLINT
  )
  BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;
  
  START TRANSACTION;
  UPDATE Ingredients 
  SET InventoryOnHand = $InventoryOnHand
  WHERE IngredientID = $IngredientID;
  
  COMMIT;
  END //
  DELIMITER ;
  
-- Create a way to update Employee information  (SPROC)
DELIMITER //
CREATE PROCEDURE UpdateEmployeeInfo
( IN $EmployeeID			SMALLINT,
  IN $ManagerEmployeeID		SMALLINT,
  IN $FirstName				VARCHAR(25),
  IN $MiddleName			VARCHAR(25),
  IN $LastName				VARCHAR(25),
  IN $StreetAddress			VARCHAR(35),
  IN $City					VARCHAR(25),
  IN $State			      	CHAR(2),
  IN $ZipCode				VARCHAR(10)
)
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;

START TRANSACTION;
UPDATE Employees
SET ManagerEmployeeID = $ManagerEmployeeID,
	FirstName = $FirstName,
    MiddleName = $Middlename,
    LastName = $LastName,
    StreetAddress = $StreetAddress,
    City = $City,
    State = $State,
    Zipcode = $Zipcode
WHERE EmployeeID = $EmployeeID;
COMMIT;
END //
DELIMITER ;

-- Create an invoice for inventory orders that includes item bought, 
-- quantity bought, sales price, and supplier name (VIEW)
CREATE VIEW InventoryInvoice AS
	SELECT S.SupplierID,
		   S.SupplierName,
           I.IngredientName,
           IO.OrderDate,
           IOL.Quantity,
           IOL.SalesPrice,
           SUM( IOL.Quantity * IOL.SalesPrice ) AS TotalCost
FROM Suppliers AS S
INNER JOIN Ingredients AS I ON S.SupplierID = I.SupplierID
INNER JOIN InventoryOrderLines AS IOL ON I.IngredientID = IOL.IngredientID
INNER JOIN InventoryOrders AS IO ON IOL.InventoryOrderID = IO.InventoryOrderID
GROUP BY SupplierID,
		   SupplierName,
           IngredientName,
           OrderDate,
           Quantity,
           SalesPrice
ORDER BY OrderDate DESC;

-- Create a way to add a new customer into the customers table (SPROC)
 DELIMITER //
CREATE PROCEDURE AddNewCustomer
( IN $FirstName 			VARCHAR(25),
  IN $MiddleName			VARCHAR(25),
  IN $Lastname				VARCHAR(25),
  IN $StreetAddress			VARCHAR(35),
  IN $City					VARCHAR(25),
  IN $State					CHAR(2),
  IN $ZipCode				VARCHAR(10)
  )
BEGIN
	DECLARE $CustomerID INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;
START TRANSACTION;
INSERT INTO Customers (FirstName, MiddleName, LastName, StreetAddress, City, State, ZipCode)
VALUES ( $FirstName, $MiddleName, $LastName, $StreetAddress, $City, $State, $ZipCode );
SET $CustomerID = LAST_INSERT_ID();
COMMIT;
END // 
DELIMITER ;



-- Display the full customer information and most recent purchase (VIEW)
CREATE VIEW CustomerInformation AS
  SELECT C.CustomerID,
		   CONCAT( C.FirstName, ' ', COALESCE( C.MiddleName, '' ), ' ', C.LastName ) AS FullName,
           CONCAT( C.StreetAddress, ' ', C.City, ' ', C.State, ' ', C.ZipCode ) AS FullAddress,
           P.ProductName AS RecentlyBought
  FROM Customers AS C
  LEFT OUTER JOIN Orders AS O ON C.CustomerID = O.CustomerID
  LEFT OUTER JOIN OrderLines AS OL ON O.OrderID = OL.OrderID
  LEFT OUTER JOIN Products AS P ON OL.ProductID = P.ProductID
  GROUP BY C.CustomerID,
		   CONCAT( C.FirstName, ' ', COALESCE( C.MiddleName, '' ), ' ', C.LastName ),
           CONCAT( C.StreetAddress, ' ', C.City, ' ', C.State, ' ', C.ZipCode )
  ORDER BY O.OrderDate DESC;

