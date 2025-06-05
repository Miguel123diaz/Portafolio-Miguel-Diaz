	  /*UNIVERSIDAD EAN
		CURSO SQL
		TALLER 5: TIPOS DE DATOS Y SUBQUERYES
		Jeison Pinilla*/

--1. Convierta 3/4 a decimal usando cast.

SELECT '3/4' 

SELECT 3/4 

SELECT CHARINDEX ('/','320/415' )                         -- Puedo en qué posición está el /

SELECT SUBSTRING ('320/415',1,(CHARINDEX ('/','320/415' )-1)),
       SUBSTRING ('320/415',(CHARINDEX ('/','320/415' ) +1), LEN  ('320/415'))

SELECT CAST ( SUBSTRING ('320/415',1,(CHARINDEX ('/','320/415' )-1)) AS float)/
       CAST (SUBSTRING ('320/415',(CHARINDEX ('/','320/415' ) +1), LEN  ('320/415')) AS float)

SELECT CONVERT (FLOAT ,( SUBSTRING ('320/415',1,(CHARINDEX ('/','320/415' )-1))))/
       CONVERT (FLOAT,(SUBSTRING ('320/415',(CHARINDEX ('/','320/415' ) +1), LEN  ('320/415'))))

--2. Convierta 3/4 a decimal usando convert


SELECT CONVERT (FLOAT ,( SUBSTRING ('320/415',1,(CHARINDEX ('/','320/415' )-1))))/
       CONVERT (FLOAT,(SUBSTRING ('320/415',(CHARINDEX ('/','320/415' ) +1), LEN  ('320/415'))))

--3. Consulte la cantidad de transacciones que se realizaron por cada producto. 
--   Únicamente despliegue aquellos que tuvieron 100 o más transacciones.

SELECT  Producto, COUNT (*) 'Cantidad de Transacicones'      
FROM Transacciones  
GROUP BY producto
HAVING COUNT (*) > 100
ORDER BY 'Cantidad de Transacicones' DESC

--4. Consulte la cedula, celular, el primer nombre y apellido de los clientes 
--que compraron más de 100 productos.

SELECT  Personas.cedula, celular, Primer_nombre, primer_apellido, SUM (cantidad) 'Cantidad de Productos'    
FROM Personas
INNER JOIN Transacciones
ON Personas.cedula = Transacciones.cedula
GROUP BY personas.cedula, celular, Primer_nombre, primer_apellido                    -- Todo lo que no este en agregación se debe agregar en GROUP BY
HAVING SUM (cantidad ) > 100
ORDER BY 'Cantidad de Productos'   DESC

--SUBQUERIES
	--OTRA OPCIÓN MÁS EFICIENTE 

SELECT Cedula
FROM Transacciones
GROUP BY cedula
HAVING SUM (Cantidad) > 100

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas 
WHERE cedula IN (SELECT Cedula
                 FROM Transacciones
                 GROUP BY cedula
                 HAVING SUM (Cantidad) > 100)

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas 
WHERE cedula = ANY (SELECT Cedula
                 FROM Transacciones
                 GROUP BY cedula
                 HAVING SUM (Cantidad) > 100)


SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE EXISTS    (SELECT Cedula
                 FROM Transacciones AS T
				 WHERE P.cedula = t.cedula
                 GROUP BY cedula
                 HAVING SUM (Cantidad) > 100)


	--1) Consulte los individuos que compraron más de 100


	--2) Consulte los datos personales

	

--Nota: Consulte el id, nombre y precio de los productos
--      que se han vendido en más de 100 transacciones.



--5. Consulte si todos los productos obsequiados a la cedula 101425092 fueron el mismo

SELECT*FROM Transacciones 
WHERE cedula = 101425092 and pago = 4 

SELECT*FROM Productos
WHERE id_producto = ALL (SELECT Producto FROM Transacciones 
WHERE cedula = 101425092 and pago = 4 )

UPDATE Transacciones 
SET producto = 435672
WHERE id_transaccion = 12346621

SELECT*FROM Transacciones


--6. Consulte cédula, celular, primer nombre y apellido de quienes compraron por lo menos un producto no obsequiado.


SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas
WHERE cedula IN (SELECT Cedula
                 FROM Transacciones
				 WHERE PAGO <> 4)

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas
WHERE cedula = ANY (SELECT Cedula 
                 FROM Transacciones
				 WHERE PAGO <> 4)

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE EXISTS    (SELECT Cedula 
                 FROM Transacciones AS T
				 WHERE P.cedula = T.cedula  AND Pago <> 4 )    


SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE EXISTS    (SELECT Cedula 
                 FROM Transacciones AS T
				 WHERE P.cedula = T.cedula  AND Pago <> 4 )  
				 
SELECT DISTINCT Personas.cedula, primer_nombre, primer_apellido, celular
FROM Personas 
INNER JOIN Transacciones
ON Personas.cedula = Transacciones.cedula
WHERE Pago <> 4 



SELECT*FROM Personas


--7. Consulte cédula, celular, primer nombre y apellido de quienes se les obsequio un artículo distinto al 174563.

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas
WHERE cedula IN (SELECT Cedula
                 FROM Transacciones
				 WHERE Producto <> 174563 and Pago = 4)








--8. Consulte cédula, celular, primer nombre y apellido de quienes no se les obsequio un artículo distinto al 174563.

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE NOT EXISTS    (SELECT Cedula 
                 FROM Transacciones AS T
				 WHERE P.cedula = T.cedula  AND Pago = 4 and producto <> 174563)


--9. Consulte cédula, celular, primer nombre y apellido de todas las personas que han pagado de contado pero que no sean de Bogotá.

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE EXISTS    (SELECT Cedula 
                 FROM Transacciones AS T
				 WHERE P.cedula = T.cedula  AND Pago = 1) AND municipio <> 11001

SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE EXISTS    (SELECT Cedula 
                 FROM Transacciones AS T
				 WHERE P.cedula = T.cedula  AND Pago = 1) 
EXCEPT 
SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas AS P
WHERE municipio = 11001


SELECT cedula, primer_nombre, primer_apellido, celular
FROM Personas
WHERE cedula = ANY (SELECT Cedula 
                 FROM Transacciones
				 WHERE PAGO = 1 AND municipio <> 11001)

--10. Almacene en una variable la media y la desviación estándar de la cantidad de productos comprados por cliente 
-- y clasifíquelos en Bajo si compran menos la media menos una desviación estándar
-- Medio si venden menos de la media más una desviación estándar y Alto en caso contrario,
-- realice una consulta en la que se muestre cédula, primer nombre y apellido, celular, cantidad comprada y fidelidad.

-- Sin utilizar variables.

SELECT*FROM ArticulosCompradosPorCliente

SELECT AVG ([Cantidad Vendida]) media, STDEV ([Cantidad Vendida]) DesviaciónEstandar
FROM ArticulosCompradosPorCliente
-- Media 98  Desviación standar 83

SELECT personas.cedula, primer_nombre, primer_apellido, celular,
       [Cantidad Vendida],
	   CASE WHEN [Cantidad Vendida] < ( SELECT AVG ([Cantidad Vendida]) - STDEV ([Cantidad Vendida]) FROM ArticulosCompradosPorCliente ) THEN 'Bajo'
	        WHEN [Cantidad Vendida] < ( SELECT AVG ([Cantidad Vendida]) + STDEV ([Cantidad Vendida]) FROM ArticulosCompradosPorCliente ) THEN  'Medio'
			ELSE 'Alto' 
	   END 'Fidelidad'
FROM ArticulosCompradosPorCliente
INNER JOIN Personas
ON Personas.cedula = ArticulosCompradosPorCliente.Cedula
ORDER BY  [Cantidad Vendida] DESC


DECLARE @Promedio FLOAT 
SET @Promedio = (SELECT AVG ([Cantidad Vendida]) FROM ArticulosCompradosPorCliente)

DECLARE @Desviacionstandar FLOAT 
SET @Desviacionstandar = (SELECT AVG ([Cantidad Vendida]) FROM ArticulosCompradosPorCliente)

SELECT personas.cedula, primer_nombre, primer_apellido, celular,
       [Cantidad Vendida],
	   CASE WHEN [Cantidad Vendida] < ( @Promedio - @Desviacionstandar) THEN 'Bajo'
	        WHEN [Cantidad Vendida] < ( @Promedio + @Desviacionstandar ) THEN  'Medio'
			ELSE 'Alto' 
	   END 'Fidelidad'
FROM ArticulosCompradosPorCliente
INNER JOIN Personas
ON Personas.cedula = ArticulosCompradosPorCliente.Cedula
ORDER BY  [Cantidad Vendida] DESC


--11. Cree una viste con la anterior tabla y a partir de esta cree una consulta que permita llamar a los clientes que tienen una fidelidad baja o media.




CREATE VIEW  Fidelidad AS
SELECT personas.cedula, primer_nombre, primer_apellido, celular,
       [Cantidad Vendida],
	   CASE WHEN [Cantidad Vendida] < ( SELECT AVG ([Cantidad Vendida]) - STDEV ([Cantidad Vendida]) FROM ArticulosCompradosPorCliente ) THEN 'Bajo'
	        WHEN [Cantidad Vendida] < ( SELECT AVG ([Cantidad Vendida]) + STDEV ([Cantidad Vendida]) FROM ArticulosCompradosPorCliente ) THEN  'Medio'
			ELSE 'Alto' 
	   END 'Fidelidad'
FROM ArticulosCompradosPorCliente
INNER JOIN Personas
ON Personas.cedula = ArticulosCompradosPorCliente.Cedula
ORDER BY  [Cantidad Vendida] DESC

SELECT*FROM Fidelidad
ORDER BY  [Cantidad Vendida] DESC

SELECT*,
CASE WHEN Fidelidad = 'Bajo' or Fidelidad = 'Media' Then 'SI'
     ELSE 'NO'
	 END 'Llamar'
FROM Fidelidad

SELECT*,
CASE WHEN Fidelidad IN ('Bajo','Medio') Then 'SI'
     ELSE 'NO'
	 END 'Llamar'
FROM Fidelidad

CREATE FUNCTION RETENCION2
(@Fidelidad VARCHAR (5))
RETURNS VARCHAR (2)
AS BEGIN 
    DECLARE @LLAMAR VARCHAR (2)
	IF @Fidelidad IN ('Medio', 'Bajo')
	SET @LLAMAR = 'SI'
	ELSE 
	SET @LLAMAR = 'NO'
	RETURN @LLAMAR
	END

SELECT DBO.Retencion ('ALTO')

SELECT*, dbo.retencion2 (Fidelidad) AS Llamar
FROM Fidelidad
ORDER BY Fidelidad DESC

SELECT*FROM Fidelidad

-- Con Variables 




--12. Agregue las personas que se encuentran en el archivo Nuevas Personas a la tabla personas.



--A. Creación de una tabla que se llame personas temporal

SELECT* 
INTO 
PersonasTemporal
FROM personas
WHERE 1=2


SELECT*FROM PersonasTemporal
TRUNCATE TABLE PersonasTemporal

DROP TABLE PersonasTemporal

TRUNCATE TABLE Personastemporal

BULK INSERT Personastemporal
FROM "C:\Users\Lenovo\Documents\SQL Module 1\Nuevas_Personas.txt"
WITH (
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n'
)

--B. Creación de una tabla que se llame municipio temporal



SELECT nombre, id_municipios
INTO 
MunicipioTemporal
FROM Municipios
WHERE 1=2


SELECT*FROM personastemporal

CREATE PROCEDURE AgregarClientes AS

--C. Subir la información a personas temporal

BULK INSERT Personastemporal
FROM "C:\Users\Lenovo\Documents\SQL Module 1\Nuevas_Personas.txt"
WITH (
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n'
)

SELECT*FROM MunicipioTemporal

--D. Subir la información a municipio temporal

BULK INSERT Municipiotemporal
FROM "C:\Users\Lenovo\Documents\SQL Module 1\Municipios_Homologados.txt"
WITH (
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n'
)


--E. Unir los datos de ambas tablas

SELECT*
FROM personastemporal AS P
INNER JOIN MunicipioTemporal AS M
ON P.municipio = M.nombre

--F. Subir la información a la tabla personas


INSERT INTO Personas
SELECT Cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, id_municipios, celular, correo
FROM personastemporal AS P
INNER JOIN MunicipioTemporal AS M
ON P.municipio = M.nombre

SELECT*FROM personastemporal

-- G. Limpiar tablas

TRUNCATE TABLE PersonasTemporal
TRUNCATE TABLE MunicipioTemporal


EXECUTE AgregarClientes


SELECT*FROM Personas

DELETE Personas
WHERE cedula IN (333333,111111,222222)

DROP PROCEDURE AgregarClientes


SELECT Producto, municipio
FROM Transacciones
INNER JOIN Personas
ON Transacciones.cedula = Personas.cedula
WHERE municipio = ANY ( SELECT id_municipios
                        FROM  Municipios
						WHERE id_municipios = nombre_depto)
						

SELECT nombre_depto,
       producto,
       Prod.nombre_producto,
       SUM (cantidad) 'cantidad'
FROM Transacciones AS T
INNER JOIN Personas as P
ON T.cedula = P.cedula
INNER JOIN Municipios AS M
ON P.municipio = M.id_municipios
INNER JOIN Productos AS Prod
ON T.producto = Prod.id_producto
GROUP BY producto, Prod.nombre_producto, nombre_depto
ORDER BY nombre_depto

