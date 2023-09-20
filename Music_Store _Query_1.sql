Q1 : Who is the senior most employee based on job title?
A1 : select * from employee;
	 select first_name from employee
	 order by levels desc
	 limit 1;

Q2 : Which countries have the most invoices?
A2 : select * from invoice;
	 select billing_country, sum(total) from invoice
	 group by billing_country
	 order by sum(total) desc
	 limit 1;
	 
Q3 : Which are the top 3 values of total invoices?
A3 : select * from invoice;
	 select billing_country, total from invoice
	 order by total desc
	 limit 3;

Q4 : Which city has the best customers? We would like to throw a promotional Music Festival in 
     the city we made the most money. Write a query that returns one city that has the highest 
	 sum of invoices totals. Return both the city name & sum of all invoice totals.
A4 : select * from invoice;
	 select billing_city, sum(total) as total_invoice from invoice
	 group by billing_city
	 order by sum(total) desc 
	 limit 1;
	 
Q5 : Who is the best customer? The customer who has spent the most money will be declared the
	 best customer. Write a query that returns the person who has spent the most money.
A5 : select * from customer;	 
	 select c.customer_id, c.first_name, c.last_name, sum(i.total)
	 from customer as c
	 join invoice as i 
	 on c.customer_id = i.customer_id
	 group by c.customer_id
	 order by sum(i.total) desc 
	 limit 1;

	 