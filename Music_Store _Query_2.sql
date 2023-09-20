Q1 : Write query to return the email, first name, last name & Genre of all Rock Music listeners. 
	 Return your list ordered aplhabetically by email starting with A.
A1 : select distinct c.email, c.first_name, c.last_name 
	 from customer as c
     join invoice as i 
     on c.customer_id = i.customer_id
	 join invoice_line as il 
	 on i.invoice_id = il.invoice_id
	 where il.track_id in
	 (
	 	select t.track_id 
		from track as t
	    join genre as g 
		on t.genre_id = g.genre_id
 		where g.name = 'Rock' 
	 )
	 order by c.email asc;

Q2 : Lets invite the artists who have written the most rock music in our dataset. 
	 Write a query that returns the Artist name and total track count of the top 10 rock bands.
A2 : select ar.artist_id, ar.name, count(ar.artist_id) as total_track
	 from artist as ar
	 join album as al
	 on ar.artist_id = al.artist_id
	 join track as t
	 on t.album_id = al.album_id
	 join genre as g
	 on g.genre_id = t.genre_id
	 where g.name = 'Rock'
	 group by ar.artist_id
	 order by total_track desc
	 limit 10;
	 
Q3 : Return all the track names that have a song length longer than the average song length.
	 Return the Name and Milliseconds for each track. Order by the song length with the longest 
	 songs listed first.
A3 : select name, milliseconds
	 from track
	 where milliseconds >
	 (
	 	select avg(milliseconds) from track
	 ) 
	 order by milliseconds desc;
	  
