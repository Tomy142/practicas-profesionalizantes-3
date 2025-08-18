CREATE DATABASE IF NOT EXISTS file_system
    DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

use file_system;

/*--Crear Carpeta--*/
CREATE TABLE folder(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

/*--Crear Archivo--*/
CREATE TABLE file(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type_of_file VARCHAR(50) NOT NULL,
    date_of_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    content TEXT
) DEFAULT CHARACTER SET utf8 
    COLLATE utf8_bin;

/*--Crear tabla intermedia carpeta-carpetas--*/
CREATE TABLE folder_folders(
    id_parent_folder INT NOT NULL,
    id_child_folder INT NOT NULL,
    PRIMARY KEY (id_parent_folder, id_child_folder),
    FOREIGN KEY(id_parent_folder) REFERENCES folder(id_folder),
    FOREIGN KEY(id_child_folder) REFERENCES folder(id_folder),
    CHECK(id_parent_folder <> id_child_folder)
) DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

/*--Crear tabla intermedia carpeta-archivos--*/
CREATE TABLE folder_files(
    id_folder INT NOT NULL,
    id_file INT NOT NULL,
    PRIMARY KEY (id_folder, id_file),
    FOREIGN KEY (id_folder) REFERENCES folder(id_folder),
    FOREIGN KEY (id_file) REFERENCES file(id_file)
) DEFAULT CHARACTER SET utf8
    COLLATE utf8_bin;

/*--Procedimientos Almacenados para Carpetas --*/

DELIMITER //
CREATE PROCEDURE folder_obtain_by_id(
    IN p_id_folder INT
)
BEGIN
    SELECT * FROM folder
    WHERE id_folder = p_id_folder;
END //
DELIMITER ;
/*-- Crear Carpeta--*/
DELIMITER //
CREATE PROCEDURE folder_insert(
    IN p_name VARCHAR(255),
    IN p_id_parent_folder INT
)
BEGIN 
    DECLARE v_id INT;

    INSERT INTO folder(name) VALUES(p_name);
    SET v_id = LAST_INSERT_ID();

    IF p_id_parent_folder IS NOT NULL THEN
        INSERT INTO folder_folders(id_parent_folder, id_child_folder)
        VALUES(p_id_parent_folder, v_id);
    END IF;

    SELECT v_id AS new_folder_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE folder_delete(
    IN p_id_folder INT
)
BEGIN 
    DELETE FROM folder_files WHERE id_folder = p_id_folder;
    DELETE FROM folder_folders WHERE id_parent_folder = p_id_folder;
    DELETE FROM folder WHERE id_folder = p_id_folder;
END //
DELIMITER ;

/*--Procedimientos Almacenados para Archivos--*/
/*-- Crear archivo--*/

DELIMITER //
CREATE PROCEDURE file_insert(
    IN p_name VARCHAR(255),
    IN p_type_of_file VARCHAR(50),
    IN p_id_folder INT,
    IN p_content TEXT
)
BEGIN
    DECLARE v_id INT;

    INSERT INTO file(name, type_of_file, content)
    VALUES (p_name, p_type_of_file, p_content);

    SET v_id = LAST_INSERT_ID();

    INSERT INTO folder_files(id_folder, id_file)
    VALUES(p_id_folder, v_id);

    SELECT v_id AS new_file_id;
END //
DELIMITER ;

/*-- Obtener archivo por ID--*/
DELIMITER //
CREATE PROCEDURE file_obtain_by_id(
    IN p_id_file INT
)
BEGIN
    SELECT * FROM file
    WHERE id_file = p_id_file;
END //
DELIMITER ;

/*--Eliminar archivo--*/
DELIMITER //
CREATE PROCEDURE file_delete(
    IN p_id_file INT
)
BEGIN
    DELETE FROM folder_files WHERE id_file = p_id_file;
    DELETE FROM file WHERE id_file = p_id_file;
END //
DELIMITER ;

/*-- Procedimiento almacenado para buscar archivos--*/

DELIMITER //
CREATE PROCEDURE file_search(
    IN p_type_of_file VARCHAR(50),
    IN p_start_date DATETIME,
    IN p_end_date DATETIME
)
BEGIN
    SELECT f.*
    FROM file f
    WHERE (p_type_of_file IS NULL OR f.type_of_file = p_type_of_file)
        AND(p_start_date IS NULL OR f.date_of_creation >= p_start_date)
        AND(p_end_date IS NULL OR f.date_of_creation <= p_end_date);
END //
DELIMITER ;