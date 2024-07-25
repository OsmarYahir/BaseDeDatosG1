--actualize los precios de un producto y que guarde esa modificacion en una tabla de historicos 


use NORTHWND;
GO

SELECT *
FROM Products
WHERE ProductID = 2
GO


create table preciosHistoricos
(
    id int IDENTITY(1,1) not null,
    precioAnterior money,
    precioNuevo money,
    fechaModificacion date DEFAULT GETDATE()
);
GO

CREATE OR ALTER PROCEDURE spu_actualizar_precios
@Producto int,
@nuevoPrecio money
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @precioAnterior money;

        SELECT @precioAnterior = UnitPrice 
        FROM Products
        WHERE ProductID = @Producto;

        UPDATE Products 
        SET UnitPrice = @nuevoPrecio
        WHERE ProductID = @Producto;

        INSERT INTO preciosHistoricos (precioAnterior, precioNuevo)
        VALUES (@precioAnterior, @nuevoPrecio);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @mensajeError VARCHAR(100);
        SET @mensajeError = ERROR_MESSAGE();
        PRINT @mensajeError;
    END CATCH;
END
GO



EXEC spu_actualizar_precios 3,2.00
go

SELECT *
FROM preciosHistoricos
SELECT *
FROM Products
GO


create or alter PROCEDURE spu_actualizar_precios2
AS
BEGIN
    DECLARE @precioAnterior money,@Producto int = 2,
    @nuevoPrecio money = 100.00

    SELECT @precioAnterior = UnitPrice
    FROM Products
    WHERE ProductID = @Producto;

    UPDATE Products 
    set UnitPrice = @nuevoPrecio
    where ProductID = @Producto

    INSERT preciosHistoricos
        (precioAnterior, precioNuevo)
    VALUES
        (@precioAnterior, @nuevoPrecio)

END
go

EXEC spu_actualizar_precios2
go



--realizar un sp que elimine una orden de compra completa y debe de actualizar los unit in stock 


CREATE OR ALTER PROC sp_Cancelar
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
        BEGIN
            PRINT 'La orden con ID ' + CAST(@OrderID AS NVARCHAR(10)) + ' no se encuentra en la base de datos.';
            RETURN;
        END

        BEGIN TRANSACTION;

        UPDATE P
        SET P.UnitsInStock = P.UnitsInStock + OD.Quantity
        FROM Products P
        INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
        WHERE OD.OrderID = @OrderID;

        DELETE FROM [Order Details] WHERE OrderID = @OrderID;

        DELETE FROM Orders WHERE OrderID = @OrderID;

        COMMIT TRANSACTION;
        
        PRINT 'Orden ' + CAST(@OrderID AS NVARCHAR(10)) + ' cancelada y stock de productos actualizado correctamente.';
    END TRY
    BEGIN CATCH
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    END CATCH
END

EXEC sp_Cancelar @OrderID = 10250;