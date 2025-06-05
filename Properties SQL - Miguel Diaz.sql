-- 3. Escriba una sentencia SELECT para recuperar la ciudad, el precio de venta y la fecha de creaci�n de todos los inmuebles que se han publicado
-- por un precio superior al precio medio de venta de todos los inmuebles publicados para Carolina Castro Jaramillo*

-- 3.1. PRECIO MEDIO  DE LOS INMUEBLES DE CAROLINA CASTRO.
SELECT ROUND(AVG(precio),0) AS Precio_Medio_Bienes_Carolina_Castro  -- se selecciona el promedio de de precio de los inmuebles.
FROM Habi_Tabla_2 -- Se selecciona la base de datos
WHERE nombre_cliente = 'Carolina Castro Jaramillo'; -- y se crea el condicional con el nombre de carolina para que saque el promedio.

-- 3.2.PRECIO MEDIO DE TODOS LOS INMURBLES, BASADO EN EL PRECIO MEDIO DE LOS INMUEBLES DE CAROLINA CASTRO. 
SELECT  
    ciudad,  -- Se selecciona latitud  y longitud dado que la tabla no tiene ciudad.
    precio,             -- Se selecciona el precio.
	Fecha               -- Se seleciona la Fecha.
	
FROM  
    Habi_Tabla_2        -- Se seleciona la base de datos.
WHERE                   -- Se crea el condicional. 
    precio > (          -- Donde precio debe ser mayour al promedio de precio de los inmuebles de Carolina Castro. (Subconsulta)
        SELECT AVG(precio)
        FROM Habi_Tabla_2 
        WHERE nombre_cliente = 'Carolina Castro Jaramillo'  
    )
ORDER BY precio DESC;  -- Se ordenan los precios de manera descendente. 

--4. Escriba la sentencia SELECT que resuelve la siguiente pregunta: �Cu�l es el promedio de precios de venta por tama�o de propiedad (en metros cuadrados) para propiedades que tienen al menos 3 habitaciones y 2 ba�os? 
--Considere solo promedio de precio de venta mayor a 80.000.000 y muestre el top 20 ordenado de forma descendente por el promedio del precio de venta*


SELECT TOP 20  -- Se selecicona el top 20 de la b�squeda.
    area_m2,   -- Se elige el area
    alcobas,   -- se elige las alcobas
    banios,    -- Se eligen los ba�os para que aparezcan en la busqueda.
    FORMAT(AVG(CAST(precio AS DECIMAL(18,2))), 'N0') AS promedio_precio_venta -- se trae el promedio de los precios en decimales y con puntos y se le pone un alias a la columna
FROM Habi_Tabla_2  -- Se elige la base de datos.
WHERE alcobas >= 3  -- Se crea el condicional de mayor o igual a 3 alcobas
    AND banios >= 2 -- y mayor igual a dos ba�os.
GROUP BY area_m2, alcobas, banios -- Se agrupa la informaci�n del areas, alcobas, y banios.
HAVING AVG(precio) > 80000000 -- donde el promecio es mayo a 80 millones.
ORDER BY promedio_precio_venta DESC; -- y se ordena por el promedio de precio de venta de manera desencdiente.

-- Precios m�nimo y m�ximo de los inmuebles. 
SELECT FORMAT(MAX(CAST(precio AS DECIMAL (20,2))), 'N0') AS Valor_Maximo, FORMAT(MIN(CAST(precio AS DECIMAL (20,2))), 'N0') AS Valor_Minimo FROM Habi_Tabla_2;

-- Precio de venta menos a 90 millones, con el n�mero de ba�os y alcobas
SELECT banios, alcobas, precio
FROM Habi_Tabla_2  
WHERE precio < 90000000;