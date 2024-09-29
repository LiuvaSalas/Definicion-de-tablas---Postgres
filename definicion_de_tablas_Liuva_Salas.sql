-- Creamos la base de datos
CREATE DATABASE peliculas;

-- Nos conectamos a la base de datos
\c peliculas;

-- Creamos las tablas
-- Peliculas
CREATE TABLE peliculas(
id SERIAL PRIMARY KEY,
pelicula VARCHAR (100) NOT NULL,
anio_estreno INTEGER NOT NULL,
director VARCHAR(100) NOT NULL);

-- Reparto
CREATE TABLE reparto(
id_pelicula INTEGER REFERENCES peliculas(id),
actor VARCHAR (100) NOT NULL);

-- Importamos los archivos CSV a las tablas correspondientes
-- Peliculas
COPY peliculas FROM 'peliculas.csv' DELIMITER ',' CSV HEADER;

-- Reparto
COPY reparto FROM 'reparto.csv' DELIMITER ',' CSV HEADER;

-- Consultas
-- 1. Obtener el ID de la película “Titanic”.
SELECT id FROM peliculas
WHERE pelicula like '%Titanic%'; -- id = 2

-- 2. Listar a todos los actores que aparecen en la película "Titanic"
SELECT actor AS "Actores de la pelicula 'El Titanic'" FROM reparto r
LEFT JOIN peliculas p ON r.id_pelicula = p.id
WHERE p.id = 2;

-- 3. Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT(r.id_pelicula) AS "Numero de peliculas en las que participa 'Harrison Ford' del TOP 100" FROM reparto r
LEFT JOIN peliculas p ON r.id_pelicula = p.id
WHERE r.actor = 'Harrison Ford';

-- 4. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.
SELECT pelicula FROM peliculas
WHERE anio_estreno BETWEEN 1990 AND 1999
ORDER BY pelicula ASC;

-- 5. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT pelicula, LENGTH(pelicula) AS "longitud_titulo" FROM peliculas;

-- 6. Consultar cual es la longitud más grande entre todos los títulos de las películas.
SELECT LENGTH(pelicula) AS "longitud_titulo" FROM peliculas
ORDER BY LENGTH(pelicula) DESC
LIMIT 1;