--2.-crear una tabla que se llame cambioDePrecios
-- CambioID int identity primary key,
-- productoId int not null,
-- precioAnterior money not nu
-- precioNuevo money
-- fecha de cambio dateDay (getDatec)
-- paso n.3 -> debe haceptar 2 parametros, el producto a cambiar y el nuevo precio
--paso n.4 -> el procedimiento debe actualizar el precio del producto a la tabla products
--paso n.5 -> el procedimiento debe insertar un registro en la tabla cambio de precios con los detalles del cambio



CREATE TABLE cambioDePrecios (
    CambioID INT IDENTITY PRIMARY KEY,
    productoId INT NOT NULL,
    precioAnterior MONEY NOT NULL,
    precioNuevo MONEY NOT NULL,
    fechaCambio DATETIME DEFAULT GETDATE()
);
GO


CREATE or ALTER PROCEDURE actualizarPrecioProducto
    @productoId INT,
    @precioNuevo MONEY
AS
BEGIN

    DECLARE @precioAnterior MONEY;
    SELECT @precioAnterior = UnitPrice
    FROM Products
    WHERE ProductID = @productoId;
    UPDATE products
    SET UnitPrice = @precioNuevo
    WHERE ProductID = @productoId;
    INSERT INTO cambioDePrecios (productoId, precioAnterior, precioNuevo, fechaCambio)
    VALUES (@productoId, @precioAnterior, @precioNuevo, GETDATE());
END;
GO

EXEC actualizarPrecioProducto @productoId = 1, @precioNuevo = 20.00


use NORTHWND

SELECT * FROM cambioDePrecios

SELECT * FROM Products