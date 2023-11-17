
/* 1. Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo
pedido. */


CREATE DATABASE desafio_jean_barraez_179;
\c desafio_jean_barraez_179;

CREATE TABLE usuarios (
    usuario_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    rol VARCHAR(255) NOT NULL
);

INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES
    ('usuario1@example.com','Juan','Pérez','administrador'),
    ('usuario2@example.com','María','García','usuario'),
    ('usuario3@example.com','Pedro','López','usuario'),
    ('usuario4@example.com','Ana', 'Martínez','usuario'),
    ('usuario5@example.com','Carlos','Sánchez','usuario');


CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL,
    fecha_actualizacion TIMESTAMP NOT NULL,
    destacado BOOLEAN NOT NULL,
    usuario_id BIGINT);

INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES
    ('Título del post 1', 'Contenido del post 1', '2021-02-01', '2021-02-01', true, 1),
    ('Título del post 2', 'Contenido del post 2', '2021-03-01', '2021-03-01', true, 1),
    ('Título del post 3', 'Contenido del post 3', '2021-05-02', '2021-04-04', false, 2),
    ('Título del post 4', 'Contenido del post 4', '2021-05-03', '2021-04-04', false, 3),
    ('Título del post 5', 'Contenido del post 5', '2021-06-03', '2021-05-04', false, NULL);


CREATE TABLE comentarios (
    comentario_id SERIAL PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL,
    usuario_id BIGINT,
    post_id BIGINT);

INSERT INTO Comentarios (contenido, fecha_creacion, usuario_id, post_id)
VALUES
    ('Contenido del comentario 1', '2021-06-03', 1, 1),
    ('Contenido del comentario 2', '2021-06-03', 2, 1),
    ('Contenido del comentario 3', '2021-06-04', 3, 1),
    ('Contenido del comentario 4', '2021-06-04', 1, 2),
    ('Contenido del comentario 5', '2021-06-04', 2, 2);


SELECT * FROM usuarios;
 usuario_id |        email         | nombre | apellido |      rol
------------+----------------------+--------+----------+---------------
          1 | usuario1@example.com | Juan   | Pérez    | administrador
          2 | usuario2@example.com | María  | García   | usuario
          3 | usuario3@example.com | Pedro  | López    | usuario
          4 | usuario4@example.com | Ana    | Martínez | usuario
          5 | usuario5@example.com | Carlos | Sánchez  | usuario
(5 filas)

SELECT * FROM comentarios;
 comentario_id |         contenido          |   fecha_creacion    | usuario_id | post_id
---------------+----------------------------+---------------------+------------+---------
             1 | Contenido del comentario 1 | 2021-06-03 00:00:00 |          1 |       1
             2 | Contenido del comentario 2 | 2021-06-03 00:00:00 |          2 |       1
             3 | Contenido del comentario 3 | 2021-06-04 00:00:00 |          3 |       1
             4 | Contenido del comentario 4 | 2021-06-04 00:00:00 |          1 |       2
             5 | Contenido del comentario 5 | 2021-06-04 00:00:00 |          2 |       2
(5 filas)
Requerimientos

SELECT * FROM posts;
 post_id |      titulo       |      contenido       |   fecha_creacion    | fecha_actualizacion | destacado | usuario_id
---------+-------------------+----------------------+---------------------+---------------------+-----------+------------
       1 | Título del post 1 | Contenido del post 1 | 2021-02-01 00:00:00 | 2021-02-01 00:00:00 | t         |          1
       2 | Título del post 2 | Contenido del post 2 | 2021-03-01 00:00:00 | 2021-03-01 00:00:00 | t         |          1
       3 | Título del post 3 | Contenido del post 3 | 2021-05-02 00:00:00 | 2021-04-04 00:00:00 | f         |          2
       4 | Título del post 4 | Contenido del post 4 | 2021-05-03 00:00:00 | 2021-04-04 00:00:00 | f         |          3
       5 | Título del post 5 | Contenido del post 5 | 2021-06-03 00:00:00 | 2021-05-04 00:00:00 | f         |
(5 filas)



--2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
--nombre y email del usuario junto al título y contenido del post?
SELECT u.nombre, u.email, p.titulo, p.contenido FROM Usuarios AS u INNER JOIN posts AS p ON u.usuario_id = p.usuario_id;

 nombre |        email         |      titulo       |      contenido
--------+----------------------+-------------------+----------------------
 Juan   | usuario1@example.com | Título del post 1 | Contenido del post 1
 Juan   | usuario1@example.com | Título del post 2 | Contenido del post 2
 María  | usuario2@example.com | Título del post 3 | Contenido del post 3
 Pedro  | usuario3@example.com | Título del post 4 | Contenido del post 4
(4 filas)

3. Muestra el id, título y contenido de los posts de los administradores.a. El administrador puede ser cualquier id.
 /* SELECT p.post_id, p.titulo, p.contenido FROM Posts AS p INNER JOIN usuarios AS u ON u.rol = 'administrador'; */
SELECT p.post_id, p.titulo, p.contenido, u.nombre FROM Posts AS p INNER JOIN usuarios AS u  ON  u.usuario_id = p.usuario_id WHERE u.rol = 'admistrador';
post_id |      titulo       |      contenido       | nombre
---------+-------------------+----------------------+--------
       1 | Título del post 1 | Contenido del post 1 | Juan
       2 | Título del post 2 | Contenido del post 2 | Juan

/* 4. Cuenta la cantidad de posts de cada usuario.
a. La tabla resultante debe mostrar el id e email del usuario junto con la
cantidad de posts de cada usuario. */
SELECT u.usuario_id, u.email, COUNT(*) AS num_posts FROM Posts p INNER JOIN usuarios AS u ON u.usuario_id = p.usuario_id GROUP BY u.usuario_id;

Hint: Aquí hay diferencia entre utilizar inner join, left join o right join, prueba con
todas y con eso determina cuál es la correcta. No da lo mismo la tabla desde la que
se parte.

 usuario_id |        email         | num_posts
------------+----------------------+-----------
          3 | usuario3@example.com |         1
          1 | usuario1@example.com |         2
          2 | usuario2@example.com |         1

/* 5. Muestra el email del usuario que ha creado más posts.
a. Aquí la tabla resultante tiene un único registro y muestra solo el email.
 */
 
SELECT u.email FROM usuarios u INNER JOIN Posts p ON u.usuario_id = p.usuario_id GROUP BY  u.email ORDER BY COUNT(p.usuario_id) DESC LIMIT 1;
 email
----------------------
 usuario1@example.com
(1 fila)

--6. Muestra la fecha del último post de cada usuario.
SELECT u.nombre,  MAX(p.fecha_creacion) AS ultimo_post_usuario FROM Posts p INNER JOIN usuarios AS u ON u.usuario_id = p.usuario_id GROUP BY u.nombre;
nombre | ultimo_post_usuario
--------+---------------------
 Juan   | 2021-03-01 00:00:00
 Pedro  | 2021-05-03 00:00:00
 María  | 2021-05-02 00:00:00
(3 filas)
--Hint: Utiliza la función de agregado MAX sobre la fecha de creación.

--7. Muestra el título y contenido del post (artículo) con más comentarios.

SELECT p.titulo, p.contenido
FROM Posts p JOIN (SELECT post_id, COUNT(*) AS total_comentarios FROM Comentarios GROUP BY post_id ORDER BY COUNT(*) DESC LIMIT 1) c ON p.post_id = c.post_id;

      titulo       |      contenido
-------------------+----------------------
 Título del post 1 | Contenido del post 1
(1 fila)



/* 8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
de cada comentario asociado a los posts mostrados, junto con el email del usuario
que lo escribió. */

SELECT p.titulo, p.contenido AS contenido_post, c.contenido AS contenido_comentario, u.email FROM posts AS p INNER JOIN comentarios AS c ON p.post_id = c.post_id INNER JOIN usuarios AS u  ON u.usuario_id = c.usuario_id; 
 titulo       |    contenido_post    |    contenido_comentario    |        email
-------------------+----------------------+----------------------------+----------------------
 Título del post 1 | Contenido del post 1 | Contenido del comentario 1 | usuario1@example.com
 Título del post 1 | Contenido del post 1 | Contenido del comentario 2 | usuario2@example.com
 Título del post 1 | Contenido del post 1 | Contenido del comentario 3 | usuario3@example.com
 Título del post 2 | Contenido del post 2 | Contenido del comentario 4 | usuario1@example.com
 Título del post 2 | Contenido del post 2 | Contenido del comentario 5 | usuario2@example.com
(5 filas)




--9. Muestra el contenido del último comentario de cada usuario.

SELECT cm.* FROM comentarios AS cm INNER JOIN 
(SELECT c.usuario_id, MAX(c.fecha_creacion) AS fecha_mas_reciente FROM comentarios AS c GROUP BY  c.usuario_id)
 AS fr ON fr.usuario_id = cm.usuario_id and fr.fecha_mas_reciente = cm.fecha_creacion order by cm.usuario_id

 comentario_id |         contenido          |   fecha_creacion    | usuario_id | post_id
---------------+----------------------------+---------------------+------------+---------
             4 | Contenido del comentario 4 | 2021-06-04 00:00:00 |          1 |       2
             5 | Contenido del comentario 5 | 2021-06-04 00:00:00 |          2 |       2
             3 | Contenido del comentario 3 | 2021-06-04 00:00:00 |          3 |       1
(3 filas)


--10. Muestra los emails de los usuarios que no han escrito ningún comentario.
--Hint: Recuerda el uso de Having.
SELECT u.email as usuarios_sin_comentarios FROM usuarios AS u WHERE u.usuario_id NOT IN (SELECT DISTINCT usuario_id FROM Comentarios);

 usuarios_sin_comentarios
--------------------------
 usuario4@example.com
 usuario5@example.com
(2 filas)

SELECT u.email FROM usuarios AS u LEFT JOIN comentarios AS c ON u.usuario_id = c.usuario_id GROUP BY u.usuario_id, u.email HAVING COUNT(c.comentario_id) = 0;

email
----------------------
 usuario4@example.com
 usuario5@example.com