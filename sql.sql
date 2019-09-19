
-- What's the title and ID of the longest film?

SELECT f.title, f.film_id
FROM film f
WHERE f.length = (
	SELECT MAX(length)
	FROM film
	)

-- What is the title and ID of the film with the lowest replacement cost?

SELECT f.title, f.film_id
FROM film f
WHERE f.replacement_cost = (
	SELECT MIN(replacement_cost)
	FROM film
	)

-- What is the title and ID of the film with the highest rental_rate?

SELECT f.title, f.film_id
FROM film f
WHERE f.rental_rate = (
	SELECT MAX(rental_rate)
	FROM film
	)

-- Show the payment_id's of all transactions after or on May 1st 2007

SELECT p.payment_id
FROM payment p
WHERE p.payment_date >= '2007-05-01'

-- Show all payment ID's and payment date's with a transaction amount less than $3.

SELECT payment_id, payment_date
FROM payment
WHERE amount < '3.00'

-- Get the emails of all customers that shop at store 1 that are inactive (use 'active')

SELECT c.email, c.active, c.store_id
FROM customer c
WHERE c.store_id = '1' AND c.active = '0'

--How much have these customers spent? (Use code from the previous query to
-- make a subquery or a CTE to solve this one.) 
 
WITH store_1_inact_cust AS (
	SELECT *
	FROM customer c
	WHERE c.store_id = '1' AND c.active = '0'
)

SELECT p.customer_id, SUM(p.amount)
FROM payment p
INNER JOIN store_1_inact_cust s ON s.customer_id = p.customer_id
GROUP BY p.customer_id