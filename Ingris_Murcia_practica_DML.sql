-- Tarea. Ingris Nohemy Murcia Ayala 20172000487

use sakila;

-- 1. Ciudades del country ‘Alemania’. Use SUBSELECT
SELECT city
FROM city
WHERE country_id = (
    SELECT country_id FROM country WHERE country = 'Germany'
);

-- 2. Empleados que generaron más ingresos que el promedio
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) AS total_ingresos
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id
HAVING total_ingresos > (
    SELECT AVG(total) FROM (
        SELECT SUM(p.amount) AS total
        FROM staff s
        JOIN payment p ON s.staff_id = p.staff_id
        GROUP BY s.staff_id
    ) AS sub
);

-- 3. Nombre y apellido de actores cuyo apellido es "Neeson"
SELECT first_name, last_name
FROM actor
WHERE last_name = 'Neeson';

-- 4. Direcciones de California que tengan ‘274’ en el número de teléfono
SELECT address, phone
FROM address
WHERE district = 'California' AND phone LIKE '%274%';

-- 5. Promedio total de rental_rate de películas con rating PG-13 y G
SELECT AVG(rental_rate) AS promedio_rental_rate
FROM film
WHERE rating IN ('PG-13', 'G');

-- 6. Actores y el número de películas en las que han actuado
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 7. ¿Cuántas ciudades tiene el país ‘Italy’? Utilice join
SELECT COUNT(c.city_id) AS total_ciudades
FROM city c
JOIN country co ON c.country_id = co.country_id
WHERE co.country = 'Italy';

-- 8. Nombre y cantidad de pagos de clientes con más de 5 pagos
SELECT c.first_name, c.last_name, COUNT(p.payment_id) AS cantidad_pagos
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COUNT(p.payment_id) > 5;

-- 9. Actores con nombre que inicia con ‘F’ y apellido que termina con ‘R’
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'F%' AND last_name LIKE '%R';

-- 10. Total de películas de cada actor
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 11. Película con menor rental_duration
SELECT title, rental_duration
FROM film
ORDER BY rental_duration ASC
LIMIT 1;

-- 12. Actores con primer nombre ‘RUSSEL’. Use LIKE
SELECT *
FROM actor
WHERE first_name LIKE 'RUSSEL';

-- 13. Nombre de la película y sus categorías
SELECT f.title, c.name AS categoria
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

-- 14. Actores con apellido ‘Chase’. Use LIKE
SELECT *
FROM actor
WHERE last_name LIKE 'Chase';

-- 15. Películas con duración entre 80 y 100 minutos. Use BETWEEN
SELECT title, length
FROM film
WHERE length BETWEEN 80 AND 100;

-- 16. Categorías y número total de películas en cada una
SELECT c.name AS categoria, COUNT(fc.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id;

-- 17. Lista de actores con cantidad de películas en las que participaron
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 18. Actores cuyo apellido es "Depp" o "Pitt"
SELECT first_name, last_name
FROM actor
WHERE last_name IN ('Depp', 'Pitt');

-- 19. Películas con título de más de 40 caracteres
SELECT title
FROM film
WHERE LENGTH(title) > 40;

-- 20. Películas con rating distinto de R o G (nombre, categoría, duración)
SELECT f.title, c.name AS categoria, f.length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE rating NOT IN ('R', 'G');

-- 21. Nombre y apellido juntos de actores cuyo apellido no es "Neeson"
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM actor
WHERE last_name <> 'Neeson';

-- 22. ¿Cuántas ciudades tiene el país ‘Brazil’? Utilice join
SELECT COUNT(c.city_id) AS total_ciudades
FROM city c
JOIN country co ON c.country_id = co.country_id
WHERE co.country = 'Brazil';

-- 23. Clientes y número de veces que han alquilado películas
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 24. Actores y el número de películas en las que han actuado
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 25. Actores cuyo nombre termine con "n"
SELECT *
FROM actor
WHERE first_name LIKE '%n';

-- 26. Clientes cuyo apellido comienza con "S"
SELECT first_name, last_name
FROM customer
WHERE last_name LIKE 'S%';

-- 27. Borrar películas con id 35, 77, 148 y 253 de film_actor
DELETE FROM film_actor
WHERE film_id = 35 OR film_id = 77 OR film_id = 148 OR film_id = 253;

-- 28. Borrar la película "ALABAMA DEVIL" de film_category
DELETE FROM film_category
WHERE film_id = (
    SELECT film_id FROM film WHERE title = 'ALABAMA DEVIL'
);

-- 29. Actualizar stock de una película específica
UPDATE inventory
SET store_id = 1
WHERE film_id = 10; -- Cambia el id de la película según corresponda

-- 30. Actualizar dirección de todos los clientes en una ciudad específica
UPDATE address a
JOIN city c ON a.city_id = c.city_id
SET a.address = 'Nueva Dirección'
WHERE c.city = 'London';
