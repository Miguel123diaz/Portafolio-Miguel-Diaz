/*		UNIVERSIDAD EAN
		CURSO SQL
		TALLER 7: Expresiones comunes y tablas recursivas
		Jeison Pinilla
*/
-- 1. Utilizando expresiones comunes, que son consultas que se complementan con otras ya
-- definidas, cree una consulta que muestre la cedula, el primer nombre, el primer apellido
-- y la cantidad de unidades que compra una persona.

SELECT Personas.cedula, primer_nombre, primer_apellido, sum (cantidad) 'Suma total'
FROM Personas
INNER JOIN Transacciones
ON Transacciones.cedula = Personas.cedula
GROUP BY Personas.cedula, primer_nombre, primer_apellido
ORDER BY SUM (cantidad) DESC




WITH CANTIDADES AS 
(SELECT cedula, SUM (Cantidad) 'TotalCantidad'
FROM Transacciones
GROUP BY cedula)

SELECT P.cedula, primer_nombre, primer_apellido, Totalcantidad
FROM Personas AS P
INNER JOIN CANTIDADES  AS C
ON P.cedula = C.Cedula




--2. Realice una consulta de las transacciones realizadas por el individuo con cedula 1018484265
--de los productos 174563 y 345672 y otra del mismo individuo pero con los productos
--345672 y 382901. Una estas consultas utilizando UNION y utilizando UNION ALL

SELECT*FROM Transacciones
WHERE Cedula = 1018484265 AND Producto IN (174563,345672)
UNION ALL
SELECT*FROM Transacciones
WHERE Cedula = 1018484265 AND Producto IN (345672,382901)


SELECT id_transaccion, cedula, fecha, producto, cantidad, Pago
FROM Transacciones
WHERE Cedula = 1018484265 AND Producto IN (174563,345672)
UNION 
SELECT id_transaccion, cedula, fecha, producto, Pago, cantidad
FROM Transacciones
WHERE Cedula = 1018484265 AND Producto IN (345672,382901)

--3. Cambie la tabla codigo productos por la tabla codigo producto obsequio y cree una tabla
--recursiva que muestre cual es el artculo mas basico.

SELECT*FROM Obsequio

WITH Precursoras 
(id_producto,nombre_producto,nivel,predecesores,level) AS 

(SELECT id_producto,
        nombre_producto,
		nivel,
		CAST(' ' AS NVARCHAR(MAX)) AS Predecesores,
		1 AS LEVEL

FROM Obsequio AS ROOT 
WHERE nivel IS NULL
UNION ALL 
SELECT child.id_producto, 
       child.nombre_producto,
	   child.nivel,
	   CONCAT (parent.predecesores,' < ',parent.nombre_producto) AS predecesores,
	   Parent.level +1 AS LEVEL
FROM Precursoras AS parent,
Obsequio AS child

WHERE Child.nivel = parent.id_producto
)

SELECT*,LEN (Predecesores) Largo
FROM Precursoras
WHERE LEVEL <= 10
ORDER BY LEN (Predecesores)
-- ARRIBA TABLE PADRE


WITH Precursoras 
(id_producto,nombre_producto,nivel,predecesores,level) AS 

(SELECT id_producto,
        nombre_producto,
		nivel,
		CAST(' ' AS NVARCHAR(MAX)) AS Predecesores,
		1 AS LEVEL

FROM Obsequio AS ROOT 
WHERE nivel IS NULL
UNION ALL 
SELECT child.id_producto, 
       child.nombre_producto,
	   child.nivel,
	   CONCAT (parent.predecesores,' < ',parent.nombre_producto) AS predecesores,
	   Parent.level +1 AS LEVEL
FROM Precursoras AS parent
INNER JOIN Obsequio AS Child


ON Child.nivel = parent.id_producto
)

SELECT*,LEN (Predecesores) Largo
FROM Precursoras
WHERE LEVEL <= 1
ORDER BY LEN (Predecesores)++


--Consultas recursivas: Aquellas en las que se busca información sobre la misma tabla


--4--snippet - codigos existentes muy usados


SELECT*FROM SYS.OBJECTS 
WHERE TYPE = 'U'

SELECT*FROM SYS.objects 
WHERE TYPE = 'U' AND DATEDIFF (M,create_date,GETDATE())<=3