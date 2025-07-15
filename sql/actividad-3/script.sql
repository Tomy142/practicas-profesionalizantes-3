CREATE DATABASE IF NOT EXISTS group_user
    DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

USE group_user;

/*---Crear Tabla User---*/

CREATE TABLE user(
    id_user INT UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(45) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL
)

/*----Crear Tabla Group---*/

CREATE TABLE group(
    id_group INT UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(45) UNIQUE NOT NULL,
    description VARCHAR(128) 
)

/*---Precarga de grupos---*/
INSERT INTO group( name, description) VALUES
    ('administrator', 'Poseen acceso a toda la WebAPI'),
    ('regular', ' Pueden likear, comentar, subir, consultar videos de usuarios'),
    ('moderator', 'Pueden suspender usuarios por infringir copyright');

/*---Crear Tabla Action---*/
CREATE TABLE action(
    id_group INT UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(45) UNIQUE NOT NULL,
    description VARCHAR(128),
)

/*---Precarga de grupos---*/
INSERT INTO action( name, description) VALUES
    ('uploadVideo', 'Sube un nuevo video'),
    ('getUserVideos', 'Obtiene los videos de un usuario'),
    ('likeVideo', 'Marca un video como "me gusta"'),
    ('commentOnVideo', 'Agrega un comentario a un video'),
    ('deleteVideo', 'Elimina un video (por ID)'),
    ('suspendUser', 'Suspende usuario (por ID)');

/*---Crear Tabla Web-Api ---*/
CREATE TABLE webapi(
    id_group INT UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
    url VARCHAR(256) UNIQUE NOT NULL,
    http_method VARCHAR(45)
)
