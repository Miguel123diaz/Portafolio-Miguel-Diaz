/*		UNIVERSIDAD EAN 
		CURSO SQL
		TALLER 2: Conceptos básicos de SQL
		Jeison Pinilla
*/

--1. Seleccione todas las transacciones realizadas por la cédula 53135666 y ordénelas por fecha de la más reciente a la más antigua

SELECT * FROM Transacciones
WHERE Cedula = 53135666
ORDER BY fecha DESC

--2. Elimine todas las transacciones realizadas por la anterior cédula que se hayan realizado del producto 345672 y después del 7 de octubre de 2011
USE OPERACIONES 
SELECT * FROM Transacciones
WHERE Cedula = 53135666 AND producto = 345672 and fecha > '2011-10-07'


SELECT * FROM [OPERACIONES].[dbo].[Transacciones]
WHERE Cedula = 53135666 AND producto = 345672 and fecha > '2011-10-07'

DELETE Transacciones 
WHERE Cedula = 53135666 AND producto = 345672 and fecha > '2011-10-07'

--3. Cambie todas las transacciones de la cédula 1233490932 de los productos 389333,174563,273893 a financiadas

SELECT * FROM Transacciones
WHERE Cedula = 1233490932 AND ( producto = 389333 or producto = 174563 or producto = 273893 )

UPDATE Transacciones 
SET pago = 3
WHERE Cedula = 1233490932 AND ( producto = 389333 or producto = 174563 or producto = 273893 )

SELECT * FROM Transacciones
WHERE Cedula = 1233490932 AND  producto = 389333 or producto = 174563 or producto = 273893 

--4. Hubo un error, el anterior cambio no era financiadas, era a crédito. Realice el cambio utilizando el comando in.

UPDATE Transacciones 
SET pago = 2
WHERE Cedula = 1233490932 AND producto IN (389333,174563,273893)

--5. Realice una consulta de todas las transacciones realizadas en marzo del 2012 trayendo únicamente cédula y producto. Llame a los campos documento de identidad y artículo.

SELECT * FROM Transacciones 
WHERE FECHA >= '2012-03-01' AND FECHA <= '2012-03-31'

SELECT * FROM Transacciones 
WHERE FECHA BETWEEN '2012-03-01' AND '2012-03-31'

SELECT Cedula , producto FROM Transacciones 
WHERE FECHA BETWEEN '2012-03-01' AND '2012-03-31'

SELECT Cedula AS Documento , producto  Articulo FROM Transacciones 
WHERE FECHA BETWEEN '2012-03-01' AND '2012-03-31'

--6. Consulte la cédula, primer nombre, apellido y celular de todos las personas que no tienen correo.

SELECT * FROM Personas
WHERE correo IS NULL 

--7. Consulte todas las transacciones que no se realizaron de contado

SELECT * FROM Transacciones 
WHERE Pago <> 1
ORDER BY pago

SELECT * FROM Transacciones 
WHERE Pago != 1
ORDER BY pago

--8. Cuente la cantidad de clientes

SELECT COUNT (*) 'Cantidad Clientes' 
FROM Personas

SELECT COUNT (id_personas) 'Cantidad Clientes' 
FROM Personas



--9. Halle la suma del total de productos comprados

SELECT  SUM (cantidad) 'Compilado suma' 
FROM Transacciones

SELECT*FROM Transacciones



--10. Halle el menor, mayor y costo promedio. Nómbrelos.

SELECT MIN (Precio) 'Menor', MAX (precio) 'Mayor', AVG (Precio) 'Promedio' FROM Productos


--11. Halle la cantidad de unidades que se han vendido de cada producto y llámela cantidad vendida y ordénelas de mayor a menor

SELECT Producto , SUM (cantidad) 'Cantidad Vendida'
FROM Transacciones 
GROUP BY Producto 
ORDER BY 'Cantidad Vendida' DESC 

--12. Consulte los 10 clientes que compraron la mayor cantidad de productos

SELECT TOP 5 cedula , SUM (cantidad) 'Cantidad Vendida'
FROM Transacciones 
GROUP BY cedula 
ORDER BY 'Cantidad Vendida' DESC 


SELECT TOP 5 cedula , SUM (cantidad) 'Cantidad Vendida'
FROM Transacciones 
GROUP BY cedula 
ORDER BY 'Cantidad Vendida' ASC 
--13. De la tabla Personas, consulte los primeros nombres distintos.

SELECT DISTINCT primer_nombre
FROM Personas


--14. Cuente la cantidad de primeros nombres distintos.

SELECT COUNT ( DISTINCT primer_nombre ) 'Nombres Distintos'
FROM Personas

--15. Consulte los clientes cuyo apellido empieza por p

SELECT * 
FROM Personas 
WHERE primer_apellido LIKE 'P%' OR segundo_apellido lIKE 'P%'


--16. Consulte los clientes cuyo nombre tenga 'la'

SELECT * FROM Personas
WHERE	primer_nombre LIKE '%la%' OR segundo_nombre LIKE '%la%'



--17. Consulte todos los nombres que no tienen 'a'

SELECT*FROM Personas
WHERE primer_nombre NOT LIKE '%O%' AND segundo_nombre NOT LIKE '%O%' 

--18. Cree una vista que contenga la cantidad de unidades que se han comprado de cada artículo

CREATE VIEW VistaCantidadProducto AS 
SELECT Producto , SUM (cantidad) 'Cantidad Vendida'
FROM Transacciones 
GROUP BY Producto 

-- Nunca poner order by 

SELECT*FROM VistaCantidadProducto
ORDER BY 'Cantidad Vendida'


--19. Elimine los registros de la tabla transacciones pero sin perder su estructura

SELECT*FROM Transacciones 
ORDER BY id_transacción DESC

SELECT MAX (id_transacción)FROM Transacciones 
--12347941


INSERT INTO Transacciones 
VALUES (101425092,'2011-03-02', 435672, 1, 1)

DELETE Transacciones

TRUNCATE TABLE Transacciones 



--20. Elimine la Tabla transacciones completamente

DROP TABLE Transacciones