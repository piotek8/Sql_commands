
CEILING(12.34),
CEILING(-12.34)
--------------------
SELECT FLOOR(12.34),
FLOOR(-12.34),
ROUND (-12.34,0),
CEILING(12.34),
CEILING(-12.34),
ROUND (12.34,0)
--------------------

AGGREGATE FUNCTIONS

--------------------
SELECT sum(sickleavehours)
FROM HumanResources.Employee;
--------------------
SELECT sum(sickleavehours)/8 "Liczba dni chorobowych"
FROM HumanResources.Employee;
--------------------
SELECT MAX(Vacationhours) as "The highest number of hours",
	   MIN(HireDate) as "The oldest date of employment",
	   MAX(JobTitle) as "Last position in line"
FROM HumanResources.Employee;
--------------------
SELECT COUNT (*) AS "The number of records"
FROM Sales.SpecialOffer;
--------------------
SELECT COUNT(MaxQty) AS "The number of records"
FROM Sales.SpecialOffer;
--------------------
SELECT COUNT(distinct type) as "The number of unique records"
FROM Sales.SpecialOffer;
--------------------
SELECT AVG(ISNULL(MaxQty,0)) AS "Average of all fields in the MaxQty column"
FROM Sales.SpecialOffer;
--------------------

GROUPING

--------------------
SELECT SUM(VacationHours)/2 AS "SUM FREE HOURS"
FROM HumanResources.Employee;
--------------------
SELECT JobTitle,Gender, SUM(VacationHours) AS "SUM FREE HOURS"
FROM HumanResources.Employee
GROUP BY JobTitle,Gender;
--------------------
SELECT SUM(SalesYTD),
	   MAX(SalesYTD),
	   MIN(SalesYTD),
	   AVG(SalesYTD)
FROM Sales.SalesPerson
GROUP BY TerritoryID;
--------------------
SELECT JobTitle,Gender, SUM(VacationHours) AS "SUM FREE HOURS"
FROM HumanResources.Employee
WHERE MaritalStatus='M'
GROUP BY Gender,JobTitle;
--------------------
SELECT JobTitle,Gender, SUM(VacationHours) AS "SUM FREE HOURS"
FROM HumanResources.Employee
GROUP BY Gender,JobTitle 
HAVING SUM(VacationHours)>60;
--------------------

CASE

--------------------
SELECT Name,
		CASE Name WHEN 'English' THEN 'Angielski'
				  WHEN 'Spanish' THEN 'Hiszpa�ski'
				  WHEN 'French' THEN 'Francuski'
END
FROM Production.Culture;
--------------------
SELECT Name,
		CASE Name WHEN 'English' THEN 'Angielski'
				  WHEN 'Spanish' THEN 'Hiszpa�ski'
				  WHEN 'French' THEN 'Francuski'
				  else 'Do not know this language'
END AS "New Column"
FROM Production.Culture;
--------------------
SELECT Name,
		CASE Name WHEN 'English' THEN 'Angielski'
				  WHEN 'Spanish' THEN 'Hiszpa�ski'
				  WHEN 'French' THEN 'Francuski'
				  WHEN 'Thai' THEN left (name,8)
				  WHEN 'Arabic' THEN CONVERT(varchar,GETDATE(),102)
				  else 'Do not know this language'
END
FROM Production.Culture;
--------------------
SELECT Name,
		CASE Name WHEN 'English' THEN 'Angielski'
				  WHEN 'Spanish' THEN 'Hiszpa�ski'
				  WHEN 'French' THEN 'Francuski'
				  WHEN 'Thai' THEN left (name,8)
				  WHEN 'Arabic' THEN CONVERT(varchar,GETDATE(),102)
				  else  Name
END AS "New column"
FROM Production.Culture;
--------------------
SELECT	BusinessEntityID,Gender,VacationHours,
		CASE Gender WHEN 'F' THEN VacationHours + 16
		ELSE VacationHours
END AS "Free after change"
FROM HumanResources.Employee;
--------------------
SELECT Description, DiscountPct, Type,
	   CASE WHEN DiscountPct <= 0.1 THEN 'LITTLE DISCOUNT'
	        WHEN DiscountPct <= 0.2 THEN 'MEDIUM DISCOUNT'
	        WHEN DiscountPct <= 0.3 THEN 'BIG DISCOUNT'
	        WHEN DiscountPct <= 0.4 THEN 'VERY BIG DISCOUNT'
	   ELSE 'ALMOST FREE FOR EVERYTHING'
END AS 'State of discount'
FROM Sales.SpecialOffer;
--------------------
SELECT SalesYTD,SalesLastYear,
	   CASE WHEN SalesYTD>SalesLastYear THEN 'More than last year'
	   ELSE 'Stay' + CAST(SalesLastYear-SalesYTD as char)
	   END AS 'Comparison of years'
FROM Sales.SalesPerson;
---------------------
SELECT	BusinessEntityID,MaritalStatus,Gender,VacationHours,
		CASE WHEN MaritalStatus='M' and Gender='F' THEN VacationHours + 32
		 WHEN Gender= 'F' THEN VacationHours + 17
		ELSE VacationHours
END AS "Free after change"
FROM HumanResources.Employee;
---------------------

FUNCTIONS OF TEXT

---------------------
SELECT LOWER('LUBI� PISA� SKRYPTY');
---------------------
SELECT UPPER('LUBI� PISA� SKRYPTY');
---------------------
SELECT LEFT('LUBI� PISA� SKRYPTY',2);
---------------------
SELECT RIGHT('LUBI� PISA� SKRYPTY',2);
---------------------
SELECT SUBSTRING('LUBI� PISA� SKRYPTY',4,4);
---------------------
SELECT LEN('LUBI� PISA� SKRYPTY');
---------------------
SELECT CHARINDEX('S','LUBI� PISA� SKRYPTY',2);
---------------------
SELECT REVERSE('LUBI� PISA� SKRYPTY');
---------------------
SELECT UPPER(REVERSE('LUBI� PISA� SKRYPTY'));
---------------------
SELECT REPLACE('LUBI� PISA� SKRYPTY','skrypty','Do Ciebie');
---------------------
SELECT LTRIM('     LUBI� PISA� SKRYPTY'      );
---------------------
SELECT REPLICATE(' LUBI� PISA� SKRYPTY',12321);
---------------------
SELECT STUFF('LUBI� PISA� SKRYPTY',4,15,'John');
---------------------

FUNCTIONS OF DATE

---------------------
SELECT @@DATEFIRST
---------------------
SET DATEFIRST 1;
---------------------
SELECT @@LANGUAGE
---------------------
SP_HELPLANGUAGE
---------------------
SET LANGUAGE POLISH
---------------------
SELECT DATENAME(weekday,getdate());
---------------------
SET DATEFORMAT ymd;
---------------------
SELECT '2021.03.24' as "Date", MONTH('2021.03.24') as "Month", DAY('2021.03.04'), YEAR('2021.03.04');
---------------------
SET LANGUAGE English;
---------------------
SELECT  ROUND() DATEADD(YEAR,3,getdate());
---------------------
SELECT DATEDIFF (month,'2015-06-29', getdate()); 
---------------------
SELECT DATENAME(DAYOFYEAR,GETDATE());
---------------------
SELECT DATEPART(Weekday,Getdate());
---------------------
SELECT DAY(GETDATE()),MONTH(GETDATE()),YEAR(GETDATE());
----------------------
SELECT DATEFROMPARTS(2021,03,24);
----------------------

INNER JOIN

----------------------
SELECT *
FROM HumanResources.EmployeeDepartmentHistory;
----------------------
SELECT *
FROM HumanResources.Shift;
----------------------
SELECT *
FROM HumanResources.EmployeeDepartmentHistory,HumanResources.Shift;
----------------------
SELECT EDH.BusinessEntityID,P.FirstName,P.LastName,s.Name
FROM HumanResources.EmployeeDepartmentHistory AS EDH
iNNER JOIN HumanResources.Shift AS PB ON EDH.ShiftID=PB.ShiftID
INNER JOIN Person.person AS PB ON EDH.BusinessEntityID=P.BusinessEntityID
ORDER BY BusinessEntityID;
----------------------

TYPES OF JOINS

----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
INNER JOIN Production.Document AS D ON E.OrganizationNode=D.DocumentNode;
----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
LEFT OUTER JOIN Production.Document AS D ON E.OrganizationNode=D.DocumentNode;
----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
RIGHT JOIN Production.Document AS D ON E.OrganizationNode=D.DocumentNode;
----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
FULL JOIN Production.Document AS D ON E.OrganizationNode=D.DocumentNode;
----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
CROSS JOIN Production.Document AS D;
----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
INNER JOIN Production.Document AS D ON E.OrganizationNode=D.DocumentNode
WHERE D.DocumentLevel=1;
----------------------
SELECT e.OrganizationNode,D.*
FROM HumanResources.Employee AS E
INNER JOIN Production.Document AS D ON E.OrganizationNode=D.DocumentNode
AND D.DocumentLevel=1;
----------------------
select E.organizationnode, D.*
from HumanResources.Employee as E
cross join Production.Document as D
where DocumentLevel = 2;
----------------------

SUBQUERIES --PODZAPYTANIA

----------------------
SELECT BusinessEntityID,VacationHours
FROM HumanResources.Employee
WHERE VacationHours>(SELECT VacationHours
					 FROM HumanResources.Employee
					 WHERE BusinessEntityID=49 );
----------------------
SELECT BusinessEntityID,VacationHours, MaritalStatus
FROM HumanResources.Employee
WHERE VacationHours>(SELECT VacationHours
					 FROM HumanResources.Employee
					 WHERE BusinessEntityID=49 )
AND MaritalStatus=(SELECT MaritalStatus
				   FROM HumanResources.Employee
				   WHERE BusinessEntityID=49 );
----------------------
SELECT BusinessEntityID,VacationHours
FROM HumanResources.Employee
WHERE VacationHours=(SELECT MAX(VacationHours)
					 FROM HumanResources.Employee);
----------------------
SELECT JobTitle,AVG(VacationHours) AS "The sum of the free hours for the position"
FROM HumanResources.Employee 
GROUP BY JobTitle
HAVING AVG(VacationHours) > (SELECT AVG(VacationHours)
							 FROM HumanResources.Employee;
----------------------
SELECT *
FROM (SELECT BusinessEntityID,VacationHours
	  FROM HumanResources.Employee) AS "TYPES OF JOINS"
WHERE BusinessEntityID BETWEEN 100 AND 150;
----------------------
SELECT * 
FROM Person.BusinessEntityAddress;
----------------------
SELECT * 
FROM Person.Address;
----------------------
SELECT B.BusinessEntityID,
	   (SELECT City	
	   FROM Person.Address AS A
	   WHERE B.AddressID=A.AddressID) AS "City"
FROM Person.BusinessEntityAddres AS B;
----------------------
SELECT B.BusinessEntityID,A.City
FROM Person.BusinessEntityAddress AS B
INNER JOIN Person.Address AS A ON B.AddressID=A.AddressID;
----------------------

MULTILINE SUBQUERIES --PODZAPYTANIA WIELOWIERSZOWE

----------------------
SELECT DISTINCT NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE YearOpened='1990';
----------------------
SELECT Name,YearOpened,NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE NumberEmployees in (SELECT NumberEmployees
						  FROM Sales.vStoreWithDemographics
					      WHERE YearOpened='1990')
AND YearOpened<>'1990'
ORDER BY NumberEmployees;
----------------------
SELECT DISTINCT NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE YearOpened='1990';
----------------------
SELECT Name,YearOpened,NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE NumberEmployees < ANY  (SELECT NumberEmployees
						  FROM Sales.vStoreWithDemographics
					      WHERE YearOpened='1990')
AND YearOpened<>'1990'
ORDER BY YearOpened DESC;
----------------------
SELECT Name,YearOpened,NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE NumberEmployees < ALL  (SELECT NumberEmployees
						  FROM Sales.vStoreWithDemographics
					      WHERE YearOpened='1990')
AND YearOpened<>'1990'
ORDER BY YearOpened DESC;
-----------------------
SELECT E.OrganizationNode,D.*	
FROM Production.Document as D 
LEFT JOIN HumanResources.Employee AS E ON D.DocumentNode=E.OrganizationNode;
-----------------------
SELECT *	
FROM Production.Document as D 
WHERE not exists
(SELECT *
FROM HumanResources.Employee AS E
WHERE D.DocumentNode=E.OrganizationNode);
-----------------------
SELECT *
FROM HumanResources.Employee
WHERE BusinessEntityID not in
					   (SELECT BusinessEntityID
					   FROM HumanResources.JobCandidate
					   WHERE BusinessEntityID is not null); /* Musi by� bo nic nie zwr�ci */ 
-----------------------

CREATE AND MODIFYING TABLES NAD VIEWS 

-----------------------
CREATE TABLE HumanResources.Little_Childrens
(
ID INT,
Name varchar(255),
Surname varchar(255),
Age INT,
"Date_of_Birth" DATE,
Weight INT,
Length INT );

SELECT *
FROM HumanResources.Little_Childrens;
/* Nothing, because There is no date */ 
-----------------------
SELECT BusinessEntityID,FirstName,LastName,Title,PersonType
INTO HumanResources.Parents
FROM Person.Person
WHERE LastName LIKE 'S%' AND BusinessEntityID BETWEEN 1 AND 290;

/* F O R   C H E C K */ 
SELECT *
FROM HumanResources.Parents;

SELECT *
FROM HumanResources.Little_Childrens;
-----------------------
ALTER TABLE HumanResources.Little_Childrens
ADD City varchar(30);
-----------------------
ALTER TABLE HumanResources.Little_Childrens
ALTER COLUMN City INT ;
-----------------------
ALTER TABLE HumanResources.Little_Childrens
DROP COLUMN City;
-----------------------
SP_RENAME 'HumanResources.Small_Children','Small_Childrens';

SP_RENAME 'HumanResources.Small_Childrens.Age','Current_Age1','column';

/* F O R   C H E C K */ 
SELECT *
FROM HumanResources.Small_Childrens;
-----------------------
SELECT TOP 15 SalesOrderID, SUM(Unitprice) AS Sum 
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY Sum ASC;
-----------------------
CREATE VIEW Sales.The_Largest_15_Orders AS
SELECT TOP 15 SalesOrderID, SUM(Unitprice) AS Sum	
FROM Sales.SalesOrderDetail	
GROUP BY SalesOrderID
ORDER BY Sum DESC;

/* F O R   C H E C K */ 
SELECT *
FROM Sales.The_Largest_15_Orders;
-----------------------

DATA INPUT

----------------------- 
-- P O    P O L S K U

CREATE TABLE HumanResources.Dzieciaczki
(
ID INT,
Imie varchar,
Nazwisko nvarchar,
Wiek INT,
Aktualny_Wiek INT,
Data_urodzenia DATE
/* AktualnyWiek INT */ );

-----------------------
ALTER TABLE HumanResources.Dzieciaczki
ADD Wiek int
-----------------------
INSERT INTO HumanResources.Dzieciaczki VALUES(1,'Ada�','Noga',5,'20140101');
-----------------------
SELECT *
FROM HumanResources.Dzieciaczki;
-----------------------
DELETE FROM HumanResources.Dzieciaczki;
-----------------------
INSERT INTO HumanResources.Dzieciaczki (Aktualny_wiek,nazwisko, imie, id)
VALUES (3, 'R�ka','Micha�',1);

INSERT INTO HumanResources.Dzieciaczki (Aktualny_wiek,nazwisko, imie, id)
VALUES (4, '�okie�','Micha�',2);

INSERT INTO HumanResources.Dzieciaczki (Aktualny_wiek,nazwisko, imie, id)
VALUES (31, 'Kolano','Micha�',3);

INSERT INTO HumanResources.Dzieciaczki (Aktualny_wiek,nazwisko, imie, id)
VALUES (24, 'Noga','Micha�',4);
-----------------------
ALTER TABLE HumanResources.Dzieciaczki
ALTER COLUMN ID INT NOT NULL;
-----------------------
ALTER TABLE HumanResources.Dzieciaczki
ADD CONSTRAINT Klucz_ID PRIMARY KEY(ID);
-----------------------
ALTER TABLE HumanResources.Dzieciaczki
ADD UNIQUE(ID);
-----------------------
INSERT INTO HumanResources.Dzieciaczki 
VALUES (23,'G�owa','Dominik',1); --THIS ONE--
/* NOT WORKING BECAUSE PRIMARY KEY IS WRITTEN ABOVE, IT CAN NOT MAKE THE SAME VALUE AGAIN) */
 ----------------------
 
 CREATE TABLE HumanResources.Dzieci
 (id INT not null Identity(1,1)CONSTRAINT Klucz_id_dzieci PRIMARY KEY, 
 Imie varchar(255),
 Nazwisko varchar(255),
 Wiek INT,
 Aktualny_Wiek INT,
 Data_urodzenia Date );
 ----------------------
 ALTER TABLE HumanResources.Dzieci
 ADD STATUS varchar(10) default 'Przyj�ty';
 ----------------------
 INSERT INTO HumanResources.Dzieci(Imie,Nazwisko,Wiek,Data_urodzenia)
 VALUES ('Darek','Kanar',12,'20190101');
 ----------------------
 INSERT INTO HumanResources.Dzieci(Imie,Nazwisko,Wiek,Data_urodzenia,Status)
 VALUES ('Andrzej','Kanar',7,'20110621','Odrzucony');
 
 SELECT *
 FROM HumanResources.Dzieci;
 ----------------------
 SELECT *
 FROM HumanResources.Parents;

 ROLLBACK HumanResources.Parents;



/* FAIL *//* FAIL *//* FAIL *//* FAIL *//* FAIL */
--                       B E L O W
INSERT INTO HumanResources.Small_Childrens values ( 1,'Johny','Bravo',5,'20101213');


INSERT INTO HumanResources.Little_Childrens (Age,Surname, Name, ID,Date_of_Birth)
VALUES (15,'Bravo','Johny',1,20120110);

INSERT INTO HumanResources.Little_Childrens (Age,Surname, Name, ID,Date_of_Birth)
VALUES (15,'Smith','Johny',2,2012-01-10);

INSERT INTO HumanResources.Little_Childrens (Age,Surname, Name, ID,Date_of_Birth)
VALUES (15,'Cloney','Johny',3,2012-01-10);

INSERT INTO HumanResources.Little_Childrens (Age,Surname, Name, ID,Date_of_Birth)
VALUES (15,'Dac','Johny',4,2012-01-10);
-----------------------
SELECT *
FROM HumanResources.Little_Childrens; 
--                        A B O V E
/* FAIL *//* FAIL *//* FAIL *//* FAIL *//* FAIL */

-----------------------

MODIFICATIONS AND DELETION DATA

-----------------------
SELECT *
FROM HumanResources.Dzieciaczki;
-----------------------
UPDATE HumanResources.Dzieciaczki
SET Nazwisko='Byk'
WHERE ID= 2;
-----------------------
