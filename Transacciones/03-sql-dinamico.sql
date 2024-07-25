use NORTHWND;
go

-- crear un proc que reciva como parametro de entrada el nombre de una tabla y visualize todos sus registros 

 create or alter PROC spu_mostrar_datos_tabla
 @tabla varchar(100)
 as 
 BEGIN
 --sql dinamico
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM ' + @tabla;
    EXEC(@sql)
 END;
 GO


 EXEC spu_mostrar_datos_tabla " customers"
go

SELECT * FROM Customers
GO

--------------------------------------------------------------

 create or alter PROC spu_mostrar_datos_tabla2
 @tabla varchar(100)
 as 
 BEGIN
 --sql dinamico
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM ' + @tabla;
    EXEC sp_executesql @sql;
 END;
 GO


  EXEC spu_mostrar_datos_tabla " customers"
go