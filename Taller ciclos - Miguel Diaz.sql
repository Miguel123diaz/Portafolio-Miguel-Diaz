/*UNIVERSIDAD EAN
CURSO SQL
TALLER 6: Ciclos y cursores
Jeison Pinilla*/


--1. Construya un ciclo que imprima los números del 1 al 30.

DECLARE @n INT = 1
DECLARE @M INT = 30

WHILE @n <= @M
BEGIN
PRINT (CONCAT ('Este es el número:', @n))
SET @n = @n + 1
END



--2. Construya un ciclo que imprima los números pares del 1 al 30.

DECLARE @n INT = 1
DECLARE @M INT = 30

WHILE @n <= @M
BEGIN
IF @n%2 = 0
PRINT (CONCAT ('Este es el número:', @n))
SET @n = @n + 1
END


DECLARE @n INT = 2
DECLARE @M INT = 30
WHILE @n <= @M
BEGIN 
    PRINT (CONCAT ('Este es el numero', @n))
    SET @n = @n + 2
END


-- CON CONTINUE

DECLARE @n INT = 0
DECLARE @M INT = 30

WHILE @n <= @M
BEGIN
SET @n = @n + 1
IF @n%2 <> 0
CONTINUE
PRINT (CONCAT ('Este es el número:', @n))
END


--3. Construya un ciclo que imprima los múltiplos del 17 hasta que encuentre un múltiplo
--de 7.

DECLARE @n INT = 0
DECLARE @M INT = 30

WHILE @n <= @M
BEGIN
SET @n = @n + 1
IF @n%2 <> 0
CONTINUE
PRINT (CONCAT ('Este es el número:', @n))
END 


DECLARE @n INT = 0;
DECLARE @M INT = 1000; -- Puedes ajustar este valor según tus necesidades

WHILE @n <= @M
BEGIN
    SET @n = @n + 1;
    
    IF @n % 17 <> 0
        CONTINUE;
    
    IF @n % 7 = 0
        BREAK;
    
    PRINT CONCAT('Este es el número: ', @n);
END

-- EJERCICIO DEL PROFE ABAJO

DECLARE @n INT = 1
DECLARE @M INT = 17
DECLARE @P INT = 7

WHILE (@n*@M) % @P <> 0
BEGIN
PRINT (CONCAT ('Este es el número:', @n*@M))
SET @n = @n + 1
END 


DECLARE @n INT = 1
DECLARE @M INT = 17
DECLARE @P INT = 7
DECLARE @L INT = 1000000

WHILE @n <= @L
BEGIN
PRINT (CONCAT ('Este es el número:', @n*@M))
SET @n = @n + 1
IF (@n*@M) %@P = 0
BREAK
END 


DECLARE @n FLOAT = -5
DECLARE @M INT = 5
DECLARE @L INT = 10

WHILE @n <= @M
BEGIN
SET @n = @n + 1
IF @N = 0 
CONTINUE
PRINT (CONCAT ('Este es el número:', @L/@n))
END 



--4. Actualice la tabla transacciones con la siguiente información: La cédula 1214722914
--compró el 2013-02-19 2 unidades del producto 174563 de contado.

INSERT INTO transacciones
VALUES (1214722914, '2013-02-19', 174563,2,1)



--5. Declare una tabla que contenga la cantidad de unidades que se han vendido en cada mes
--creo la tabla


SELECT DATEPART (YEAR, fecha) 'año',
       DATEPART (MONTH, fecha) 'mes',
	   SUM (Cantidad) 'Cantidad'
	   FROM Transacciones
	   GROUP BY fecha
	   ORDER BY fecha

DECLARE @CantidadesFecha TABLE 
(Año INT,mes INT,cantidad INT)


DECLARE @ano INT = (SELECT MIN (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @ANOMAX INT = (SELECT MAX (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @mes INT = 1
DECLARE @MESMAX INT = 12
DECLARE @CANTIDAD INT

WHILE @ano <= @ANOMAX
BEGIN 
WHILE @mes <= @MESMAX
BEGIN
SET @CANTIDAD = (SELECT SUM (Cantidad) 
                 FROM Transacciones 
				 WHERE YEAR (fecha) = @ano AND MONTH (fecha) = @mes)
		INSERT INTO @CantidadesFecha
	    VALUES (@ano, @mes, @CANTIDAD) 
		SET @mes = @mes + 1
        END
	SET @ano = @ano +1 
	SET @mes = 1
END
SELECT*FROM @CantidadesFecha


--6. Cree la misma tabla anterior pero únicamente que aparezcan los meses del ´ultimo a˜no
--que han tenido ventas.

DECLARE @CantidadesFecha TABLE 
(Año INT,mes INT,cantidad INT)


DECLARE @ano INT = (SELECT MIN (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @ANOMAX INT = (SELECT MAX (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @mes INT = 1
DECLARE @MESMAX INT = 12
DECLARE @CANTIDAD INT
DECLARE @MESMAXULT INT = (SELECT MAX(MONTH (Fecha)) FROM Transacciones 
                          WHERE YEAR (fecha) = @ANOMAX)

WHILE @ano <= @ANOMAX
BEGIN 
WHILE @mes <= @MESMAX
BEGIN
SET @CANTIDAD = (SELECT SUM (Cantidad) 
                 FROM Transacciones 
				 WHERE YEAR (fecha) = @ano AND MONTH (fecha) = @mes)
		INSERT INTO @CantidadesFecha
	    VALUES (@ano, @mes, @CANTIDAD) 
		IF @mes = @MESMAXULT+1 AND @ANOMAX = @ANOMAX
		BREAK
		SET @mes = @mes + 1
        END
	SET @ano = @ano +1 
	SET @mes = 1
END
SELECT*FROM @CantidadesFecha
-- Que no aparezcan nulos 

DECLARE @CantidadesFecha TABLE 
(Año INT,mes INT,cantidad INT)


DECLARE @ano INT = (SELECT MIN (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @ANOMAX INT = (SELECT MAX (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @mes INT = 1
DECLARE @MESMAX INT = 12
DECLARE @CANTIDAD INT
DECLARE @MESMAXULT INT = (SELECT MAX(MONTH (Fecha)) FROM Transacciones 
                          WHERE YEAR (fecha) = @ANOMAX)

WHILE @ano <= @ANOMAX
BEGIN 
WHILE @mes <= @MESMAX
BEGIN
SET @CANTIDAD = (SELECT SUM (Cantidad)
                 FROM Transacciones 
				 WHERE YEAR (fecha) = @ano AND MONTH (fecha) = @mes)
		INSERT INTO @CantidadesFecha
	    VALUES (@ano, @mes, @CANTIDAD) 
		IF @mes = @MESMAXULT+1 AND @ANOMAX = @ANOMAX
		BREAK
		SET @mes = @mes + 1
        END
	SET @ano = @ano +1 
	SET @mes = 1
END
SELECT Año, mes, CASE WHEN cantidad IS NULL THEN 0
ELSE cantidad 
END  'Cantidad'
FROM @CantidadesFecha

-- Manera difícil

DECLARE @CantidadesFecha TABLE 
(Año INT,mes INT,cantidad INT)


DECLARE @ano INT = (SELECT MIN (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @ANOMAX INT = (SELECT MAX (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @mes INT = 1
DECLARE @MESMAX INT = 12
DECLARE @CANTIDAD INT
DECLARE @MESMAXULT INT = (SELECT MAX(MONTH (Fecha)) FROM Transacciones 
                          WHERE YEAR (fecha) = @ANOMAX)

WHILE @ano <= @ANOMAX
BEGIN 
WHILE @mes <= @MESMAX
BEGIN
SET @CANTIDAD = (SELECT CASE WHEN SUM (Cantidad) IS NULL THEN 0 
                 ELSE SUM (Cantidad)
				 END 'Cantidad'
                 FROM Transacciones 
				 WHERE YEAR (fecha) = @ano AND MONTH (fecha) = @mes)
		INSERT INTO @CantidadesFecha
	    VALUES (@ano, @mes, @CANTIDAD) 
		IF @mes = @MESMAXULT+1 AND @ANOMAX = @ANOMAX
		BREAK
		SET @mes = @mes + 1
        END
	SET @ano = @ano +1 
	SET @mes = 1
END
SELECT*FROM @CantidadesFecha

--7. Cree la misma tabla anterior pero únicamente que aparezcan los meses en los que ha
--habido ventas.

DECLARE @CantidadesFecha TABLE 
(Año INT,mes INT,cantidad INT)


DECLARE @ano INT = (SELECT MIN (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @ANOMAX INT = (SELECT MAX (DATEPART (YEAR, fecha)) FROM Transacciones)
DECLARE @mes INT = 1
DECLARE @MESMAX INT = 12
DECLARE @CANTIDAD INT
DECLARE @MESMAXULT INT = (SELECT MAX(MONTH (Fecha)) FROM Transacciones 
                          WHERE YEAR (fecha) = @ANOMAX)

WHILE @ano <= @ANOMAX
BEGIN 
WHILE @mes <= @MESMAX
BEGIN
SET @CANTIDAD = (SELECT SUM (Cantidad) 
                 FROM Transacciones 
				 WHERE YEAR (fecha) = @ano AND MONTH (fecha) = @mes)
		INSERT INTO @CantidadesFecha
	    VALUES (@ano, @mes, @CANTIDAD) 
		IF @mes = @MESMAXULT+1 AND @ANOMAX = @ANOMAX
		BREAK
		SET @mes = @mes + 1
        END
	SET @ano = @ano +1 
	SET @mes = 1
END
SELECT*FROM @CantidadesFecha
WHERE cantidad IS NOT NULL



--8. Cree un cursor que guarde la cédula de las personas y que a partir de ella genere consultas
--individuales para cada individuo traer primer nombre y celular

DECLARE @ITEM INT 
DECLARE ITEMCURSOR CURSOR 

FOR 
SELECT cedula
FROM Personas

OPEN ITEMCURSOR 

FETCH NEXT FROM ITEMCURSOR 
INTO @ITEM 
WHILE @@FETCH_STATUS = 0
BEGIN 
SELECT primer_nombre, celular
FROM Personas 
WHERE cedula = @ITEM
FETCH NEXT FROM ITEMCURSOR 
INTO @ITEM
END
CLOSE ITEMCURSOR
DEALLOCATE ITEMCURSOR

-- EJERCICIO

DECLARE @ITEM INT 
DECLARE ITEMCURSOR CURSOR 

FOR 
SELECT cedula
FROM Transacciones



OPEN ITEMCURSOR 

FETCH NEXT FROM ITEMCURSOR 
INTO @ITEM 
WHILE @@FETCH_STATUS = 0
BEGIN 
SELECT cedula, producto, count (cantidad)
FROM Transacciones
WHERE cedula = @ITEM
GROUP BY  cedula, producto
FETCH NEXT FROM ITEMCURSOR 
INTO @ITEM
END
CLOSE ITEMCURSOR
DEALLOCATE ITEMCURSOR

-- Compañero

DECLARE @ITEM INT
DECLARE ITEMCURSOR CURSOR

FOR
SELECT cedula 
FROM Personas

OPEN ITEMCURSOR

FETCH NEXT FROM ITEMCURSOR
INTO @ITEM
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT A.primer_nombre, C.nombre_producto,COUNT(B.CANTIDAD) AS CANTIDAD_COMPRADA
FROM PERSONAS A
LEFT JOIN Transacciones B
ON A.cedula =B.cedula
LEFT JOIN Productos C
ON B.producto = C.id_producto
WHERE A.cedula = @ITEM
GROUP BY primer_nombre,nombre_producto
FETCH NEXT FROM ITEMCURSOR
INTO @ITEM
END
CLOSE ITEMCURSOR
DEALLOCATE ITEMCURSOR

--9. Cree un cursor que realice una consulta por cada departamento mostrando la cantidad de unidades
-- que se compraron en cada municipio.


DECLARE @ITEM VARCHAR (100)
DECLARE ITEMCURSOR CURSOR

FOR
SELECT id_municipios
FROM Municipios


OPEN ITEMCURSOR

FETCH NEXT FROM ITEMCURSOR
INTO @ITEM
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT nombre_depto,municipio, SUM (CANTIDAD) AS CANTIDAD_COMPRADA
FROM Municipios A
INNER JOIN Personas B
ON A.id_municipios = B.municipio
INNER JOIN Transacciones
ON B.cedula = Transacciones.cedula
WHERE id_municipios = @ITEM
GROUP BY nombre_depto, municipio
FETCH NEXT FROM ITEMCURSOR
INTO @ITEM
END
CLOSE ITEMCURSOR
DEALLOCATE ITEMCURSOR




--10.Cree un disparador o Trigger que se active cuando se cambie el producto de una transacci´on
--y haga que se actualice la fecha por la fecha de cambio y que se guarde en una
--tabla que almacene los hist´oricos de estos cambios.


CREATE TABLE HistoricosActualizaciones 
(Id_actualizacion INT IDENTITY,
Id_transaccion INT, 
Fecha_inicial DATE,
Fecha_actualizacion DATE DEFAULT GETDATE (),
Producto_anterior INT)

SELECT*FROM HistoricosActualizaciones

CREATE TRIGGER Actualizaciontransacciones 
ON Transacciones 
AFTER UPDATE AS 
IF UPDATE (Producto) 
BEGIN 

UPDATE Transacciones 
SET fecha = GETDATE ()
WHERE id_transaccion = (SELECT id_transaccion FROM inserted)

INSERT INTO HistoricosActualizaciones (Id_transaccion,Fecha_inicial,Producto_anterior)
SELECT I.id_transaccion, D.fecha, D.producto
FROM inserted AS I
INNER JOIN deleted AS D
ON I.id_transaccion = D.id_transaccion
END



UPDATE Transacciones 
SET producto = 382901
WHERE id_transaccion = 12346378

SELECT*FROM	HistoricosActualizaciones

-- 2011-03-02  435672


