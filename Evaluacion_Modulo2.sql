/*EVALUACIÓN MODULO 2*/

USE sakila;

-- Ejercicio 1: Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title
FROM film;


-- Ejercicio 2: Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT 
title,
rating
FROM film
WHERE rating = 'PG-13';


-- Ejercicio 3: Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT
title,
description
FROM film
WHERE description REGEXP 'amazing';


-- Ejercicio 4: Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT 
title,
length
FROM film
WHERE length > 120
ORDER BY length;


-- Ejercicio 5: Recupera los nombres de todos los actores.
SELECT
first_name,
last_name
FROM actor
ORDER BY first_name;


-- Ejercicio 6:  Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido
SELECT
first_name,
last_name
FROM actor
WHERE last_name = 'Gibson';


-- Ejercicio 7:  Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20
SELECT
first_name,
last_name,
actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


-- Ejercicio 8:  Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación
SELECT
title,
rating
FROM film
WHERE rating NOT IN ('R', 'PG-13')
ORDER BY rating;


-- Ejercicio 9:  Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT
rating AS Clasificacion,
COUNT(DISTINCT(film_id)) AS RecuentoPeliculas
FROM film
GROUP BY rating;


-- Ejercicio 10: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

-- Uno la tabla cliente con tabla rental, de esta segunda obtengo los datos de alquiler agrupados por cliente_id(customer_id) 
SELECT
customer.customer_id AS ClienteID,
customer.first_name AS NombreCliente,
customer.last_name AS ApellidoCliente,
COUNT(DISTINCT(rental_id)) AS PeliculasAlquiladas
FROM customer
LEFT JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT(rental_id));	


-- Ejercicio 11: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- Combino varias tablas (rental, inventory, film_category y category) para extraer los datos necesarios de rental, film_category y category, y poder combinarlos
SELECT
film_category.category_id AS CategoriaPelicula,
category.name AS NombreCategoria,
COUNT(DISTINCT(rental_id)) AS PeliculasAlquiladasPorCategoria
FROM rental
LEFT JOIN inventory
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN film_category
ON film_category.film_id = inventory.film_id
LEFT JOIN category
ON category.category_id = film_category.category_id
GROUP BY film_category.category_id
HAVING COUNT(DISTINCT(rental_id));


-- Ejercicio 12: Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT
rating AS ClasificacionPelicula,
AVG(length) AS PromedioDuracion
FROM film
GROUP BY rating;


-- Ejercicio 13: Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"
SELECT
actor.first_name AS Nombre,
actor.last_name AS apellido, 
film.title AS Titulo
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
LEFT JOIN film
ON film.film_id = film_actor.film_id
WHERE title IN ("Indian Love");

-- Otra manera de hacerlo sería utilizando una subconsulta:
SELECT
actor.first_name AS Nombre,
actor.last_name AS Apellido, 
film.title AS Titulo
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
LEFT JOIN film
ON film.film_id = film_actor.film_id
WHERE film.title IN (
	SELECT title
    FROM film
    WHERE title = "Indian Love");


-- Ejercicio 14: Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción
SELECT
film.title AS Titulo,
film.description AS Descripcion
FROM film
WHERE description REGEXP 'dog' OR 'cat';


-- Ejercicio 15: Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010
SELECT
film.title AS Titulo,
film.release_year AS AñoLanzamiento
FROM film
WHERE film.release_year BETWEEN 2005 AND 2010
ORDER BY film.release_year; 


-- Ejercicio 16: Encuentra el título de todas las películas que son de la misma categoría que "Family"

-- Enlazo tabla_film con tabla_categoria a través de tabla film_categoría (que tiene datos en común) y luego selecciono solo las de categoría "Family"
SELECT 
film.title AS Titulo, 
category.name AS Categoria
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Family';


-- Ejercicio 17: Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
SELECT
film.title AS Titulo,
film.rating AS Categoria,
film.length AS Duracion 
FROM film
WHERE rating = 'R' and length > 120
ORDER BY length;
