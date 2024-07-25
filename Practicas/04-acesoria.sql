

CREATE database acesoria;
use acesoria;
GO


CREATE TABLE empleado
(
    idempleado int IDENTITY(1,1) not NULL,
    nombre VARCHAR(20),
    apellido1 varchar(30),
    apellido2 VARCHAR(20),
    salario MONEY

);
GO

create or ALTER PROC spv_agregar_empleado
    @nombre VARCHAR(20) ='LUis',
    @apellido1 VARCHAR(30),
    @apellido2 VARCHAR(20),
    @salario money
AS
BEGIN
    INSERT INTO empleado
        (nombre,apellido1,apellido2,salario)
    VALUES(@nombre, @apellido1, @apellido2, @salario);
END;
GO



EXEC spv_agregar_empleado 'Ricardo','Ramirez','Hernnadez',50000;

EXECUTE spv_agregar_empleado default,'gonzales','Rubio',60000;

use NORTHWND
GO

create or alter PROC spv_consultar_clientes
AS
BEGIN
    select c.CompanyName as 'Cliente', o.OrderID, o.OrderDate, od.Quantity, od.UnitPrice
    from Customers as c
        INNER JOIN Orders as o
        on c.CustomerID = o.CustomerID
        INNER JOIN [Order Details] as od
        on o.OrderID = od.OrderID
END;
GO


CREATE OR ALTER PROCEDURE spv_consultar_clientes
    @anniinicial INT,
    @aniofinal INT
AS
BEGIN
    SELECT 
        c.CompanyName AS 'Cliente', 
        SUM(od.Quantity * od.UnitPrice) AS 'Total'
    FROM Customers AS c
    INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
    INNER JOIN [Order Details] AS od ON o.OrderID = od.OrderID
    WHERE YEAR(o.OrderDate) BETWEEN @anniinicial AND @aniofinal
    GROUP BY c.CompanyName;
END;
GO

EXEC spv_consultar_clientes 1996, 1997

select * from [Orders]