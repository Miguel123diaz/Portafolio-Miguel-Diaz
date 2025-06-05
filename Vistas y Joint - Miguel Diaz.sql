	  /*UNIVERSIDAD EAN
		CURSO SQL
		TALLER 3
		Jeison Pinilla*/

/*A continuación se dan las instrucciones para la creación de vistas y su manipulación.
Cree las siguientes vistas:*/
/*Cantidad de artículos vendidos por cada tipo*/

SELECT*FROM VistaCantidadProducto


/*Cantidad de artículos comprados por cada cliente*/

SELECT*FROM ArticulosCompradosPorCliente
CREATE VIEW ArticulosCompradosPorCliente AS
SELECT Cedula , SUM (Cantidad) 'Cantidad Vendida'
FROM Transacciones 
GROUP BY Cedula  

SELECT*FROM ArticulosCompradosPorCliente
ORDER BY 'Cantidad Vendida' ASC 

/*Cantidad de artículos vendidos por modalidad de pago*/

CREATE VIEW CantidadProductosPago AS
SELECT Pago , SUM (Cantidad) 'Cantidad Vendida'
FROM Transacciones 
GROUP BY Pago

SELECT*FROM CantidadProductosPago
ORDER BY 'Cantidad Vendida' ASC 


/*1. Visualice las dos siguientes consultas de la primera vista: cantidad de artículos que fueron vendidos por cada tipo; la cantidad de pantalones de hombre y de mujer comprados. 
Anote los resultados de la segunda consulta.*/

SELECT*FROM VistaCantidadProducto
WHERE producto = 435672 OR producto = 345672

-- Otra forma
SELECT*FROM VistaCantidadProducto
WHERE producto IN (435672 , 345672)

-- Producto	Cantidad Vendida
-- 345672	310
-- 435672	176

SELECT*FROM 

/*2. Visualice las dos siguientes consultas de la segunda vista: 
Seleccionar los diez clientes que más artículos compraron y cuantos artículos fueron comprados por el cliente que más compra. 
Anote los resultados de la segunda consulta.*/

SELECT TOP 10 *
FROM ArticulosCompradosPorCliente
ORDER BY 'Cantidad Vendida' Desc


-- Cedula	Cantidad Vendida
-- 1214722914	353

--3.Visualice la cantidad de artículos que se han comprado por cada método de pago. Anótelos (vista)

SELECT*FROM CantidadProductosPago ; 

-- Pago	Cantidad Vendida
-- 1	2502
-- 4	101
-- 2	35

/*4. La persona con el mayor número de compras compró 2 pantalones de hombre a crédito; 3 pantalones de mujer de la siguiente manera: 1 de contado y 2 Financiados; y se le regalaron 3 aretes por su compra. 
Registre esta transacción y verifique cómo se ve reflejada en las tres vistas creadas.*/

INSERT INTO Transacciones
VALUES  (1214722914 , '2024-09-16', 435672 , 3, 2 ),
		(1214722914 , '2024-09-16', 345672 , 1, 1 ) , 
		(1214722914 , '2024-09-16', 345672 , 2, 3 ) , 
		(1214722914 , '2024-09-16', 389333 , 3, 4 ) ;

SELECT*FROM Transacciones
WHERE Cedula = 1214722914
ORDER BY Fecha DESC


--5. Verifique que los datos de la transacción se ven reflejados en las vistas




/*6. Cree las siguientes transacciones.
Andrés Pérez Miranda de Medellín con cédula de ciudadanía 1001546738, nació el 3 de mayo de 1985, su celular es 3134789302;compró 3 camisetas que pagó de contado, 2 medias que compró a crédito, 2 pares de zapatos Financiados y 4 blusas que le obsequiaron.



Paola Jara de Amaga con cédula de ciudadanía 920483728, nació el 5 de abril de 1970, su celular es 3147829183; compró 5 camisetas que pagó a crédito, 4 medias que pagó Financiadas, 4 anillos que pagó de contado, compro 1 sombrero lo pago de contado y por sus compras le obsequiaron otro.
*/


INSERT INTO Personas
Values (35,1001546738, 'Andres', NULL, 'Perez', 'Miranda', '1985-05-03', 5001, 3134789302, NULL),
(36, 920483728, 'Paola', NULL, 'Jara', NULL, '1970-04-05', 5030, 3147829183, NULL )

SELECT*FROM Transacciones
WHERE Cedula = 920483728

INSERT INTO Transacciones
VALUES  (1001546738 , '2024-09-16', 382901 , 3, 1 ),
		(1001546738, '2024-09-16', 281982 , 2, 2 ) , 
		(1001546738, '2024-09-16', 382928 , 2, 3 ) , 
	(1001546738 , '2024-09-16', 273893 , 4, 4 ),
		(920483728 , '2024-09-16', 382901 , 3, 2 ),
		(920483728, '2024-09-16', 281982 , 4, 3 ) , 
		(920483728, '2024-09-16', 389282 , 4, 1 ) , 
		(920483728 , '2024-09-16', 282822 , 1, 1 ) ,
		(920483728 , '2024-09-16', 282822 , 1, 4 )

INSERT INTO Transacciones 
VALUES (920483728 , '2024-09-16', 382928 , 2, 2 )

DELETE Transacciones
WHERE id_transaccion = 12347958


UPDATE Transacciones
SET Cantidad = 5
WHERE id_transaccion = 12347953



/*7. Cree dos vistas con las compras realizadas por las anteriores personas, debe aparecerme el nombre de la persona y el nombre del producto*/

CREATE VIEW  Andres  AS 
SELECT Primer_nombre, Producto , nombre_producto, Cantidad
FROM Transacciones 
INNER JOIN Personas  
ON Transacciones.Cedula = Personas.cedula
INNER JOIN Productos 
ON Productos.id_producto = transacciones.producto
WHERE transacciones.cedula  = 1001546738

SELECT*FROM Personas


CREATE VIEW  Paola  AS 
SELECT Primer_nombre, Producto , nombre_producto, Cantidad 
FROM Transacciones 
INNER JOIN Personas  
ON Transacciones.Cedula = Personas.cedula
INNER JOIN Productos 
ON Productos.id_producto = transacciones.producto
WHERE transacciones.cedula  = 920483728

SELECT*FROM Paola

-- EJEMPLO PARA PRACTICAR BUSCA EL Metodo de pago

CREATE TABLE EJEMPLO_SQL (
primer_nombre VARCHAR (255),
id_pagos INT,
Nombre_pago VARCHAR (255),
cantidad INT,
nombre_producto VARCHAR (255),
Cedula VARCHAR (255)
);

INSERT INTO EJEMPLO_SQL
SELECT primer_nombre, id_pagos, Nombre_pago, cantidad, nombre_producto, personas.cedula
FROM Pagos3
INNER JOIN Transacciones
ON Pagos3.id_pagos = Transacciones.Pago
INNER JOIN Personas
ON Personas.cedula = Transacciones.cedula
INNER JOIN Productos
ON Productos.id_producto = Transacciones.producto
WHERE Transacciones.cedula = 920483728

ALTER TABLE EJEMPLO_SQL
ADD Fecha DATE 


ALTER TABLE EJEMPLO_SQL 
DROP COLUMN fecha 

UPDATE EJEMPLO_SQL
SET EJEMPLO_SQL.Fecha = Transacciones.fecha
FROM EJEMPLO_SQL
INNER JOIN Transacciones
ON EJEMPLO_SQL.Cedula = Transacciones.cedula

INSERT INTO EJEMPLO_SQL
VALUES ('Miguel', 3, 'Financiado', 10,'Camiseta', 1136884506, NULL)

SELECT*FROM EJEMPLO_SQL

DELETE FROM EJEMPLO_SQL
WHERE Fecha IS NULL;

UPDATE EJEMPLO_SQL
SET EJEMPLO_SQL.fecha = Transacciones.fecha
FROM EJEMPLO_SQL
INNER JOIN Transacciones
ON EJEMPLO_SQL.Cedula = Transacciones.cedula


-- EJEMPLO PARA PRACTICAR BUSCA EL Metodo de pago

--8. Consulte la cantidad de productos comunes Andrés y Paola

SELECT*FROM Andres
SELECT*FROM Paola



SELECT Andres.nombre_producto, Andres.Cantidad, Paola.Cantidad
FROM Andres
INNER JOIN Paola
ON Andres.nombre_producto = Paola.nombre_producto

SELECT A.nombre_producto, A.Cantidad 'Andres', P.Cantidad 'Paola'
FROM Andres AS A
INNER JOIN Paola P
ON A.producto = P.Producto

--9. Consulte la cantidad de productos que ha comprado Andrés y de estos cuales ha comprado Paola

SELECT A.nombre_producto,
       A.Cantidad 'Andres',
       CASE WHEN P.Cantidad IS NULL THEN 0
            ELSE P.Cantidad
       END 'Paola' 
FROM Andres AS A
LEFT JOIN Paola AS P
ON A.producto = P.Producto


SELECT Andres.nombre_producto, Andres.Cantidad Andres, 
      CASE WHEN Paola.Cantidad IS NULL THEN 0
      ELSE Paola.Cantidad
	  END  'Paola'
FROM Andres
LEFT JOIN Paola
ON Andres.nombre_producto = Paola.nombre_producto



--10. Consulte la cantidad de productos que Andrés ha comprado de los productos que ha comprado Paola

SELECT P.nombre_producto,
	   CASE WHEN A.Cantidad IS NULL THEN 0
	        ELSE A.CANTIDAD
	   END 'Andres',
	   P.cantidad 'Paola'
FROM Andres AS A
RIGHT JOIN Paola P
ON P.Producto = A.Producto



SELECT Paola.nombre_producto,
       CASE WHEN Andres.Cantidad IS NULL THEN 0
	   ELSE ANDRES.Cantidad
	   END 'Andres Cantidad',
	   Paola.Cantidad Paola_cantidad
FROM Andres
RIGHT JOIN Paola
ON Paola.nombre_producto = Andres.nombre_producto

--11.Consulte la cantidad de productos que Andrés ha comprado pero no ha comprado Paola

SELECT A.nombre_producto,
	   CASE WHEN P.Cantidad IS NULL THEN 0
	        ELSE p.CANTIDAD
	   END 'Paola',
	   A.cantidad 'Andres'
FROM Andres AS A
LEFT JOIN Paola P
ON P.Producto = A.Producto
WHERE P.Cantidad IS NULL


SELECT ANDRES.nombre_producto,
       CASE WHEN Paola.Cantidad IS NULL THEN 0
	   ELSE Paola.Cantidad 
	   END 'Producto Paola',
	   Andres.Cantidad 'Producto Andres'
FROM Andres
LEFT JOIN Paola
ON Paola.Producto = Andres.Producto
WHERE Paola.Cantidad IS NULL



--12. Consulte todos los productos que han comprado Andrés y Paola
SELECT CASE WHEN A.nombre_producto IS NULL THEN P.nombre_producto
            ELSE A.nombre_producto
       END Nombre_producto,	
	   CASE WHEN SUM (A.Cantidad) IS NULL THEN 0
	        ELSE SUM (A.CANTIDAD)
	   END 'ANDRES',
	   CASE WHEN SUM (P.Cantidad) IS NULL THEN 0
	        ELSE SUM (P.Cantidad)
	   END 'Paola'
FROM Andres AS A
FULL JOIN Paola P
ON A.Producto = P.Producto
GROUP BY A.nombre_producto, P.nombre_producto 

--13. Realice un cruce de los registros de Andrés con los de Paola (todas las posibles combinaciones)

SELECT CASE WHEN A.nombre_producto IS NULL THEN P.nombre_producto
            ELSE A.nombre_producto
       END Nonmbre_producto,	
	   CASE WHEN A.Cantidad IS NULL THEN 0
	        ELSE A.CANTIDAD
	   END 'ANDRES',
	   CASE WHEN P.Cantidad IS NULL THEN 0
	        ELSE P.Cantidad
	   END 'Paola'
FROM Andres AS A
CROSS JOIN Paola P

SELECT A.nombre_producto Andres,P.nombre_producto Paola, A.cantidad Acantidad, p.Cantidad Pcantidad
FROM Andres AS A
CROSS JOIN Paola AS P


--14. Consulte todos los productos que han comprado Andrés o Paola, pero no juntos

SELECT CASE WHEN A.nombre_producto IS NULL THEN P.nombre_producto
            ELSE A.nombre_producto
       END Nombre_producto,	
	   CASE WHEN SUM (A.Cantidad) IS NULL THEN 0
	        ELSE SUM (A.CANTIDAD)
	   END 'ANDRES',
	   CASE WHEN SUM (P.Cantidad) IS NULL THEN 0
	        ELSE SUM (P.Cantidad)
	   END 'Paola'
FROM Andres AS A
FULL JOIN Paola P
ON A.Producto = P.Producto
WHERE  A.Producto IS NULL OR P.Producto IS NULL
GROUP BY A.nombre_producto, P.nombre_producto 




--15. Halle el total que pago Andrés por cada producto.

SELECT producto, A.nombre_producto, Cantidad, precio, precio * Cantidad 'Total'
FROM Andres A
INNER JOIN Productos P
ON A.Producto = P.id_producto


--16. Halle el total que pago Andrés por las compras que ha hecho

SELECT SUM (Cantidad) 'Compras', SUM (cantidad * precio) 'Total'
FROM Andres A
INNER JOIN Productos
ON A.Producto = Productos.id_producto




--17.  Cree una función que calcule un descuento

CREATE FUNCTION Descuento 
(@precio MONEY , @tasa FLOAT )
RETURNS MONEY 
AS BEGIN  
DECLARE @descuento MONEY
SET @Descuento = @precio*@tasa 
RETURN @descuento
END 

-- Siempre poner select para invocar la función
SELECT dbo.descuento (100000, 0.2)

SELECT 3+7







-- PRACTICA!!

SELECT Andres.nombre_producto, SUM (Cantidad) AS Cantidad ,SUM  ( cantidad*precio ) AS 'PD',
        SUM (( cantidad*precio ) * 0.10) 'Descuento',
	   SUM (cantidad*precio) - SUM (( cantidad*precio ) * 0.10) 'Total Precio'
FROM Andres
Inner Join Productos
on Andres.Producto = Productos.id_producto
GROUP BY ANDRES.nombre_producto

-- PRACTICA

SELECT Andres.nombre_producto, SUM (Cantidad) AS Cantidad ,SUM  ( cantidad*precio ) AS 'PD',
        CASE WHEN SUM (Cantidad) > 2 THEN SUM (( cantidad*precio ) * 0.10)
		ELSE 0
		END 'Descuento',
	    CASE WHEN SUM ( cantidad ) > 2 THEN SUM  ( cantidad*precio ) - SUM (( cantidad*precio ) * 0.10)
		ELSE SUM ( cantidad*precio )
		END 'total precio'
FROM Andres
Inner Join Productos
on Andres.Producto = Productos.id_producto
GROUP BY ANDRES.nombre_producto


CREATE TABLE Descuentos (
nombre_producto VARCHAR (255),
Cantidad INT,
Multiplicacion_producto INT,
Descuento INT,
Total_precio INT
)


INSERT INTO Descuentos
SELECT Andres.nombre_producto, SUM (Cantidad) AS Cantidad ,SUM  ( cantidad*precio ) AS 'Multiplicación Productos',
        CASE WHEN SUM (Cantidad) > 2 THEN SUM (( cantidad*precio ) * 0.10)
		ELSE 0
		END 'Descuento',
	    CASE WHEN SUM ( cantidad ) > 2 THEN SUM  ( cantidad*precio ) - SUM (( cantidad*precio ) * 0.10)
		ELSE SUM ( cantidad*precio )
		END 'total precio'
FROM Andres
Inner Join Productos
on Andres.Producto = Productos.id_producto
GROUP BY ANDRES.nombre_producto

SELECT*FROM Descuentos

-- PRACTICA




--18. Calcule el pago total que realizo Andrés por cada producto y cuando el pago fue de contado, se hizo un descuento 20%, a crédito se incrementó al 20% y financiado aumento a un 10%


-- Contado 20%, credito incrementó 20%, financiado aumentó 10%

SELECT Primer_nombre, Producto, Andres.nombre_producto, Cantidad*precio , Precio
FROM Andres
INNER JOIN Productos
ON Productos.id_producto = Andres.Producto
GROUP BY Andres.nombre_producto



SELECT Producto, 
nombre_producto,
Pago, 
Cantidad, 
precio, 
CASE WHEN Pago = 1 then dbo.descuento (precio*cantidad,0.8) 
     WHEN Pago = 2 then dbo.descuento (precio*cantidad,1.2) 
	 WHEN Pago = 3 then dbo.descuento (precio*cantidad,1.1) 
	 ELSE 0
	 END 'Pago_total'
FROM Transacciones
INNER JOIN Productos
ON Transacciones.producto = Productos.id_producto


