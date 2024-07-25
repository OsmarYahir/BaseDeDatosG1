
use NORTHWND
go
-- ejercicio 2 insertar una venta 

create or alter proc spu_agregar_venta
			@CustomerID nchar(5),
           @EmployeeID int,
           @OrderDate datetime,
           @RequiredDate datetime,
           @ShippedDate datetime,
           @ShipVia int,
           @Freight money = null,
           @ShipName nvarchar(40)=null,
           @ShipAddress nvarchar(60)=null,
           @ShipCity nvarchar(15)=null,
           @ShipRegion nvarchar(15)=null,
           @ShipPostalCode nvarchar(10)=null,
           @ShipCountry nvarchar(15)=null,

		  
           @ProductID int,
           @Quantity smallint,
           @Discount real = 0
as 
begin
	begin transaction;
	begin try
	INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@EmployeeID ,
           @OrderDate ,
           @RequiredDate ,
           @ShippedDate ,
           @ShipVia ,
           @Freight ,
           @ShipName ,
           @ShipAddress ,
           @ShipCity ,
           @ShipRegion ,
           @ShipPostalCode ,
           @ShipCountry );

		   -- obtener el id insertado en orderds 
		   declare @orderid int;
		   set @orderid = SCOPE_IDENTITY();

		   --obtener el precio del producto 
		   declare @precioVenta money
		   select @precioVenta = UnitPrice from Products
		   where´ProductID = @ProductID

		   --insertar en ordendetails
		   INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES
           (@ProductID ,
           @precioVenta ,
           @Quantity ,
           @Discount )

	--actualizar la tabla products en el campo unitinstock

	update Products
	set UnitsInStock = UnitsInStock - @Quantity
	where ProductID = @ProductID

	commit transaction;

	end try
	begin catch
		rollback transaction;
		declare @mensajeError nvarchar(4000);
		set @mensajeError = ERROR_MESSAGE();
		print @mensajeError;
	end catch
end;
go


create or alter proc spu_agregar_venta
    @CustomerID nchar(5),
    @EmployeeID int,
    @OrderDate datetime,
    @RequiredDate datetime,
    @ShippedDate datetime,
    @ShipVia int,
    @Freight money = null,
    @ShipName nvarchar(40) = null,
    @ShipAddress nvarchar(60) = null,
    @ShipCity nvarchar(15) = null,
    @ShipRegion nvarchar(15) = null,
    @ShipPostalCode nvarchar(10) = null,
    @ShipCountry nvarchar(15) = null,

    @ProductID int,
    @Quantity smallint,
    @Discount real = 0
as
begin
    begin transaction;
    begin try
        -- Insert into Orders
        insert into [dbo].[Orders]
            ([CustomerID]
            ,[EmployeeID]
            ,[OrderDate]
            ,[RequiredDate]
            ,[ShippedDate]
            ,[ShipVia]
            ,[Freight]
            ,[ShipName]
            ,[ShipAddress]
            ,[ShipCity]
            ,[ShipRegion]
            ,[ShipPostalCode]
            ,[ShipCountry])
        values
            (@CustomerID,
            @EmployeeID,
            @OrderDate,
            @RequiredDate,
            @ShippedDate,
            @ShipVia,
            @Freight,
            @ShipName,
            @ShipAddress,
            @ShipCity,
            @ShipRegion,
            @ShipPostalCode,
            @ShipCountry);

        -- Obtener el ID insertado en Orders
        declare @orderid int;
        set @orderid = SCOPE_IDENTITY();

        -- Obtener el precio del producto
        declare @precioVenta money;
        select @precioVenta = UnitPrice from Products
        where ProductID = @ProductID;

        -- Insertar en Order Details
        insert into [dbo].[Order Details]
            (
            [ProductID]
            ,[UnitPrice]
            ,[Quantity]
            ,[Discount])
        values
            (
            @ProductID,
            @precioVenta,
            @Quantity,
            @Discount);

        -- Actualizar la tabla Products en el campo UnitsInStock
        update Products
        set UnitsInStock = UnitsInStock - @Quantity
        where ProductID = @ProductID;

        -- Confirmar la transacción
        commit transaction;
    end try
    begin catch
        -- Deshacer la transacción en caso de error
        rollback transaction;

        -- Obtener el error
        declare @mensajeError nvarchar(4000);
        set @mensajeError = ERROR_MESSAGE();
        print @mensajeError;
    end catch
end;
go
