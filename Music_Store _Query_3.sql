Q1 : Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and 
     total spent.
A1 : with best_selling_artist as 
	 (	
		 select a.artist_id as artist_id, a.name as artist_name,
		 sum(il.unit_price*il.quantity) as total_sales
		 from invoice_line as il
		 join track as t 
		 on t.track_id = il.track_id
		 join album as al
		 on al.album_id = t.album_id
		 join artist as a 
		 on a.artist_id = al.artist_id
		 group by a.artist_id
		 order by total_sales desc
		 limit 1
	 )
	 select c.customer_id, c.first_name, bsa.artist_name, 
	 sum(il.unit_price*il.quantity) as amount_spent 
	 from invoice as i 
	 join customer as c 
	 on c.customer_id = i.customer_id
	 join invoice_line as il
	 on il.invoice_id = i.invoice_id
	 join track as t
	 on t.track_id = il.track_id
	 join album as al
	 on al.album_id = t.album_id
	 join best_selling_artist as bsa 
	 on bsa.artist_id = al.artist_id
	 group by c.customer_id, c.first_name, c.last_name, bsa.artist_name
	 order by amount_spent desc;
	 
Q2 : We want to find out the most popular music Genre for each country. We determine the most popular genre as the 
	 genre with the highest amount of purchases. Write a query that returns each country along with the top genre. 
	 For countries where the maximum number of purchases is shared return all Genres.
A2 : with popular_genre as 
	 (
	 	 select count(il.quantity) as purchases, c.country, g.name, g.genre_id,
		 row_number() over(partition by c.country order by count(il.quantity) desc) as RowNo
		 from invoice_line as il
		 join invoice as i
		 on i.invoice_id = il.invoice_id
		 join customer as c
		 on c.customer_id = i.customer_id
		 join track as t
		 on t.track_id = il.track_id
		 join genre as g
		 on g.genre_id = t.genre_id
		 group by c.country, g.name, g.genre_id
		 order by c.country asc, purchases desc
	 )
	 select * from popular_genre where RowNo = 1;

Q3 : Write a query that determines the customer that has spent the most on music for each country along with the 
	 top customer and how much they spent. For countries where the top amount spent is shared, provide all customers 
	 who spent this amount.
A3 : with recursive 
	 	customer_with_country as 
		(
			select c.customer_id, c.first_name, c.last_name, i.billing_country, sum(i.total) as total_spending
			from invoice as i
			join customer as c
			on c.customer_id = i.customer_id
			group by c.customer_id, c.first_name, c.last_name, i.billing_country
			order by c.first_name, c.last_name desc
	
		),
		
		country_max_spending as
		(
			select billing_country, max(total_spending) as max_spending
			from customer_with_country
			group by billing_country
		)
		
	 select cc.billing_country, cc.total_spending, cc.first_name, cc.last_name
	 from customer_with_country as cc
	 join country_max_spending as ms
	 on cc.billing_country = ms.billing_country
	 where cc.total_spending = ms.max_spending
	 order by cc.billing_country;