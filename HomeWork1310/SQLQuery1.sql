CREATE DATABASE DemoApp2

USE DemoApp2


CREATE TABLE Countries(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL UNIQUE,
	Areas decimal CHECK(Areas>0)
	)

CREATE TABLE Cities(

	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL UNIQUE,
	Areas decimal(8,2) CHECK(Areas>0),
	ContriesId  int FOREIGN KEY REFERENCES Countries(Id)
)


CREATE TABLE People(

	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) NOT NULL ,
	Surname nvarchar(50) NOT NULL ,
	PhoneNumber nvarchar(50) NOT NULL UNIQUE,
	Email nvarchar(50) NOT NULL UNIQUE,
	Age int CHECK(Age>0),
	Gender nvarchar(50) NOT NULL,
	HasCitizenship BIT,
	CityId int FOREIGN KEY REFERENCES Cities(Id)
	
)

DROP TABLE People

SELECT*FROM Countries
SELECT*FROM Cities
SELECT*FROM People

INSERT INTO Countries
VALUES('Azerbaycan',86660.5),
('Ingiltere',54454.5),
('Ukranie',54545.6),
('Turkiye',451215.5)

INSERT INTO Countries
VALUES('Iran',10000.5)

INSERT INTO Cities
VALUES('Baki',4512.5,1),
('Sumqayit',4512.2,1),
('GEDEBEY',54551.2,1),
('London',45.2,2),
('Manceshter',112.5,2),
('Kiev',150.2,3),
('Istanbul',4515.2,4)


INSERT INTO People
VALUES('Tural','Ismayilov','+994998596919','tural@gmail.com',20,'MALE',1,1),
('Emil','Guluzade','+994998596920','emil@gmail.com',20,'MALE',1,2),
('Faig','Resulzade','+994998596921','faig@gmail.com',20,'MALE',1,3),
('Beyler','Sadigov','+994998596922','beyler@gmail.com',20,'MALE',1,4),
('Mirgubad','Akberov','+994998596923','mirgubad@gmail.com',20,'MALE',1,5),
('Mirsaleh','Agayev','+994998596924','mirsaleh@gmail.com',20,'MALE',1,6),
('Konul','Huseyinli','+994998596925','konul@gmail.com',20,'MALE',1,7),
('Aysun','Huseyinli','+994998596926','aysun@gmail.com',20,'FEMALE',1,1),
('Kenan','Tapdigli','+994998596927','kenan@gmail.com',20,'MALE',1,1),
('Gunel','Mustafayeva','+994998596928','gunel@gmail.com',20,'FEMALE',1,1),
('Eltun','Ismayilov','+994998596929','eltun@gmail.com',20,'MALE',1,1),
('Elmar','Ismayilov','+994998596930','elmar@gmail.com',20,'MALE',1,1)


--1

SELECT p.Name 'PersonName', c.Name 'ContryName', ct.Name 'CityName' FROM Countries AS c
INNER JOIN Cities AS ct
ON c.Id=ct.ContriesId
INNER JOIN People AS p
ON ct.Id=p.CityId
--

--1.1
CREATE VIEW PersonContryCityName
AS
SELECT p.Name 'PersonName', c.Name 'ContryName', ct.Name 'CityName' FROM Countries AS c
INNER JOIN Cities AS ct
ON c.Id=ct.ContriesId
INNER JOIN People AS p
ON ct.Id=p.CityId

SELECT* FROM PersonContryCityName
--

--2

SELECT*FROM Countries
ORDER BY Areas
--
--2.1

SELECT*FROM Cities
ORDER BY Name
--

--3

SELECT COUNT(*) 'CountriyCount' FROM Countries
WHERE Areas>20000
--
--3.1

SELECT MAX(Areas) 'BigArea' FROM Countries
WHERE Name LIKE 'i%'
--

--4.1

SELECT Name,Areas FROM Countries
UNION
SELECT Name,Areas FROM Cities

SELECT Name,Areas FROM Countries
UNION ALL
SELECT Name,Areas FROM Cities

SELECT Name,Areas FROM Countries
EXCEPT
SELECT Name,Areas FROM Cities

SELECT Name,Areas FROM Countries
INTERSECT
SELECT Name,Areas FROM Cities

--
--5.1
SELECT ct.Name,COUNT(CityId) 'CityCount' FROM Cities AS ct
INNER JOIN People AS p
ON ct.Id=p.CityId
GROUP BY ct.Name 
--
--5.2
SELECT ct.Name,COUNT(CityId) 'CityCount' FROM Cities AS ct
INNER JOIN People AS p
ON ct.Id=p.CityId
GROUP BY ct.Name
HAVING COUNT(CityId)>5 