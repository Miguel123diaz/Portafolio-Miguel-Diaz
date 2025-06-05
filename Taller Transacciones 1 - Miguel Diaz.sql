/*		UNIVERSIDAD EAN
		CURSO SQL
		TALLER 1: Conceptos básicos de SQL
		Jeison Pinilla
*/

--A continuación se dan las instrucciones para la creación de una base de datos. Las convenciones de la base de datos serán:

--Nombre de la base de datos: UPPERCASE
--Nombre de las tablas: PascalCase
--Nombre de los campos: snake case

--1. Cree una base de datos que se llame operaciones utilizando un script.

CREATE DATABASE OPERACIONES2 ON
(NAME = N'OPERACIONES2' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OPERACIONES2.mdf')
LOG ON 
(NAME = N'OPERACIONES2_LOG' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OPERACIONES2_LOG.ldf')  

--2. Cree 4 tablas con los siguientes archivos planos.*/
		--CodigoProductos.txt
		--Municipios.txt
		--Personas.txt
		--Transacciones.txt
	--No defina llaves primarias, ni ´ındices, ni llaves for´aneas.

--3. Utilizando código, agregue las transacciones del archivo Transacciones_nuevo.txt a la tabla Transacciones.

BULK INSERT transacciones
FROM 
'C:\Users\Lenovo\Documents\SQL Module 1\Transacciones_Nuevo.txt'
WITH
(
DATAFILETYPE= 'widechar',
FIELDTERMINATOR = '\t', 
ROWTERMINATOR = '\n'
)

SELECT*FROM Transacciones 

--4. Utilizando código, construya una tabla con la siguiente estructura
					 
					   --id pago | nombre pago
							 --1 | Contado
							 --2 | Crédito
							 --3 | Financiado
							 --4 | Obsequio
	--defina el campo id pago como llave primaria

	CREATE TABLE Pagos3 (
	id_pagos INT PRIMARY KEY,
	Nombre_pago VARCHAR (255)
	);
	INSERT INTO pagos3 (id_pagos, Nombre_pago) VALUES (1,'Contado');
	INSERT INTO pagos3 (id_pagos, Nombre_pago) VALUES (2,'Credito');
	INSERT INTO pagos3 (id_pagos, Nombre_pago) VALUES (3,'Financiado');
	INSERT INTO pagos3 (id_pagos, Nombre_pago) VALUES (4,'Obsequio');

--5. Utilizando código, cree las llaves primarias de cada tabla.

ALTER TABLE Municipios	ADD CONSTRAINT pk_municipios primary key (id_municipios)
ALTER TABLE Productos	ADD CONSTRAINT pk_productos primary key (id_producto)
ALTER TABLE Transacciones	ADD CONSTRAINT pk_transaccion primary key (id_transaccion)
ALTER TABLE Pagos3	ADD CONSTRAINT pk_pagos primary key (id_pago)


SELECT * FROM Transacciones
WHERE id_transaccion = 12347378

DELETE FROM Transacciones
WHERE id_transaccion =  12347454

--6. Utilizando código, defina el campo cédula como índice o como valor único.

ALTER TABLE personas ADD CONSTRAINT index_cedula UNIQUE  (Cedula)

--7. Utilizando código, cree las llaves foráneas
ALTER TABLE Personas ADD FOREIGN KEY (municipio) References MUNICIPIOS (id_municipios)
ALTER TABLE Transacciones ADD FOREIGN KEY (Producto) REFERENCES PRODUCTOS (id_producto)

--8. Utilizando c´odigo, cree un campo en transacciones que se llame pago y asigne contado a todas las transacciones

SELECT*FROM Transacciones 
ALTER TABLE Transacciones ADD Pago INT
UPDATE Transacciones 
SET pago = 1

/*9. Utilizando código, registre la siguiente transacción: Juan Ruíz Orjuela de Manizales con cédula de ciudadanía 1023910489, nació el 19 de diciembre de 1990, 
su celular es 3132457893 y se llevó 3 pantalones de hombre y 2 blusas, un pantalón fue obsequiado y los otros dos los pago de contado, la blusa si fue comprada a crédito.*/


SELECT*FROM Personas
WHERE cedula = 1023910489

INSERT INTO Personas
VALUES (34,1023910489, 'JUAN', NULL, 'RUIZ', 'ORJUELA', '1990-12-19', 17001, 3132457893, NULL)

SELECT*FROM Pagos3
ORDER BY id_transaccion DESC

INSERT  INTO Transacciones
Values (1023910489, '2024-09-11' , 435672, 1 , 4),
(1023910489, '2024-09-11' , 435672, 2 , 1),
(1023910489, '2024-09-11' , 273893, 2 , 2)

SELECT*FROM Transacciones
SELECT*FROM Productos

435672 pantalon 3  (1 obs 4, 2 contado 1), 273893 blusa 2 . (credito 2)
-- experimento
DELETE FROM Transacciones
WHERE id_transaccion = 12347938

Delete transacciones 
WHERE Cedula = 1023910489


--10. En la tienda todos los aretes son de obsequio, cambie el método de pago de este producto en las transacciones.

SELECT*FROM Transacciones
WHERE producto = 389333

UPDATE Transacciones
SET pago = 4
Where producto = 389333