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

/*---Crear Tabla Action---*/

CREATE TABLE action(
    id_group INT UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(45) UNIQUE NOT NULL,
    description VARCHAR(128),
)

/*---Crear Tabla Web-Api ---*/

CREATE TABLE action(
    id_group INT UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
    url VARCHAR(256) UNIQUE NOT NULL,
    http_method VARCHAR(45)
)
