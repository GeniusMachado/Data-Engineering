
SQL JOIN QUESTIONS 

1. List all customers along with the films they have rented.

SELECT c.customer_id, c.first_name, c.last_name, f.title as Film_Rented FROM customer c LEFT JOIN rental r ON c.customer_id = r.customer_id LEFT JOIN inventory i ON r.inventory_id = i.inventory_id LEFT JOIN film f ON i.film_id = f.film_id;







2. List all customers and show their rental count, including those who haven't rented any films.

SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;







3. Show all films along with their category. Include films that don't have a category assigned.

select f.title, c.category_id as category_id, rc.name as category_type   from film f left join film_category c on f.film_id = c.film_id left join category
rc on rc.category_id = c.category_id;
 





4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

SELECT c.email AS customer_email, s.email AS staff_email
FROM customer c
LEFT JOIN staff s ON c.email = s.email
UNION
SELECT c.email, s.email
FROM customer c
RIGHT JOIN staff s ON c.email = s.email;





5. Find all actors who acted in the film "ACADEMY DINOSAUR".

SELECT a.first_name, a.last_name 
FROM actor a 
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id 
INNER JOIN film f ON f.film_id = fa.film_id 
WHERE f.title = 'ACADEMY DINOSAUR';






6. List all stores and the total number of staff members working in each store, even if a store has no staff.

select str.store_id as Store, count(stf.staff_id) as total_working_staff from sakila.store str left join sakila.staff stf on str.store_id = stf.store_id group by str.store_id;
+-------+---------------------+
| Store | total_working_staff |
+-------+---------------------+
|     1 |                   1 |
|     2 |                   1 |
+-------+---------------------+






7. List the customers who have rented films more than 5 times. Include their name and total rental count.

select c.first_name, c.last_name, count(r.customer_id) as rental_count from customer c inner join sakila.rental r on c.customer_id = r.customer_id group by c.customer_id having count(r.customer_id)>5;







