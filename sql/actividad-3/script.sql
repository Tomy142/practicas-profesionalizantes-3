CREATE DATABASE IF NOT EXISTS group_user
    DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

USE group_user;

/*---Crear Tabla User---*/

CREATE TABLE user(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL
);

/*----Crear Tabla Group---*/

CREATE TABLE groups(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL,
    description VARCHAR(128) 
);

/*---Precarga de grupos---*/
INSERT INTO groups( name, description) VALUES
    ('administrator', 'Poseen acceso a toda la WebAPI'),
    ('regular', ' Pueden likear, comentar, subir, consultar videos de usuarios'),
    ('moderator', 'Pueden suspender usuarios por infringir copyright');

/*---Crear Tabla Action---*/
CREATE TABLE action(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL,
    description VARCHAR(128)
);

/*---Precarga de acciones ---*/
INSERT INTO action( name, description) VALUES
    ('uploadVideo', 'Sube un nuevo video'),
    ('getUserVideos', 'Obtiene los videos de un usuario'),
    ('likeVideo', 'Marca un video como "me gusta"'),
    ('commentOnVideo', 'Agrega un comentario a un video'),
    ('deleteVideo', 'Elimina un video (por ID)'),
    ('suspendUser', 'Suspende usuario (por ID)');

/*---Crear Tabla Web-Api ---*/
CREATE TABLE web_api(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_action INT UNSIGNED NOT NULL,
    url VARCHAR(256) UNIQUE NOT NULL,
    http_method VARCHAR(10) NOT NULL,
    CONSTRAINT fk_web_api_action
        FOREIGN KEY (id_action) REFERENCES action(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

/*---Precarga de web_api ---*/
INSERT INTO web_api( id_action, url, http_method) VALUES
    (1,'/api/uploadVideo', 'POST'),
    (2,'/api/getUserVideos', 'POST'),
    (3,'/api/likeVideo', 'POST'),
    (4,'/api/commentOnVideo', 'POST'),
    (5,'/api/deleteVideo', 'POST'),
    (6,'/api/suspendUser', 'POST');


/*--- Crear tabla intermedia user_group---*/

CREATE TABLE user_groups(
    id_user INT UNSIGNED NOT NULL,
    id_group INT UNSIGNED NOT NULL,
    PRIMARY KEY(id_user, id_group),
    CONSTRAINT fk_user_groups_user
        FOREIGN KEY(id_group) REFERENCES groups(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

/*--- Crear tabla intermedia group_permissions--*/

CREATE TABLE group_permissions(
    id_group INT UNSIGNED NOT NULL,
    id_action INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_group, id_action),
    CONSTRAINT fk_group_permissions_group
        FOREIGN KEY (id_group) REFERENCES groups(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
    CONSTRAINT fk_group_permissions_action
        FOREIGN KEY (id_action) REFERENCES action(id)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

/*--- Procedimientos almacenados del ABM Usuario ---*/
/*---Obtener usuario por ID---*/
DELIMITER //
CREATE PROCEDURE user_obtain_by_id(
    IN p_id INT UNSIGNED
)
BEGIN
    SELECT id, name FROM user WHERE id = p_id;
END //
DELIMITER;

/*---Obtener Usuario por nombre---*/

DELIMITER //
CREATE PROCEDURE user_obtain_by_name(
    IN p_name VARCHAR(45)
)
BEGIN   
    SELECT id, name FROM user WHERE name = p_name;
END //
DELIMITER ;

/*---Crear usuario---*/

DELIMITER //
CREATE PROCEDURE user_insert(
    IN p_name VARCHAR(45),
    IN p_password VARCHAR(128)
)
BEGIN
    INSERT INTO user(name, password) VALUES (p_name, p_password);
END //
DELIMITER ;

/*---Editar usuario---*/

DELIMITER //
CREATE PROCEDURE user_update(
    IN p_id INT UNSIGNED,
    IN p_name VARCHAR(45),
    IN p_password VARCHAR(128)
)
BEGIN
    UPDATE user SET name = p_name, password = p_password WHERE id = p_id;
END //
DELIMITER ;

/*--- Eliminar usuario ---*/

DELIMITER //
CREATE PROCEDURE user_delete(
    IN p_id INT UNSIGNED
)
BEGIN
    DELETE FROM user WHERE id = p_id;
END //
DELIMITER ;

/*--- Procedimientos almacenados del ABM de grupo  ---*/
/*--- Obtener Grupo por ID---*/

DELIMITER //
CREATE PROCEDURE group_obtain_by_id(
    IN p_id INT UNSIGNED
)
BEGIN
    SELECT * FROM groups WHERE id = p_id;
END //
DELIMITER ;

/*--- Obtener Grupo por nombre---*/
DELIMITER //
CREATE PROCEDURE group_obtain_by_name(
    IN p_name VARCHAR(45)
)
BEGIN
    SELECT * FROM groups WHERE name = p_name;
END //
DELIMITER ;

/*---Crear grupo---*/

DELIMITER //
CREATE PROCEDURE group_insert(
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    INSERT INTO groups(name, description) VALUES(p_name, p_description);
END //
DELIMITER ;

/*--- Editar grupo ---*/
DELIMITER //
CREATE PROCEDURE group_update(
    IN p_id INT UNSIGNED,
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    UPDATE groups SET name = p_name, description = p_description WHERE id = p_id;
END //
DELIMITER ;

/*--- Eliminar grupo ---*/
DELIMITER //
CREATE PROCEDURE group_delete(
    IN p_id INT UNSIGNED
)
BEGIN
    DELETE FROM groups WHERE id= p_id;
END //
DELIMITER ;

/*--- Procedimientos almacenados del ABM de accion  ---*/

/*---Obtener accion por ID ---*/
DELIMITER //
CREATE PROCEDURE action_obtain_by_id(
    IN p_id INT UNSIGNED
)
BEGIN
    SELECT * FROM action WHERE id = p_id;
END //
DELIMITER ;

/*--- Obtener accion por nombre ---*/

DELIMITER //
CREATE PROCEDURE obtain_action_by_name(
    IN p_name VARCHAR(45)
)
BEGIN
    SELECT * FROM action WHERE name = p_name;
END //
DELIMITER;

/*--- Crear accion ---*/

DELIMITER //
CREATE PROCEDURE action_insert(
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    INSERT INTO action(name, description) VALUES (p_name, p_description);
END //
DELIMITER ;

/*--- Editar accion ---*/
DELIMITER //
CREATE PROCEDURE action_update(
    IN p_id INT UNSIGNED,
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    UPDATE action SET name = p_name, description = p_description WHERE id = p_id;
END //
DELIMITER ;

/*--- Eliminar accion ---*/
DELIMITER //
CREATE PROCEDURE action_delete(
    IN p_id INT UNSIGNED
)
BEGIN
    DELETE FROM action WHERE id = p_id;
END //
DELIMITER ;

/*--- Procedimientos almacenados del ABM de Web-api ---*/
/*---Obtener Web-api por ID ---*/
DELIMITER //
CREATE PROCEDURE web_api_obtain_by_id(
    IN p_id INT UNSIGNED
)
BEGIN
    SELECT wa.*, a.name AS action_name
    FROM web_api wa
    JOIN action a ON wa.id_action = a.id
    WHERE wa.id = p_id;
END //
DELIMITER ;

/*--- Obtener Web-api por URL ---*/
DELIMITER //
CREATE PROCEDURE web_api_obtain_by_url(
    IN p_url VARCHAR(256)
)
BEGIN
    SELECT wa.*, a.name AS action_name
    FROM web_api wa
    JOIN action a ON wa.id_action = a.id
    WHERE wa.url = p_url;
END //
DELIMITER ;

/*--- Crear web-api ---*/
DELIMITER //
CREATE PROCEDURE web_api_insert(
    IN p_id_action INT UNSIGNED,
    IN p_url VARCHAR(256),
    IN p_http_method VARCHAR(10)
)
BEGIN
    INSERT INTO web_api(id_action, url, http_method) VALUES (p_id_action, p_url, p_http_method);
END //
DELIMITER;

/*--- Editar web-api ---*/
DELIMITER //
CREATE PROCEDURE web_api_update(
    IN p_id INT UNSIGNED,
    IN p_id_action INT UNSIGNED,
    IN p_url VARCHAR(256),
    IN p_http_method VARCHAR(10)
)
BEGIN
    UPDATE web_api SET id_action = p_id_action, url = p_url, http_method = p_http_method WHERE id = p_id;
END //
DELIMITER ;

/*--- Eliminar web-api ---*/
DELIMITER //
CREATE PROCEDURE web_api_delete(
    IN p_id INT UNSIGNED
)
BEGIN
    DELETE FROM web_api WHERE id = p_id;
END //
DELIMITER ;

/*--- Procedimientos almacenados del ABM de user_groups ---*/

/*--- Añadir usuario a un grupo ---*/
DELIMITER //
CREATE PROCEDURE user_groups_add(
    IN p_id_user INT UNSIGNED,
    IN p_id_group INT UNSIGNED
)
BEGIN
    INSERT INTO user_groups(id_user, id_group) VALUES (p_id_user, p_id_group);
END //
DELIMITER ;

/*--- Remover usuario de un grupo ---*/
DELIMITER //
CREATE PROCEDURE user_groups_remove(
    IN p_id_user INT UNSIGNED,
    IN p_id_group INT UNSIGNED
)
BEGIN
    DELETE FROM user_groups WHERE id_user = p_id_user AND id_group = p_id_group;
END //
DELIMITER ;

/*--- Obtener grupos de un usuario ---*/
DELIMITER //
CREATE PROCEDURE user_get_groups(
    IN p_id_user INT UNSIGNED
)
BEGIN
    SELECT g.id, g.name, g.description
    FROM groups g
    JOIN user_groups ug ON u.id = ug.id_group
    WHERE ug.id_user = p_id_user;
END //
DELIMITER ;

/*--- Obtener usuarios de un grupo ---*/
DELIMITER //
CREATE PROCEDURE group_get_users(
    IN p_id_group INT UNSIGNED
)
BEGIN
    SELECT u.id, u.name
    FROM user u
    JOIN user_groups ug ON u.id = ug.id_user
    WHERE ug.id_group = p_id_group;
END //
DELIMITER ;

/*--- Procedimientos almacenados del ABM de group_permissions ---*/
/*--- Añadir permiso a un grupo ---*/
DELIMITER //
CREATE PROCEDURE group_permissions_add(
    IN p_id_group INT UNSIGNED,
    IN p_id_action INT UNSIGNED
)
BEGIN
    INSERT INTO group_permissions(id_group, id_action) VALUES (p_id_group, p_id_action);
END //
DELIMITER ;

/*--- Remover permiso de un grupo ---*/
DELIMITER //
CREATE PROCEDURE group_permissions_remove(
    IN p_id_group INT UNSIGNED,
    IN p_id_action INT UNSIGNED
)
BEGIN
    DELETE FROM group_permissions WHERE id_group = p_id_group AND id_action = p_id_action;
END //
DELIMITER ;

/*--- Obtener los permisos de un grupo ---*/
DELIMITER //
CREATE PROCEDURE group_get_permissions(
    IN p_id_group INT UNSIGNED
)
BEGIN
    SELECT a.id, a.name, a.description
    FROM action a
    JOIN group_permissions gp ON a.id = gp.id_action
    WHERE gp.id_group = p_id_group;
END //
DELIMITER ;

/*--- Obtener grupos que tienen un permiso especifico ---*/
DELIMITER //
CREATE PROCEDURE action_get_groups(
    IN p_id_action INT UNSIGNED
)
BEGIN
    SELECT g.id, g.name, g.description
    FROM groups g
    JOIN group_permissions gp ON g.id = gp.id_group
    WHERE gp.id_action = p_id_action;
END // 
DELIMITER ;

/*--- Verificar permisos de un usuario ---*/
DELIMITER //
CREATE PROCEDURE user_check_permission(
    IN p_user_id INT UNSIGNED,
    IN p_action_name VARCHAR(45)
)
BEGIN
    SELECT
        COUNT(DISTINCT a.id) > 0 AS has_permission
    FROM
        user u
    JOIN
        user_groups ug ON u.id = ug.id_user
    JOIN
        groups g ON ug.id_group = g.id
    JOIN
        group_permissions gp ON g.id = gp.id_group
    JOIN
        action a ON gp.id_action = a.id
    WHERE
        u.id = p_user_id AND a.name = p_action_name;
END //
DELIMITER ;