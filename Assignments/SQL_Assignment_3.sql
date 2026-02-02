



1. display all customer details who have made more than 5 payments.

select * from customer where customer_id in ( select customer_id from payment group by customer_id having count(payment_id)>5);





2. Find the names of actors who have acted in more than 10 films.

select * from actor where actor_id in (select actor_id from film_actor group by actor_id having count(film_id)>10);





3. Find the names of customers who never made a payment.

select customer_id, first_name, last_name from customer where customer_id not in (select customer_id from payment);

PS: There are no customers with no payments. Everyone has atleast one payment in Sakila database. I got the output as empty set. 






4. List all films whose rental rate is higher than the average rental rate of all films.

SELECT film_id, title, rental_rate FROM film WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);






5. List the titles of films that were never rented.

SELECT title 
FROM film 
WHERE film_id NOT IN (
    SELECT film_id 
    FROM inventory 
    WHERE inventory_id IN (SELECT inventory_id FROM rental)
);






6. Display the customers who rented films in the same month as customer with ID 5.

SELECT DISTINCT first_name, last_name 
FROM customer 
WHERE customer_id IN (
    SELECT customer_id 
    FROM rental 
    WHERE MONTH(rental_date) IN (
        SELECT DISTINCT MONTH(rental_date) 
        FROM rental 
        WHERE customer_id = 5
    )
);





7. Find all staff members who handled a payment greater than the average payment amount.

SELECT first_name, last_name 
FROM staff 
WHERE staff_id IN (
    SELECT staff_id 
    FROM payment 
    WHERE amount > (SELECT AVG(amount) FROM payment)
);





8. Show the title and rental duration of films whose rental duration is greater than the average.

SELECT title, rental_duration
FROM film
WHERE rental_duration > (
    SELECT AVG(rental_duration) 
    FROM film
);





9. Find all customers who have the same address as customer with ID 1.

SELECT first_name, last_name 
FROM customer 
WHERE address_id = (
    SELECT address_id 
    FROM customer 
    WHERE customer_id = 1
);





10. List all payments that are greater than the average of all payments.

SELECT * 
FROM payment 
WHERE amount > (
    SELECT AVG(amount) 
    FROM payment
);







