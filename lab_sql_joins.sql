-- Challenge - Joining on multiple tables
-- Write SQL queries to perform the following tasks using the Sakila database:

-- List the number of films per category.
USE sakila;

SELECT c.name as category_name, count(f.film_id) AS number_of_films FROM category c
JOIN film_category f 
ON c.category_id = f.category_id
GROUP BY c.name; 

-- Retrieve the store ID, city, and country for each store.

SELECT s.store_id, c.city, ca.country FROM store s
JOIN address a 
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country ca
ON c.country_id = ca.country_id;

-- Calculate the total revenue generated by each store in dollars.

select s.store_id, q.city, q.country, sum(p.amount) as total_revenue from store s
LEFT JOIN staff st 
ON s.store_id = st.store_id
LEFT JOIN payment p
ON st.staff_id = p.staff_id
LEFT JOIN 
(
SELECT s.store_id, c.city, ca.country FROM store s
JOIN address a 
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country ca
ON c.country_id = ca.country_id) as q
ON s.store_id=q.store_id
GROUP BY s.store_id;

-- Determine the average running time of films for each category.

select c.name, round(avg(f.length),0) avg_duration from category c 
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_duration DESC; 


/*Bonus:

Identify the film categories with the longest average running time.
Display the top 10 most frequently rented movies in descending order.
Determine if "Academy Dinosaur" can be rented from Store 1.
Provide a list of all distinct film titles, along with their availability status in the inventory. 
Include a column indicating whether each title is 'Available' or 'NOT available.' 
Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."*/
