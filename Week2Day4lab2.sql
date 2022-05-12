-- Lab | SQL Join (Part II)
-- In this lab, you will be using the Sakila database of movie rentals.
use sakila;
-- Instructions
-- Write a query to display for each store its store ID, city, and country.
SELECT 
	st.store_ID,
    ci.city,
    co.country   
FROM 
	country AS co
JOIN 
	city AS ci
ON 
	ci.country_id = co.country_id
JOIN 
	address AS ad
ON 
	ci.city_id = ad.city_id
JOIN 
	store as st
ON 
	ad.address_ID = st.store_id; 
		
-- Write a query to display how much business, in dollars, each store brought in.

SELECT
	st.store_id,
	ROUND(SUM(p.amount),2)
FROM
	payment as p
JOIN
	staff as sa
ON 
	p.staff_id = sa.staff_id
JOIN
	store as st
	on sa.store_id = st.store_id
GROUP BY st.store_id;

-- Which film categories are longest?
SELECT
	c.name,
    ROUND(SUM(f.length),2)
 FROM 
	category as c
JOIN 
	film_category as fca
ON 
c.category_id = fca.category_id
JOIN
film as f
ON
fca.film_id = f.film_id
GROUP BY c.name
ORDER BY ROUND(SUM(f.length),2) DESC;
    
-- Display the most frequently rented movies in descending order.
SELECT
	f.title,
    COUNT(DISTINCT(r.rental_date))
 FROM 
	rental as r
JOIN 
	inventory as i
ON 
r.inventory_id = i.inventory_id
JOIN
film as f
ON
i.film_id = f.film_id
GROUP BY f.title
ORDER BY COUNT(DISTINCT(r.rental_date)) DESC;

-- List the top five genres in gross revenue in descending order.
SELECT
	 ROUND(SUM(p.amount),2) as "gross revenue per movie",
     c.name
FROM
     Payment as p
JOIN 
	rental as r
ON 
	p.rental_id = r.rental_id
JOIN 
	inventory as i
 ON
	r.inventory_id = i.inventory_id
JOIN 
	film_category as fca
ON
	i.film_id = fca.film_id
JOIN
	category as c
ON
	fca.category_id = c.category_id
GROUP BY
	 c.name
ORDER BY
	ROUND(SUM(p.amount),2) DESC
    LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
store_id,
title
FROM
     inventory as i
JOIN 
	film as f
ON 
	i.film_id = f.film_id
where title = "Academy Dinosaur" and store_id = 1;

-- Get all pairs of actors that worked together.

-- Get all pairs of customers that have rented the same film more than 3 times.

-- For each film, list actor that has acted in more films.