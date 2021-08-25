
/* /////////////////////
 PHONE SHOP DATABASE 
///////////////////// */


--A) Tworzenie bazy danych wraz z danymi


/* 1) Tworzenie tabeli: TOWAR  */  

CREATE TABLE Phone_status
( 
ID_Phone_status INT IDENTITY(1,1) PRIMARY KEY, 
Model VARCHAR(20) NOT NULL,
Color VARCHAR(20) NOT NULL,
Capacity VARCHAR(5) NOT NULL,
Imei_number BIGINT NOT NULL,
Purchase_price VARCHAR(10),
Purchase_date DATE,
Sale_price VARCHAR(10), 
Sale_date DATE
);
/*Quantity INT);
  Cost_of_repair VARCHAR(10),
 Purchase_price VARCHAR(10),
 Purchase_date DATE,
 Sale_price VARCHAR(10), 
 Sale_date DATE); */

/* 1) Zalaczanie rekordow do tabeli: TOWAR */
 
 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)  
  VALUES ('iPhone XS MAX', 'Black', '256GB', '726856190183817', '1300', '2021-07-24', '1800', '2021-08-01');                    

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)    
  VALUES ('iPhone X', 'Black', '64GB', '615825185801852', '800', '2021-06-14', '1350', '2021-08-05');

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)    
  VALUES ('iPhone X', 'Silver', '64GB', '857151925712795', '900', '2021-07-01', '1400', '2021-07-18');

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)    
  VALUES ('iPhone XR', 'Black', '64GB', '891738149143989', '850', '2021-07-24', '1450', '2021-08-05');
 
 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)   
  VALUES ('iPhone XR', 'Red', '256GB', '573452523241341', '900', '2021-06-29', '1450', '2021-07-16');
 
 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)   
  VALUES ('iPhone XR', 'Blue', '64GB', '942727234242362', '850', '2021-06-24', '1450', '2021-06-24');

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)   
  VALUES ('iPhone 12', 'Black', '64GB', '713515141232133', '2000', '2021-08-15', '2800', '2021-08-19');

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)   
  VALUES ('iPhone 11', 'White', '64GB', '584214012501250', '1100', '2021-08-02', '2000', '2021-08-11');

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)    
  VALUES ('iPhone 11 PRO', 'Orchid Gray', '256GB', '272136872523534', '1950', '2021-06-04', '2500', '2021-06-30');

 INSERT INTO Phone_status ( Model, Color, Capacity, Imei_number, Purchase_price, Purchase_date, Sale_price, Sale_date)  
  VALUES ('iPhone XS', 'Gold', '128GB', '178455324543723', '800', '2021-06-05', '1550', '2021-06-12');  

/* 2) Tworzenie tabeli: KLIENT */ 

CREATE TABLE Client (
ID_Client INT IDENTITY(1,1) PRIMARY KEY,
ID_Phone_status INT,  /* NOT NULL REFERENCES Phone_status(ID_Phone_status), */
Namee  VARCHAR(40) NOT NULL CHECK(LEN(Namee)>2),
Surname VARCHAR(40) NOT NULL CHECK(LEN(Surname)>2),
Phone_number VARCHAR(12) NOT NULL,
Email VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL CHECK(LEN(City)>2),
Nr_house INT NOT NULL,
Post_code CHAR(6) NOT NULL,
Street VARCHAR(40) 
);
/* AKTUALIZACJA - Ulica musi zostaæ podana w danych ze wzgledu na pozniejszy zakup.
Zalaczam w typie danych NOT NULL, zeby w tym miejscu klient wpisal niezbedne informacje. */
ALTER TABLE Client ALTER COLUMN Street VARCHAR(40) NOT NULL
 
/* 2) Zalaczanie rekordow do tabeli: KLIENT */

INSERT INTO Client ( Namee, Surname, Phone_number, Email, City, Nr_house, Post_code, Street ) VALUES 
('Jan','Kowalski',+48954120125,'jankowalski@phoneshop.com','Warsaw',6,'00-002','Warszawska'),
('Dominik','Nowak',+48956233142,'dominiknowak@phoneshop.com','Cracow',23,'30-010','Lokietka'),
('Janusz','Wojcik',+48955347145,'januszwojcik@phoneshop.com','Kielce',7,'25-553','Klonowa'),
('Miroslaw','Kowalczyk',+48909554635,'miroslawkowalczyk@phoneshop.com','Wroclaw',11,'50-339','Nowowiejska'),
('Rafal','Wisniewski',+48996253236,'rafalwisniewski@phoneshop.com','Gdynia',19,'81-368','Swiêtojanska'),
('Waldemar','Lewandowski',+48915634650,'waldemarlewandowski@phoneshop.com','Zakopane',66,'34-500','Krupowki'),
('Ignacy','Kowalewicz',+48945734353,'ignacykowalewicz@phoneshop.com','Zabrze',1,'41-800','3 Maja'),
('Grzegorz','Kaminski',+48996574569,'grzegorzkaminski@phoneshop.com','Dabrowa-Gornicza',9,'41-303','Pilsudskiego');


/* 3) Tworzenie tabeli: ZAMOWIENIA */ 
 
CREATE TABLE Orders (
ID_Orders INT IDENTITY(1,1) PRIMARY KEY,
ID_Phone_status INT NULL, 
ID_Client INT NULL,
Date_Of_Submission DATE  );

/*  
-------------------------------

 Proba stworzenia klucza obcego w celu stworzenia relacji pomiêdzy tabelami, a w nich wystêpujacymi kolumnami.
 Finalnie relacje stworzylem manualnie w SSMS.
 
 -------------------------------
ADD CONSTRAINT FK_ID_Client FOREIGN KEY (ID_Orders) REFERENCES Client(ID_Client) );
-------------------------------
ID_Phone_status INT NULL REFERENCES Phone_status(ID_Phone_status), 
ID_Client INT NULL REFERENCES Client(ID_Client),
-------------------------------
CONSTRAINT FK_ID_Client FOREIGN KEY (ID_Client) REFERENCES Client(ID_Client) ?
Date_Of_Submission DATE 
-------------------------------
ALTER TABLE Orders
   ADD CONSTRAINT FK_Client FOREIGN KEY (ID_Orders)
      REFERENCES dbo.Client (ID_Client)
      ON DELETE CASCADE
      ON UPDATE CASCADE
-------------------------------
*/

/* 3) Zalaczanie rekordow do tabeli: ZAMOWIENIA */

INSERT INTO Orders VALUES 
(6,2,'2012-07-20'),
(7,1,'2012-07-15'),
(4,3,'2012-07-03'),
(5,7,'2012-07-20'),
(2,6,'2012-07-15'),
(1,5,'2012-07-03'),
(3,4,'2012-07-20');


/* 4) Tworzenie tabeli: USLUGA */

CREATE TABLE Repair_service (
ID_Repair_service INT IDENTITY(1,1) PRIMARY KEY,
ID_Employee INT,
ID_Client INT, 
Cost SMALLINT,
Model VARCHAR(20) NOT NULL,
Imei_number VARCHAR(50) NOT NULL,
What_service VARCHAR(100)
);
 drop table employee

/* 4) Zalaczanie rekordow do tabeli: USLUGA */

INSERT INTO Repair_service ( Cost, Model, Imei_number, What_service ) VALUES 
( 600,'iPhone X','837465324543723','Crack LCD - Exchange for a new replacement display'),
(350,'iPhone 7','957324598503856','AudioIC - No sound while recording and the recorder doesnt work'),
(350,'iPhone 7','437465324543423','Wifi grayed out - is not possible to turn on wifi function because the buttom it is gray in options'),
(500,'iPhone XR','750738598512543','Broken rear glass - Exchange for a new replacement body'),
(1200,'iPhone 11 PRO MAX','728665324591064','Broken LCD- Exchange for a new replacement display'),
(900,'iPhone 11 PRO','790511059715920','No network- GSM system repair, Baseband');

/* 5) Tworzenie tabeli: PRACOWNIK */  

CREATE TABLE Employee (
ID_Employee INT IDENTITY(1,1) PRIMARY KEY,
ID_Repair_service INT,
First_name NVARCHAR(25), 
Last_name NVARCHAR(25), 
Birthday DATE,
Sex VARCHAR(1),
Salary INT
);

/*	CREATE TABLE Orders (
ID_Orders INT IDENTITY(1,1) PRIMARY KEY,
ID_Phone_status INT NULL REFERENCES Phone_status(ID_Phone_status), 
ID_Client INT NULL REFERENCES Client(ID_Client),
Date_Of_Submission DATE  */


/*  5) Zalaczanie rekordow do tabeli: PRACOWNIK */

INSERT INTO Employee ( First_name, Last_name, Birthday, Sex, Salary ) VALUES 
('Marek','Mostowiak','1976-06-21','M',4500),
('Marcin','Najman','1979-03-13','M',5200),
('Piotr','Witczak','1989-07-15','M',3500);

 /* 6) Tworzenie tabeli: KURS DOSZKALAJACY Z ZAKRESU NAPRAW*/ 

CREATE TABLE Training_course (
ID_Training_course INT IDENTITY(1,1) PRIMARY KEY,
ID_Employee INT,
Result VARCHAR(25) NOT NULL   /* Passed or Failed */
);

Drop TABLE Training_course

/* 6) Zalaczanie rekordow do tabeli: KURS */
INSERT INTO Training_course ( ID_Employee, Result ) VALUES 
('1', 'Passed'),
('2', 'Passed'),
('3', 'Passed');



--B) Tworzenie widokow + komendy

/* Sprawdzanie czy istnieje widok "Phone_status_View" */

IF EXISTS (SELECT * FROM sys.views WHERE name = 'Phone_status_View')
DROP VIEW Phone_status_View;
GO

--1)
CREATE VIEW Phone_status_View AS
SELECT *
FROM Phone_status ;

--2)
CREATE VIEW Client_View AS
SELECT *
FROM Client ;

--3)
CREATE VIEW Orders_View AS
SELECT *
FROM Orders ;

--4)
CREATE VIEW Repair_service_View AS
SELECT *
FROM Repair_service ;

--5)
CREATE VIEW Employee_View AS
SELECT *
FROM Employee ;

--6)
CREATE VIEW Training_course_View AS
SELECT *
FROM Training_course ;

 
-- USUWANIE TABEL --

DROP TABLE Phone_status
GO
DROP TABLE Client
GO
DROP TABLE Orders
GO
DROP TABLE Repair_service
GO
DROP TABLE Employee
GO
DROP TABLE Training_course
GO
 
--USUWANIE WIDOKOW --

DROP VIEW Phone_status_View
GO
DROP VIEW Client_View
GO
DROP VIEW Orders_View
GO
DROP VIEW Repair_service_View
GO
DROP VIEW Employee_View
GO
DROP VIEW Training_course_View
GO

-- SPRAWDZANIE DANYCH --

SELECT *
FROM Phone_status_View

SELECT *
FROM Client_View

SELECT *
FROM Orders_View

SELECT *
FROM Repair_service_View

SELECT *
FROM Employee_View

SELECT *
FROM Training_course_View