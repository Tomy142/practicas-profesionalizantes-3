/*---Creacion base de datos---*/
CREATE DATABASE IF NOT EXISTS data_country  
    DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

USE data_country; 
/*---Crear Tabla---*/
CREATE TABLE country(  
    id_country INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    capital_city VARCHAR(50) NOT NULL,
    language VARCHAR(50) NOT NULL,
    surface INT NOT NULL,
    population BIGINT NOT NULL
) DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

/*---Precarga de paises---*/
INSERT INTO country(name, capital_city, language, surface, population) VALUES
    ('Argentina','Buenos Aires','Español',278400,46200000),
    ('Brasil','Brasília','Portugués',8515767,203000000),
    ('Canadá','Ottawa','Inglés,Francés',9984670,39000000),
    ('Alemania','Berlín','Alemán',357022,83000000),
    ('Japón','Tokio','Japonés',377975,125000000);

/*---Obtener datos de un país---*/
DELIMITER//

CREATE PROCEDURE country_obtain_by_name(
    IN p_name VARCHAR(50)
)
BEGIN 
    SELECT * FROM country
    WHERE name = p_name;
END //

DELIMITER ;

CALL country_obtain_by_name('Brasil');

/*---Crear un país---*/
DELIMITER//

CREATE PROCEDURE country_insert(
    IN p_name VARCHAR(50),
    IN p_capital_city VARCHAR(50),
    IN p_language VARCHAR(50),
    IN p_surface INT,
    IN p_population BIGINT
)
BEGIN
    INSERT INTO country(name, capital_city, language, surface, population)
    VALUES (p_name, p_capital_city, p_language, p_surface, p_population);
END //

DELIMITER ;

CALL country_insert('Chile', 'Santiago de Chile', 'Español', 756102, 19400000);

/*--Editar un país---*/
DELIMITER //
CREATE PROCEDURE country_update(
    IN p_id_country INT,
    IN p_name VARCHAR(50),
    IN p_capital_city VARCHAR(50),
    IN p_language VARCHAR(50),
    IN p_surface INT,
    IN p_population BIGINT
)
BEGIN 
    UPDATE country
    SET name = p_name, 
    capital_city = p_capital_city, 
    language = p_language, 
    surface = p_surface, 
    population = p_population
    WHERE id_country = p_id_country;
END //

DELIMITER ;

CALL country_update(6,'Egipto','El Cairo','Árabe',1002000,110000000);

/*---Eliminar un país---*/
DELIMITER //

CREATE PROCEDURE country_delete (
    IN p_id_country INT
)
BEGIN   
    DELETE FROM country
    WHERE id_country = p_id_country;
END //

DELIMITER ;

CALL country_delete(3);
/*--------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
*/

/*---Crear Ciudad---*/
CREATE TABLE city( 
    id_city INT AUTO_INCREMENT PRIMARY KEY,
    zip_code VARCHAR(20)  NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    population BIGINT NOT NULL,
    surface INT NOT NULL,
    seaside BOOLEAN NOT NULL
) DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

/*---Precarga de ciudades---*/
INSERT INTO city(zip_code, name, population, surface, seaside) VALUES
    ('C1000AAB', 'Buenos Aires', 3120000, 203, TRUE),
    ('X5000ACJ', 'Córdoba', 1600000, 576, FALSE),
    ('S2000CDA', 'Rosario', 1300000, 178, FALSE),
    ('M5500ALE', 'Mendoza', 1100000, 57, FALSE),
    ('B7600CDE', 'Mar del Plata', 650000, 79, TRUE),

    ('20000-000','Río de Janeiro',6700000, 1260, TRUE),
    ('01000-000', 'São Paulo', 12300000, 1521, FALSE),
    ('40000-000', 'Salvador', 2900000, 310, TRUE),
    ('60000-000', 'Fortaleza', 2700000, 313, TRUE),
    ('80000-000', 'Curitiba', 1900000, 435, FALSE);

/*---Obtener datos de un ciudad---*/
DELIMITER//

CREATE PROCEDURE city_obtain_by_name(
    IN p_name VARCHAR(50)
)
BEGIN 
    SELECT * FROM city
    WHERE name = p_name;
END //

DELIMITER ;

CALL city_obtain_by_name('Buenos Aires');

/*---Crear un ciudad---*/
DELIMITER//

CREATE PROCEDURE city_insert(
    IN p_zip_code VARCHAR(20),
    IN p_name VARCHAR(50),
    IN p_population BIGINT,
    IN p_surface INT,
    IN p_seaside BOOLEAN
)
BEGIN
    INSERT INTO city(zip_code, name, population, surface, seaside)
    VALUES (p_zip_code, p_name, p_population, p_surface, p_seaside);
END //

DELIMITER ;

CALL city_insert('75001', 'Paris', 2141000, 105, FALSE);

/*--Editar un ciudad---*/
DELIMITER //
CREATE PROCEDURE city_update(
    IN p_id_city INT,
    IN p_zip_code VARCHAR(20),
    IN p_name VARCHAR(50),
    IN p_population BIGINT,
    IN p_surface INT,
    IN p_seaside BOOLEAN
)
BEGIN 
    UPDATE city
    SET zip_code = p_zip_code,
    name = p_name,
    population = p_population, 
    surface = p_surface,
    seaside = p_seaside 

    WHERE id_city = p_id_city;
END //

DELIMITER ;

CALL city_update(6,'30110-000', 'Belo Horizonte', 2530000, 311, FALSE);

/*---Eliminar un ciudad---*/
DELIMITER //

CREATE PROCEDURE city_delete (
    IN p_id_city INT
)
BEGIN   
    DELETE FROM city
    WHERE id_city = p_id_city;
END //

DELIMITER ;

CALL city_delete(3);

/*
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
*/

/*----Crear tabla intermedia---*/

CREATE TABLE country_city(
    id_city INT NOT NULL,
    id_country INT NOT NULL,
    PRIMARY KEY (id_country, id_city), -- Clave primaria compuesta
    CONSTRAINT fk_relation_country
        FOREIGN KEY(id_country) REFERENCES country(id_country)
        ON DELETE CASCADE ON UPDATE CASCADE, --Si el pais se elimina, se elimina la relacion
    CONSTRAINT fk_relation_city
        FOREIGN KEY(id_city) REFERENCES city(id_city)
        ON DELETE CASCADE ON UPDATE CASCADE, --Si la ciudad se elimina, se elimina la relacion
)

/*--Precargar relaciones*/

INSERT INTO country_city_relation(id_country, id_city) VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (2,1),
    (2,2),
    (2,3),
    (2,4),
    (2,5);

DELIMITER //

CREATE PROCEDURE add_city_to_country(
    IN p_id_city INT, 
    IN p_id_country INT
)
BEGIN
    INSERT INTO country_city_relation(id_city, id_country)
    VALUES(p_id_city, p_id_country);
END //
DELIMITER ;

/*Ejemplo de asociacion*/
CALL add_city_to_country(11, 1);

DELIMITER //
CREATE PROCEDURE remove_city_from_country(
    IN p_id_city INT,
    IN p_id_country INT
)
BEGIN
    DELETE FROM country_city_relation
    WHERE id_city = p_id_city AND id_country = p_id_country;
END //
DELIMITER ;

CALL remove_city_from_country(11, 1);

/*Procedimiento almacenado pais con la ciudad mas poblada*/
DELIMITER //
CREATE PROCEDURE get_country_of_most_populated_city()
BEGIN
    SELECT
        co.name AS country_name
    FROM
        country co
    JOIN 
        country_city_relation ccr ON co.id_country = ccr.id_country
    JOIN
        city ci ON ccr.id_city = ci.id_city
    ORDER BY
        ci.population DESC
    LIMIT 1;
END //
DELIMITER ;

CALL get_country_of_most_populated_city();
/* Procedimiento almacenado para paises que poseen cuidades costeras con mas de un millon de habitantes*/
DELIMITER //
CREATE PROCEDURE get_countries_with_large_coastal_cities()
BEGIN 
    SELECT DISTINCT
        co.name AS country_name
    FROM
        country co
    JOIN
        country_city_relation ccr ON co.id_country = ccr.id_country
    JOIN
        city ci ON ccr.id_city = ci.id_city
    WHERE
        ci.seaside = TRUE AND ci.population > 1000000;
END //
DELIMITER ;

CALL get_countries_with_large_coastal_cities();

/*Obtener pais y el nombre de la ciudad con la densidad de poblacion más alta*/

DELIMITER //
CREATE PROCEDURE get_city_with_highest_density()
BEGIN
    SELECT
        co.name AS country_name,
        ci.name AS city_name,
        (ci.population / ci.surface) AS population_density
    FROM
        city ci
    JOIN
        country_city_relation ccr ON ci.id_city = ccr.id_city
    JOIN
        country co ON ccr.id_country = co.id_country
    WHERE
        ci.surface > 0
    ORDER BY
        population_density DESC
    LIMIT 1;
END //
DELIMITER ;

CALL get_city_with_highest_density();



