use NORTHWND;
1-- Consultas Avansadas 

SELECT c.CategoryName as 'Categoria nombre', p.ProductName as 'NOmbre producto', p.UnitPrice as 'Precio', 
p.UnitsInStock as 'Existencia' FROM Categories as c
INNER JOIN Products as p
on c.CategoryID = p.CategoryID
WHERE ProductName in ('Beverages', 'Produce')