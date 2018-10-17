--PRACTICE JOINS
--1
select * from Invoice i
join InvoiceLine il
on i.InvoiceId = il.InvoiceId
where il.UnitPrice > 0.99

--2
select i.InvoiceDate, c.FirstName, c.LastName, i.Total  
from Invoice i
join Customer c
on c.CustomerId = i.CustomerId

--3
select c.FirstName, c.LastName, e.FirstName, e.LastName
from Customer c
join Employee e
on c.SupportRepId = e.EmployeeId
--4
select al.Title, a.Name
from Album al
join Artist a
on a.ArtistId = al.ArtistId
--5
select pt.TrackId
from PlaylistTrack pt
join Playlist p
on p.PlaylistId = pt.PlaylistId
where p.Name = 'Music'
--6
select t.Name
from Track t
join PlaylistTrack pt
on t.TrackId = pt.TrackId
where pt.PlaylistId=5
--7
select t.Name, p.Name
from Playlist p
join PlaylistTrack pt
on p.PlaylistId = pt.PlaylistId
join Track t
on pt.TrackId = t.TrackId
--8
select t.Name, al.Title
from Track t
join Album al
on t.AlbumId = al.AlbumId
join Genre g 
on g.GenreId = t.GenreId
where g.Name = 'Alternative'

--NESTED QUERIES
--1
select * 
from Invoice
where InvoiceId IN (select InvoiceId from InvoiceLine where UnitPrice > 0.99)
--2
select * 
from PlaylistTrack
where PlaylistId IN (select PlaylistId from Playlist where Name = 'Music')
--3

 select Name
 from Track
 where TrackId in (select TrackId from PlaylistTrack where PlaylistId = 5)
 --4
select *
 from Track
 where GenreId in (select GenreId from Genre where Name='Comedy')
 --5
 select *
 from Track
 where AlbumId in (select AlbumId from Album where Title='Fireball')
 --6
 select * 
 from Track
 where AlbumId in (select AlbumId from Album where ArtistId in (select ArtistId from Artist where Name = 'Queen'));

--UPDATING ROWS
--1
update Customer
 set Fax = null
 where Fax is not NULL
 --2
  update Customer
 set Company = "Self"
 where Company is null
 --3
  update Customer
 set LastName = 'Thompson'
 where FirstName='Julia' and LastName='Barnett'
 --4
  update Customer
 set SupportRepId = 4
 where Email = 'luisrojas@yahoo.cl'
 --5
  update Track
 set Composer = 'The darkness around us'
 where GenreId in (select GenreId from Genre where Name='Metal')
 and Composer is NULL

 --GROUP BY
 --1
 select g.Name, count(*)
from Track t
join Genre g on t.GenreId= g.GenreId
group by g.Name
--2
select g.Name, count(*)
from Track t
join Genre g on t.GenreId= g.GenreId
where g.Name='Pop' or g.Name = 'Rock'
group by g.Name

--3
select ar.Name, count(*)
from Artist ar
join Album al
on ar.ArtistId=al.ArtistId
group by al.ArtistId

--DISTINCT
--1
select distinct Composer
from Track
--2
select distinct BillingPostalCode
from Invoice
--3
select distinct Company
from Customer

--DELETE ROWS
--1
 delete from practice_delete where type='bronze'
 --2
  delete from practice_delete where type='silver'
  --3
   delete from practice_delete where value=150



--simulation
create table if not exists users(
  id integer primary key autoincrement,
  name text,
  email text
  );
 create table if not exists products(
   id integer primary key autoincrement,
   name text,
   price integer
   );
  create table if not exists orders(
    id integer primary key autoincrement,
    productId integer references products(id),
    qty integer
  );
  insert into users
  (name, email)
  values
  ('madi', 'madi@gmail.meow'),
  ('alpy', 'alpy@gmail.meow'),
  ('randi', 'randi@m.meow');
  
  insert into products
  (name, price)
  values
  ('shoes', 100),
  ('dress', 50),
  ('backpack', 75);
  
  insert into orders
  (productId, qty)
  values
  (1, 3),
  (3, 2),
  (2, 4);
  
  select * from users
  select * from orders;
   select * from products;
--get all products for first order
select * 
   from products p
   join orders o 
   on p.id = o.productId
   where o.id =1;

--get all orders
  select * from orders

--total cost of an order
select sum((p.price*o.qty)) 
   from products p
   join orders o 
   on p.id = o.productId
   where o.id=1
--add foreign key and update
alter table users
 add column order_id integer references orders(id) 
select * from users
 update users
 set order_id=1
 where users.id=1 
update users
 set order_id=2
 where users.id=2 
update users
 set order_id=3
 where users.id=3 

--get all orders for user
 select * 
 from orders o
 join users u
 on o.id = u.order_id
 where u.id =1
--get how many orders each user has
 select sum(order_id) 
 from orders o
 join users u
 on o.id = u.order_id
 where u.id =1
