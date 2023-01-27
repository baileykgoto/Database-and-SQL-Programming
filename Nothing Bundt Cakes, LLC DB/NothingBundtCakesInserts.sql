USE NothingBundtCakes;

INSERT INTO Customers (FirstName, MiddleName, LastName, StreetAddress, City, State, ZipCode)
VALUES ('James', 'Colby', 'Smith', '839 Cherry Lane', 'Salt Lake City', 'UT', '84102'),
	   ('Hannah', NULL, 'Lewis', '1425 E Teague Ave', 'Fresno', 'CA', '93720'),
	   ('Hazel', 'Paige', 'Harrison', '2129 W El Paso Ave', 'Clovis', 'CA', '93611'),
	   ('Jane', 'Erin', 'Swift', '892 E 100 S', 'Salt Lake City', 'UT', '84102'),
	   ('Robert', 'John', 'Bryant', '2938 Goshen Ave', 'Clovis', 'CA', '93611'),
	   ('Jonathan', 'David', 'Winn', '738 Decatur Ave', 'Fresno', 'CA', '93720'),
	   ('Ryan', 'Kelsey', 'McClendon', '8983 Spruce Lane', 'Visalia', 'CA', '93420'),
	   ('Carlos', 'David', 'Cabrera', '3829 Essex Ave', 'Fresno', 'CA', '93720'),
	   ('Ashlyn', 'Marie', 'Brosi', '8327 Hickory Hill Ave', 'Fresno', 'CA', '93720'),
	   ('Andrew', 'Hill', 'Rush', '736 Locust Ave', 'Fresno', 'CA', '93711'),
	   ('Carolyn','Jillian', 'Shaw', '2281 Nees Ave', 'Fresno', 'CA', '93722'),
	   ('Tiffany', NULL, 'Frank', '3928 Alluvial Ave', 'Fresno', 'CA', '93710'),
	   ('Edgar', 'Tedd', 'Codd', '9273 Fundamental Ave', 'Salt Lake City','UT',' 84112');
    
INSERT INTO Products ( ProductName, ProductDescription, SalesPrice, InventoryOnHand )
VALUES ( '8 inch Red Velvet Cake', 'Bundt cake that is 8 inches and Red Velvet', '22.00', '40'),
       ( '10 inch Red Velvet Cake', 'Bundt cake that is 10 inches and Red Velvet', '32.00', '50'),
	   ( '8 inch Chocolate Cake', 'Bundt cake that is 8 inches and Chocolate', '22.00', '40'),
	   ( '10 inch Chocolate Cake', 'Bundt cake that is 10 inches and Chocolate', '32.00', '50'),
	   ( '8 inch Lemon Cake', 'Bundt cake that is 8 inches and Lemon', '22.00', '40'),
	   ( '10 inch Lemon Cake', 'Bundt cake that is 10 inches and Lemon', '32.00', '50'),
	   ( '8 inch Marble Cake', 'Bundt cake that is 8 inches and Marble', '22.00', '40'),
	   ( '10 inch Marble Cake', 'Bundt cake that is 10 inches and Marble', '32.00', '50'),
	   ( '8 inch Carrot Cake', 'Bundt cake that is 8 inches and Carrot', '22.00', '40'),
	   ( '10 inch Carrot Cake', 'Bundt cake that is 10 inches and Carrot', '32.00', '50'),
	   ( '8 inch Confetti Cake', 'Bundt cake that is 8 inches and Confetti', '22.00', '40'),
	   ( '10 inch Confetti Cake', 'Bundt cake that is 10 inches and Confetti', '32.00', '50'),
	   ( '8 inch Vanilla Cake', 'Bundt cake that is 8 inches and Vanilla', '22.00', '40'),
	   ( '10 inch Vanilla Cake', 'Bundt cake that is 10 inches and Vanilla', '32.00', '50');


INSERT INTO Employees (ManagerEmployeeID, SSN, FirstName, MiddleName, LastName, StreetAddress, City, State, ZipCode )
VALUES ('1', '192-28-8362', 'Jeremy', 'Ryan', 'Scott', '4627 Fowler', 'Clovis', 'CA', '93611' ),
	   ('2', '983-39-1289', 'Kathryn', 'May', 'Park', '519 E Bullard Ave', 'Fresno', 'CA', '93711' ),
       ('3', '120-32-8987', 'Grace', 'Marie', 'Falco', '3829 Windsor Ave', 'Fresno', 'CA', '93720' ),
       ('4', '198-98-2737', 'Sharon', 'Raine', 'Smith', '8291 Palm Ave', 'Fresno', 'CA', '93722' );

INSERT INTO Employees ( ManagerEmployeeID, SSN, FirstName, MiddleName, LastName, StreetAddress, City, State, ZipCode )
VALUES ( 1, '182-19-7268', 'Carson', 'Jim', 'Plumlee', '2783 Hill Ave', 'Fresno', 'CA', '93820' ),
	   ( 3, '218-82-2891', 'Trudi', 'Joy', 'Robertson', '1928 Crown Ave', 'Clovis', 'CA', '93611' ),
	   ( 2, '830-81-2938', 'Sarah', 'Kate', 'Lyon', '1882 Yellow Lane', 'Fresno', 'CA', '93720' ),
	   ( 2, '467-28-7893', 'Sally', 'Reagan', 'Neely', '939 E Ashlan Ave', 'Fresno', 'CA', '93722' ),
	   ( 2, '892-78-7369', 'John', 'Jacob', 'Williams', '4930 Nees Ave', 'Fresno', 'CA', '93620' ),
	   ( 1, '879-46-4567', 'Kaitlyn', 'Paige', 'Johnson', '983 Cole Ave', 'Clovis', 'CA', '93611' ),
	   ( 4, '989-68-8768', 'Gary', 'Anthony', 'Cornell', '897 Burgan Ave', 'Clovis', 'CA', '93622' ),
       ( 4, '254-89-3548', 'Mike', 'Lee', 'Anderson', '89 Canyon Hill BLVD', 'Seattle', 'WA', '95731' ),
       ( 4, '396-74-8519', 'Madhavi', 'Jane', 'Pandey', '763 Butterfly Way', 'Albuquerque', 'NM', '79624' ),
       ( 3, '159-63-7538', 'Devesh', NULL, 'Singh', '582 Buffalo Grass Lane', 'Miami', 'FL', '13876' ),
       ( 3, '597-46-2853', 'Ralph', NULL, 'Kimpball', '5368 Dimensional BLVD', 'Chicago', 'IL', '60659' ),
       ( 3, '183-48-9257', 'Lisa', 'Marie', 'Bartholomew', '369 Red Rock BLVD', 'Salt Lake City', 'UT', '84069' ),
       ( 3, '528-74-9635', 'Bryan', 'David', 'Larson', '3248 Cactus Road', 'Gilbert', 'AZ', '87121' ),
       ( 2, '582-96-7482', 'Abigail', NULL, 'Williams', '429 Quakie Aspen Lane', 'Durango', 'CO', '81397'  ),
       ( 2, '183-54-8269', 'Kim', NULL, 'Drexler', '666 Samoa Street', 'Albuquerque', 'NM', '87190' ),
	   ( 1, '372-28-4789', 'Tiereny', 'Kate', 'OBrien', '908 Fruit', 'Fresno', 'CA', '93710' );



INSERT INTO Schedules ( ScheduleType )
VALUES ( 'Sun' ),
	   ( 'Mon' ),
	   ( 'Tues' ),
	   ( 'Wed' ),
	   ( 'Thurs' ),
	   ( 'Fri' ),
	   ( 'Sat' );

INSERT INTO Shifts ( EmployeeID, ScheduleID, ShiftStart, ShiftEnd )
VALUES ( '1', '1', '08:00:00', '17:00:00' ),
	   ( '1', '2', '08:00:00', '17:00:00' ),
	   ( '2', '1', '08:00:00', '17:00:00' ),
	   ( '2', '4', '09:00:00', '18:00:00' ),
	   ( '3', '2','09:00:00', '18:00:00' ),
	   ( '3', '5', '09:00:00', '18:00:00' ),
	   ( '4', '4', '09:00:00', '18:00:00' ),
	   ( '4', '3', '10:00:00', '19:00:00' ),
	   ( '5', '3', '10:00:00', '19:00:00' ),
	   ( '5', '5', '10:00:00', '19:00:00' ),
	   ( '6', '5', '10:00:00', '19:00:00' ),
	   ( '6', '7', '11:00:00', '20:00:00' ),
	   ( '6', '6', '11:00:00', '20:00:00' ),
	   ( '7', '1', '11:00:00', '20:00:00' ),
	   ( '8', '2', '11:00:00', '20:00:00' ),
	   ( '8', '3', '11:00:00', '20:00:00' ),
	   ( '8', '4', '11:00:00', '20:00:00' ),
	   ( '9', '7', '12:00:00', '21:00:00' ),
	   ( '9', '1', '12:00:00', '21:00:00' ),
	   ( '9', '3', '12:00:00', '21:00:00' ),
	   ( '10', '3', '8:00:00', '12:00:00' ),
	   ( '10', '2', '8:00:00', '12:00:00' ),
	   ( '10', '6', '8:00:00', '12:00:00' ),
	   ( '11', '7', '8:00:00', '12:00:00' ),
	   ( '11', '1', '8:00:00', '12:00:00' ),
	   ( '11', '2', '12:00:00', '16:00:00' ),
	   ( '12', '3', '12:00:00', '16:00:00' ),
	   ( '12', '1', '12:00:00', '16:00:00' ),
	   ( '12', '7', '12:00:00', '16:00:00' ),
	   ( '13', '1', '16:00:00', '20:00:00' ),
	   ( '13', '2', '16:00:00', '20:00:00' ),
	   ( '13', '6', '16:00:00', '20:00:00' ),
	   ( '14', '7', '16:00:00', '20:00:00' ),
	   ( '14', '6', '16:00:00', '20:00:00' ),
	   ( '14', '4', '08:00:00', '20:00:00' ),
	   ( '15', '1', '08:00:00', '20:00:00' ),
	   ( '15', '3', '08:00:00', '20:00:00' ),
	   ( '15', '6', '08:00:00', '12:00:00' );

INSERT INTO InventoryOrders (EmployeeID, OrderDate, OrderTime )
VALUES ('1', '2020-05-15', '10:20:00' ),
	   ('2', '2020-04-25', '13:39:00' ),
	   ('2', '2020-04-21', '15:23:00' ),
	   ('3', '2020-03-12', '10:56:00' ),
	   ('4', '2020-03-18', '08:43:00' ),
	   ('5', '2020-03-03', '09:15:00' ),
	   ('5', '2020-02-28', '09:59:00' ),
	   ('6', '2020-02-12', '14:26:00' ),
	   ('6', '2020-02-04', '17:12:00' ),
	   ('7', '2020-01-29', '20:39:00' ),
	   ('8', '2020-01-15', '12:38:00' ),
	   ('9', '2020-01-12', '03:19:00' ),
	   ('11', '2020-01-05', '09:23:00' );

INSERT INTO Suppliers ( SupplierName, SupplierDescription )
VALUES ( 'ButterFields', 'Main butter supplier' ),
		( 'FlourOfFlowers', 'Main flour supplier' ),
		( 'KingOfCheese', 'Main cream cheese supplier' ),
		( 'NothingButRed', 'Main red food dye supplier' ),
		( 'VanillaIce', 'Main vanilla flavoring supplier' ), 
		( 'ChocolateRUs', 'Main chocolate-related ingredients supplier' ),
		( 'EverydayBirthday', 'Main birthday flavors supplier' ),
		( 'FruitsAndVeggies', 'Main Fruits and vegetables supplier' ), 
		( 'Farmz', 'Main eggs and sour cream supplier' ), 
		( 'RaspberriesAreAwesome', 'Main raspberry filling supplier' ),
		( 'LemonyLemons', 'Main lemon extract supplier' ),
		( 'BakersRUs', 'Main baking powder supplier' );

INSERT INTO Ingredients ( SupplierID, IngredientName, IngredientDescription, InventoryOnHand )
VALUES ( '1', 'Butter', '12 lbs sticks of butter', '30' ),
	  ( '2', 'Flour', '50 lbs bag of flour', '25' ),
	  ( '3', 'Cream Cheese', '25 lbs sticks of cream cheese', '30' ),
	  ( '4', 'Red Food Dye', '20 gal red food shade', '10' ),
	  ( '5', 'Vanilla Flavoring', '15 gal vanilla extract flavoring',  '10' ),
	  ( '6', 'Chocolate Chips', '35 lbs Unsweetened Hersheys Chocolate Chips', '5' ),
	  ( '6', 'Cocoa Powder', '20 lbs bag cocoa powder', '10' ),
	  ( '7', 'Birthday Cake Flavoring', '10 gal natural birthday cake flavoring', '10' ),
	  ( '7', 'Sprinkles', '10 lbs bag colorful sprinkles', '10' ),
	  ( '8', 'Pineapple Chunks', '5 lbs can of pineapples', '30' ),
	  ( '8', 'Carrots', '10 lbs bag of garden carrots', ' 15' ),
	  ( '9', 'Eggs', '20 lbs container of egg yolk', '20' ),
	  ( '9', 'Sour Cream', '15 lbs container of sour cream', '20' ),
	  ( '10', 'Raspberry Filling', '10 lbs container of raspberry filling', '30' ),
	  ( '11', 'Lemon Extract', '15 gal lemon extract', '10' ),
	  ( '12', 'Baking Powder', ' 50 lbs bag of baking powder', '30' );   

INSERT INTO InventoryOrderLines (InventoryOrderID, IngredientID, Quantity, SalesPrice)
VALUES ('8', '3', 4, '2324.29' ),
	('2', '4', '1', '2987.23' ),
	('3','8', '5', '923.20' ),
	('9', '1', '2', '3243.32' ),
	('4', '3', '3', '4349.32' ),
	('13', '3', '8', '2934.59' ),
	('10', '2', '2', '3902.23' ),
	('7', '3', '5', '2093.99' ),
	('1', '11', '4', '3029.23'),
	('2', '2', '4', '4839.02' ),
	('8', '4', '5', '9094.09' ),
	('10', '3', '7', '2930.23' ),
	('12', '8', '4', '7891.39' ),
	('7', '2', '2', '4983.22' );

INSERT INTO Orders (EmployeeID, CustomerID, OrderType, OrderDate, OrderTime)
VALUES ('7', '3', 'P', '2020-01-02', '08:00:00' ),
	('2', '2', 'P', '2020-01-19', '09:30:00' ),
	('4', '3', 'D', '2020-01-03', '010:04:00' ), 
	('9', '1', 'P', '2020-01-05', '11:09:00' ), 
	('7','6', 'D', '2020-01-05', '11:00:00' ),
	('2', '12', 'D', '2020-01-30', '12:00:00' ),
	('12', '2', 'P', '2020-01-20', '03:00:00' ),
	( '7', '8', 'P', '2020-02-04', '07:00:00' ),
	('1', '9', 'P', '2020-02-01', '07:00:00' ),
	('5', '10', 'D', '2020-02-11', '07:00:00' ),
	('2', '12', 'P', '2020-02-015', '08:00:00' ),
	('9', '2', 'D', '2020-03-20', '09:00:00' ),
	('1', '3', 'D', '2020-03-02', '06:00:00' ),
	('1', '3', 'P', '2020-03-01', '22:00:00' ),
	('1', '3', 'P', '2020-03-09', '21:00:00' ),
	('2', '4', 'D', '2020-03-11', '20:00:00' ),
	('3', '9', 'P', '2020-03-29', '19:00:00' ),
	('3', '11', 'D', '2020-03-28', '18:00:00' ),
	('2', '2', 'P', '2020-04-20', '17:00:00' ),
	('4', '2', 'D', '2020-04-04', '18:00:00' ),
	('5', '9', 'P', '2020-04-09', '16:00:00' ),
	('6', '12', 'P', '2020-04-11', '20:00:00' ),
	('3', '1', 'P', '2020-04-29', '08:00:00' ),
	('1', '3', 'D', '2020-05-30', '03:00:00' ),
	('9', '5', 'P', '2020-05-21', '06:00:00' ),
	('10', '7','D', '2020-05-01', '09:00:00' ),
	('1', '7', 'P', '2020-05-13', '08:00:00' ),
	('12', '7', 'P', '2020-06-07', '07:00:00' ),
	('7', '8', 'D', '2020-06-13', '14:00:00' ),
	('7', '9', 'D', '2020-06-07', '13:00:00' ), 
	('9', '11', 'P', '2020-06-19', '11:00:00' ),
	('1', '10', 'P', '2020-06-01', '10:00:00' ), 
	('4', '10', 'P', '2020-07-12', '10:00:00' ),
	('6', '9', 'D', '2020-07-08', '12:00:00' ), 
	('6', '2', 'P', '2020-07-20', '12:00:00' ),
	('7', '2', 'P', '2020-07-03', '15:00:00' ), 
	('2', '3', 'D', '2020-07-07', '17:00:00' );

INSERT INTO DeliveryOrders (OrderID, DeliveryDriver, DeliveryDate, DeliveryTime)
VALUES ('3', 'Sharon', '2020-01-09', '12:00:00'),
		('5', 'Kathryn', '2020-01-09', '09:00'),
		('6', 'Kathryn', '2020-02-01', '09:00'),
		('10', 'Jeremy', '2020-02-22', '09:00'),
		('12', 'Jeremy', '2020-03-21', '09:00'),
		('13', 'John', '2020-03-09', '09:00'),
		('16', 'Jeremy', '2020-03-14', '09:00'),
		('18', 'Jeremy', '2020-03-30', '09:00'),
		('20', 'John', '2020-04-10', '09:00'),
		('24', 'Jeremy', '2020-05-30', '09:00'),
		('26', 'Jeremy', '2020-05-02', '09:00'),
		('29', 'Carson', '2020-06-15', '09:00'),
		('30', 'Carson', '2020-06-08', '09:00'),
		('34', 'Carson', '2020-07-21', '09:00'),
		('37', 'Sally', '2020-07-08', '09:00');

INSERT INTO PickupOrders (OrderID, PickupEmployee, PickupDate, PickupTime)
VALUES ('1', 'Kathryn', '2020-01-05', '12:30:00'),
		('2', 'Sharon', '2020-01-20', '14:45:00'),
		('4', 'Kathryn', '2020-01-10', '13:15:00'),
		('7', 'Kathryn', '2020-02-04', '09:00'),
		('8', 'Kathryn', '2020-02-07', '09:00'),
		('9', 'Jeremy', '2020-02-09', '09:00'),
		('11', 'Jeremy', '2020-02-28', '09:00'),
		('14', 'John', '2020-03-05', '09:00'),
		('15', 'Jeremy', '2020-03-11', '09:00'),
		('17', 'Jeremy', '2020-03-30', '09:00'),
		('19', 'John', '2020-04-21', '09:00'),
		('21', 'John', '2020-04-12', '09:00'),
		('22', 'Jeremy', '2020-04-28', '09:00'),
		('23', 'Jeremy', '2020-04-30', '09:00'),
		('25', 'John', '2020-05-22', '09:00'),
		('27', 'Jeremy', '2020-05-14', '09:00'),
		('28', 'Carson', '2020-06-09', '09:00'),
		('31', 'Jeremy', '2020-06-22', '09:00'),
		('32', 'Jeremy', '2020-06-09', '09:00'),
		('33', 'Jeremy', '2020-07-13', '09:00'),
		('35', 'Sally', '2020-07-24', '09:00'),
		('36', 'Sally', '2020-07-04', '09:00');

INSERT INTO OrderLines (OrderID, ProductID, Quantity, SalesPrice)
VALUES ('1', '4', '3', '120.99'),
		('2', '2', '1', '55.93'),
		('3', '2', '3', '150.99'),
        ('4', '2', '3', '150.99'),
		('5', '12', '1', '67.00'),
        ('6', '2', '3', '150.99'),
		('7', '12', '1', '67.00'),
        ('8', '2', '3', '150.99'),
		('9', '3', '1', '67.00'),
        ('10', '2', '3', '150.99'),
		('11', '12', '1', '67.00'),
        ('12', '2', '3', '150.99'),
		('13', '12', '1', '67.00'),
		('14', '12', '1', '67.00'),
		('15', '7', '5', '1002.23'),
		('16', '9', '2', '90.32'), 
		('17', '10', '4', '902.76'),
		('18', '11', '6', '832.99'),
		('19', '5', '9', '1203.23'),
		('20', '1', '3', '289.99'),
		('21', '11', '4', '390.23'),
        ('22', '2', '3', '150.99'),
		('23', '12', '1', '67.00'),
        ('24', '2', '3', '150.99'),
		('25', '12', '1', '67.00'),
        ('26', '2', '3', '150.99'),
		('27', '2', '3', '150.99'),
		('28', '12', '1', '67.00'),
		('29', '12', '1', '67.00'),
		('30', '7', '5', '1002.23'),
        ('31', '2', '3', '150.99'),
		('32', '5', '1', '67.00'),
		('33', '7', '1', '67.00'),
		('34', '7', '5', '1002.23'),
		('35', '14', '2', '90.32'), 
		('36', '9', '4', '902.76'),
		('37', '1', '6', '832.99'),
		('1', '9', '9', '1203.23'),
		('2', '11', '3', '289.99'),
		('3', '3', '4', '390.23'),
		('4', '9', '2', '90.32'), 
		('5', '10', '4', '902.76'),
		('6', '11', '6', '832.99'),
		('7', '5', '9', '1203.23'),
		('8', '1', '3', '289.99'),
		('9', '7', '4', '390.23'),
		('10', '14', '1', '67.00'),
		('1', '1', '1', '67.00'),
		('12', '7', '5', '1002.23'),
		('13', '5', '2', '90.32'), 
		('14', '10', '4', '902.76'),
		('15', '11', '6', '832.99'),
		('16', '14', '9', '1203.23'),
		('17', '1', '3', '289.99'),
		('18', '3', '4', '390.23'),
		('19', '2', '10', '1039.03');

