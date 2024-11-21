create database storeanalysis;
use storeanalysis;

use university;
select * from students;
create VIEW above_22 AS
select student_id,first_name,last_name,age
from students
where age > 22;

select * from above_22;

-- CREATE A VIEW FOR FEMALE LECTURERS

CREATE VIEW female_lecturers as
select lecturer_id,first_name,last_name,gender
from lecturers
where gender= 'f';

select * from female_lecturers;


use storeanalysis;
-- Select all data from the categories table.
select *
from categories;

-- creata a report that shows the category name and description from the categories table, sorted bt the category name
select categoryname,description
from categories
order by categoryname;

-- Create a report that shows the contact name, company name, contact title, and phone number from the customers table, sorted by phone.
select contactname,companyname,contacttitle,phone
from customer
order by phone;

alter table categories_north rename to categories;
alter table customer_north rename to customer;
alter table employees_north rename to employees;
alter table suppliers_north rename to suppliers;

-- Create a report that shows the contact name, company name, contact title, and phone number from the customers table, sorted by phone.
select contactname,companyname,contacttitle,phone
from customer
order by phone;

--  Create a report that shows the capitalized first name and last name renamed as full name, respectively, and hiredate from the employees table, sorted from newest to oldest employee
select lower(concat(Firstname,' ',Lastname)) as Full_name, hiredate
from employees
order by hiredate desc;

 -- Create a report that shows the top 10 orderid, orderdate, shippeddate, customerid, and freight from the orders table, sorted by freight in descending order
select orderid,orderdate,shippeddate,customerid,freight
from orders
order by freight desc
limit 10;

-- Create a report that shows all the customer IDs in lowercase and renamed as "ID" from the customers table
select lower(customerid) as ID
from customer;

-- Create a report that shows the company name, fax, phone, country, and homepage from the supplier table, sorted by the country in descending order, then by company name in ascending order.
select companyname,fax,phone,country,homepage
from suppliers
order by country desc,companyname asc;

-- Create a report that shows the company name and contact name of all customers from "cactus"
select companyname,contactname
from customer
where companyname like '%cactus%';

-- Create a report showing product name, unit price, quantity per unit, and units in stock for products that are out of stock.
select productname,unitprice,quantityperunit,UnitsInStock
from products
where unitsinstock = '0';


select sum(unitprice)
from products
group by unitprice
having sum(unitprice);

-- Create a report showing the contact name, address, and city of all customers not from Germany Mexico, or Spain
select contactname,address,country
from customer
where country not in ('germany','mexico','spain');

--  Create a report showing order date, shipped date, customer ID, and freight of all orders placed on May 21, 1996.
select orderdate,shippeddate,customerid,freight
from orders
where orderdate like '1996-05-21 00:00:00';

-- Create a report showing the first name, last name, and country of employees not from the United state
select firstname,lastname,country
from employees
where country not in ('USA');

-- Create a report showing the first name, last name, and country of employees not from the United from all orders shipped later than required.
select employeeid,orderid,customerid,requireddate,shippeddate
from orders
where shippeddate>requireddate;

-- Create a report that shows the city, company name, and contact name of customers from cities starting with the letter "A" or "B."
select city,companyname,contactname
from customer
where city like 'A%' OR 'B%';

-- Create a report showing all the even numbers of order IDs from the orders table
SELECT orderid
from orders 
where orderid % 2= 0;

--  Create a report showing all the odd numbers of order IDs from the orders table.
SELECT orderid
from orders 
where orderid % 2= 1;
 
-- Create a report that shows all the orders where the freight cost is more than 500 dollars.
select freight
from orders
where freight > 500;

-- Create a report that shows the product name, units in stock, units on order, and reorder level of all products that are up for reorder
select productname,unitsinstock,unitsonorder,reorderlevel
from products
where reorderlevel =0;

-- Create a report that shows the order ID, contact name, unit price, quantity, and discount from the order details, orders, and customer table, with discounts given on every purchase.
select o.orderid,c.contactname,od.unitprice,od.quantity,od.discount
from orderdetails od
join orders o on o.orderid = od.orderid
join customer c on c.customerid = o.customerid
where quantity > 20;

-- Create a report that shows the supplier ID, company name, category name, product name, and unit price from the products, suppliers, and categories table.
select p.supplierid,s.companyname,c.categoryname,p.productname,p.unitprice
from products p
join suppliers s on s.supplierid = p.supplierid
join categories c on c.categoryid= p.categoryid;

-- Create a view named "customerinfo" that shows the customer ID, company name, contact name, contact title, address, city, country, phone, order date, required date, and shipped date from the customers and orders table.
create view customerinfo as
select c.customerid,
c.companyname,
c.contactname,
c.contacttitle,
c.address,
c.city,
c.country,
c.phone,
o.orderdate,
o.requireddate,
o.shippeddate
from customer c
join orders o on o.customerid =c.customerid;

select * from customerinfo;

select year(birthdate) from employees;
select firstname,lastname,year(birthdate) as birthyear
from employees;

-- create a report that shows the company name and contact name of all customer that do not have a fax number 
select companyname,contactname
from customer
where fax =0;

-- Create a report that shows the first name and last name of all employees that do not report to anybody
select firstname,lastname
from employees
where reportsto =0;

-- Create a report showing all the odd numbers of order IDs from the orders table
select orderid
from orders
where orderid % 2=1;

--  Create a report that shows the company name, contact name, and fax of all customers that do not have a fax number, sorted by contact name
select companyname,contactname,fax
from customer
where fax =0
order by contactname;

-- Create a report that shows the city, company name, and contact name of customers from cities that have the letter "l" in the name, sorted by contactname 
select city,companyname,contactname
from customer
where city like '%l%'
order by contactname;

--  Create a report that shows the first name, last name, and birthdate of employees born in 1950
select firstname,lastname,birthdate
from employees
where birthdate like '1950';

--- Create a report that shows the first name, last name, and the year of birthdate as "birthyear" from the employees table
select firstname,lastname,year(birthdate)as birthyear
from employees;

-- Create a report showing order ID and the total number of order IDs as "number of orders" from the order details table, grouped by order ID and sorted by the number of orders in descending order
select orderid,sum(orderid)as numberoforders
from orders
group by orderid
order by numberoforders desc;

--  Create a report that shows the supplier ID, product name, and company name of products supplied by Exotic Liquids, Specialty Biscuits Ltd., and Escargots Nouveaux, sorted by supplier ID.
select s.supplierid,p.productname,s.companyname
from products p
join suppliers s on p.supplierid =s.supplierid
where s.companyname in ('exotic liquids', 'speciality biscuit Ltd' 'escargot nouveaux')
order by supplierid;

--  Create a report that shows the ship postal code, order ID, order date, required date, and shipped date of all orders with a ship postal code beginning with "98124."
select shippostalcode,orderid,orderdate,requireddate,shippeddate
from orders
where shippostalcode like '%98124';

-- Create a report that shows the contact name, contact title, and company name of customers that do not have "sales" in their contact title
select contactname,contacttitle,companyname
from customer
where contacttitle not like '%sales%';

-- Create a report that shows the last name, first name, and city of all employees in cities other than seattle
select firstname,lastname,city
from employees
where city not like '%seattle%';


-- Create a report that shows the average, minimum, and maximum unit price of all products as average price, minimum price, and maximum price, respectively
select avg(unitprice),min(unitprice),max(unitprice)
from products;

-- Create a report that shows the contact name of all customers that do not have the letter "A" as the second letter in their contact name
select contactname
from customer
where contactname not like '_a%';

-- Create a report that shows the average unit price rounded to the nearest whole number, total price of units in stock, and the maximum number of orders from the product table. Save them as average price, total stock, and max order, respectively.
select round(avg(unitprice)) as averageprice,sum(unitsinstock) as totalstock,max(unitsonorder) as maxorder
from products; 

--  Create a report that shows the customer ID and sum of freight from the orders table with a sum of freight greater than 200 dollars, grouped by customer ID.
select customerid,sum(freight)
from orders
group by customerid
having sum(freight) > 200;


-- Create a report that shows the average, minimum, and maximum unit price of all products as average price, minimum price, and maximum price, respectively.
select avg(unitprice) as averageprice, min(unitprice) as minimumprice, max(unitprice) as maximumprice
from products;

--
















 










