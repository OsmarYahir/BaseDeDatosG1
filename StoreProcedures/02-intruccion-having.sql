use NORTHWND;

select o.OrderID, o.OrderDate, c.CompanyName, c.City, od.Quantity, od.UnitPrice
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c 
on c.CustomerID = o.CustomerID
where c.City in('San Cristóbal','México D.F.') 
go


select c.CompanyName,  COUNT(o.OrderID) as 'numero odenes'
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c 
on c.CustomerID = o.CustomerID
where c.City in('San Cristóbal','México D.F.') 
group by CompanyName
having COUNT(*)>18
go

-- obtener los nommbre de los productos y sus categorias en donde el precio promedio de los productos 
-- en la misma categoria sea mayor a 20 


select p.ProductName, c.CategoryName, avg(p.UnitPrice) as promedio from Categories as c
left join Products as p
on p.CategoryID = c.CategoryID
where c.CategoryID is not null
group by p.ProductName, c.CategoryName
having avg(p.UnitPrice) > 20
order by CategoryName 



select p.ProductName, c.CategoryName, avg(p.UnitPrice) as promedio from Categories as c
left join Products as p
on p.CategoryID = c.CategoryID
where c.CategoryID is not null
group by p.ProductName, c.CategoryName
having max(p.UnitPrice) > 100
order by CategoryName 

