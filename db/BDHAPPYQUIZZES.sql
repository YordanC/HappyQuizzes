-- Generado por Oracle SQL Developer Data Modeler 21.2.0.165.1515
--   en:        2024-04-13 20:23:43 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE estudiante (
    id_documento INTEGER NOT NULL,
    nombre       VARCHAR2(13 CHAR),
    apellido     VARCHAR2(13 CHAR),
    estado       VARCHAR2(13 CHAR)
);

Alter table estudiante add estado varchar(13);

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( id_documento );

CREATE TABLE examen (
    id_examen              INTEGER NOT NULL,
    descripcion            VARCHAR2(200 CHAR),
    porcentaje_examen      FLOAT(3),
    categoria              VARCHAR2(13 CHAR),
    nota_examen            FLOAT(3),
    cantidad_preguntas     INTEGER,
    tiempo                 DATE,
    tiempo_finalizacion    DATE,
    porcentaje_correctas   FLOAT(3),
    porcentaje_incorrectas FLOAT,
    horario_id_horario     INTEGER NOT NULL
);

CREATE UNIQUE INDEX examen__idx ON
    examen (
        horario_id_horario
    ASC );

ALTER TABLE examen ADD CONSTRAINT examen_pk PRIMARY KEY ( id_examen );

CREATE TABLE examen_estudiante (
    exam_id_exam            INTEGER NOT NULL,
    estudiante_id_documento INTEGER NOT NULL,
    puntaje_examen          FLOAT(2)
);

ALTER TABLE examen_estudiante ADD CONSTRAINT examen_estudiante_pk PRIMARY KEY ( exam_id_exam,
                                                                                estudiante_id_documento );

CREATE TABLE examen_grupo (
    grupo_id_grupo   INTEGER NOT NULL,
    examen_id_examen INTEGER NOT NULL
);

ALTER TABLE examen_grupo ADD CONSTRAINT examen_grupo_pk PRIMARY KEY ( grupo_id_grupo,
                                                                      examen_id_examen );

CREATE TABLE examen_pregunta (
    examen_id_examen     INTEGER NOT NULL,
    pregunta_id_pregunta INTEGER NOT NULL
);

ALTER TABLE examen_pregunta ADD CONSTRAINT examen_pregunta_pk PRIMARY KEY ( examen_id_examen,
                                                                            pregunta_id_pregunta );

CREATE TABLE examen_profesor (
    examen_id_examen      INTEGER NOT NULL,
    profesor_id_documento INTEGER NOT NULL
);

ALTER TABLE examen_profesor ADD CONSTRAINT examen_profesor_pk PRIMARY KEY ( examen_id_examen,
                                                                            profesor_id_documento );

CREATE TABLE grupo (
    id_grupo     INTEGER NOT NULL,
    nombre_grupo VARCHAR2(13 CHAR),
    estado       VARCHAR2(13 CHAR)
);
ALTER TABLE grupo
ADD estado VARCHAR(14);


ALTER TABLE grupo
DROP COLUMN estado;


ALTER TABLE grupo ADD CONSTRAINT grupo_pk PRIMARY KEY ( id_grupo );

CREATE TABLE grupo_estudiante (
    grupo_id_grupo          INTEGER NOT NULL,
    estudiante_id_documento INTEGER NOT NULL
);

ALTER TABLE grupo_estudiante ADD CONSTRAINT grupo_estudiante_pk PRIMARY KEY ( grupo_id_grupo,
                                                                              estudiante_id_documento );

CREATE TABLE horario (
    id_horario  INTEGER NOT NULL,
    dia         VARCHAR2(13),
    hora_inicio DATE,
    hora_fin    DATE
);

ALTER TABLE horario ADD CONSTRAINT horario_pk PRIMARY KEY ( id_horario );

CREATE TABLE lugar (
    descripcion VARCHAR2(35),
    id_lugar    INTEGER NOT NULL
);

ALTER TABLE lugar ADD CONSTRAINT lugar_pk PRIMARY KEY ( id_lugar );

CREATE TABLE lugar_horario (
    lugar_id_lugar     INTEGER NOT NULL,
    horario_id_horario INTEGER NOT NULL
);

ALTER TABLE lugar_horario ADD CONSTRAINT lugar_horario_pk PRIMARY KEY ( lugar_id_lugar,
                                                                        horario_id_horario );

CREATE TABLE opcion (
    id_opcion            VARCHAR2(20 CHAR) NOT NULL,
    descripcion          VARCHAR2(240 CHAR),
    correcto             CHAR(1),
    pregunta_id_pregunta INTEGER NOT NULL
);

ALTER TABLE opcion ADD CONSTRAINT opcion_pk PRIMARY KEY ( id_opcion );

CREATE TABLE pregunta (
    id_pregunta          INTEGER NOT NULL,
    tipo_pregunta        VARCHAR2(13 CHAR),
    descripcion_pregunta VARCHAR2(250 CHAR) NOT NULL,
    porcentaje_pregunta  FLOAT(3),
    tiempo_pregunta      DATE
);

ALTER TABLE pregunta ADD CONSTRAINT pregunta_pk PRIMARY KEY ( id_pregunta );

CREATE TABLE profesor (
    id_documento INTEGER NOT NULL,
    nombre       VARCHAR2(13 CHAR) NOT NULL,
    apellido     VARCHAR2(13 CHAR) NOT NULL
);

ALTER TABLE profesor ADD CONSTRAINT profesor_pk PRIMARY KEY ( id_documento );

CREATE TABLE respuesta (
    id_respuesta                   INTEGER NOT NULL,
    correcta                       CHAR(1) NOT NULL,
    descripcion_respuesta          VARCHAR2(250 CHAR) NOT NULL,
    exam_estudi_exam_id_exam       INTEGER NOT NULL,
    exam_estudi_estudi_id_document INTEGER NOT NULL
);

ALTER TABLE respuesta ADD CONSTRAINT respuestas_pk PRIMARY KEY ( id_respuesta );

ALTER TABLE examen_estudiante
    ADD CONSTRAINT exam_estudi_estudia_fk FOREIGN KEY ( estudiante_id_documento )
        REFERENCES estudiante ( id_documento );

ALTER TABLE examen_estudiante
    ADD CONSTRAINT exam_estudi_exam_fk FOREIGN KEY ( exam_id_exam )
        REFERENCES examen ( id_examen );

ALTER TABLE examen_grupo
    ADD CONSTRAINT examen_grupo_examen_fk FOREIGN KEY ( examen_id_examen )
        REFERENCES examen ( id_examen );

ALTER TABLE examen_grupo
    ADD CONSTRAINT examen_grupo_grupo_fk FOREIGN KEY ( grupo_id_grupo )
        REFERENCES grupo ( id_grupo );

ALTER TABLE examen
    ADD CONSTRAINT examen_horario_fk FOREIGN KEY ( horario_id_horario )
        REFERENCES horario ( id_horario );

ALTER TABLE examen_pregunta
    ADD CONSTRAINT examen_pregunta_examen_fk FOREIGN KEY ( examen_id_examen )
        REFERENCES examen ( id_examen );

ALTER TABLE examen_pregunta
    ADD CONSTRAINT examen_pregunta_pregunta_fk FOREIGN KEY ( pregunta_id_pregunta )
        REFERENCES pregunta ( id_pregunta );

ALTER TABLE examen_profesor
    ADD CONSTRAINT examen_profesor_examen_fk FOREIGN KEY ( examen_id_examen )
        REFERENCES examen ( id_examen );

ALTER TABLE examen_profesor
    ADD CONSTRAINT examen_profesor_profesor_fk FOREIGN KEY ( profesor_id_documento )
        REFERENCES profesor ( id_documento );

ALTER TABLE grupo_estudiante
    ADD CONSTRAINT grupo_estudiante_estudiante_fk FOREIGN KEY ( estudiante_id_documento )
        REFERENCES estudiante ( id_documento );

ALTER TABLE grupo_estudiante
    ADD CONSTRAINT grupo_estudiante_grupo_fk FOREIGN KEY ( grupo_id_grupo )
        REFERENCES grupo ( id_grupo );

ALTER TABLE lugar_horario
    ADD CONSTRAINT lugar_horario_horario_fk FOREIGN KEY ( horario_id_horario )
        REFERENCES horario ( id_horario );

ALTER TABLE lugar_horario
    ADD CONSTRAINT lugar_horario_lugar_fk FOREIGN KEY ( lugar_id_lugar )
        REFERENCES lugar ( id_lugar );

ALTER TABLE opcion
    ADD CONSTRAINT opcion_pregunta_fk FOREIGN KEY ( pregunta_id_pregunta )
        REFERENCES pregunta ( id_pregunta );

ALTER TABLE respuesta
    ADD CONSTRAINT respuesta_examen_estudiante_fk FOREIGN KEY ( exam_estudi_exam_id_exam,
                                                                exam_estudi_estudi_id_document )
        REFERENCES examen_estudiante ( exam_id_exam,
                                       estudiante_id_documento );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             1
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0


-- TABLESPACE---------------------------------------------------------------

CREATE TABLESPACE TS_ESTUDIANTE
DATAFILE 'C:\TABLASPACE\TS_ESTUDIANTE.dbf'
SIZE 50M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED;

CREATE TABLESPACE TS_DOCENTE
DATAFILE 'C:\TABLASPACE\TS_DOCENTE.dbf' SIZE 50M ;

CREATE TABLESPACE TS_EXAMEN
DATAFILE 'C:\TABLASPACE\TS_EXAMEN.dbf' SIZE 200M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;

CREATE TABLESPACE TS_LUGAR
DATAFILE 'C:\TABLASPACE\TS_LUGAR.dbf' SIZE 20M;

CREATE TABLESPACE TS_HORARIO
DATAFILE 'C:\TABLASPACE\TS_HORARIO.dbf' SIZE 50M;

CREATE TABLESPACE TS_RESPUESTA
DATAFILE 'C:\TABLASPACE\TS_RESPUESTA.dbf' SIZE 300M;

CREATE TABLESPACE TS_GRUPO
DATAFILE 'C:\TABLASPACE\TS_GRUPO.dbf' SIZE 50M;

CREATE TABLESPACE TS_PREGUNTA
DATAFILE 'C:\TABLASPACE\TS_PREGUNTA.dbf' SIZE 150M;

CREATE TABLESPACE TS_OPCION
DATAFILE 'C:\TABLASPACE\TS_OPCION.dbf' SIZE 100M;

CREATE TABLESPACE TS_LUGAR_HORARIO
DATAFILE 'C:\TABLASPACE\TS_LUGAR_HORARIO.dbf' SIZE 30M;

CREATE TABLESPACE TS_EXAMEN_PREGUNTA
DATAFILE 'C:\TABLASPACE\TS_EXAMEN_PREGUNTA.dbf' SIZE 250M;

CREATE TABLESPACE TS_EXAMEN_GRUPO
DATAFILE 'C:\TABLASPACE\TS_EXAMEN_GRUPO.dbf' SIZE 150M;

CREATE TABLESPACE TS_EXAMEN_ESTUDIANTE
DATAFILE 'C:\TABLASPACE\TS_EXAMEN_ESTUDIANTE.dbf' SIZE 400M;

CREATE TABLESPACE TS_EXAMEN_PROFESOR
DATAFILE 'C:\TABLASPACE\TS_EXAMEN_PROFESOR.dbf' SIZE 100M;

CREATE TABLESPACE TS_GRUPO_ESTUDIANTE
DATAFILE 'C:\TABLASPACE\TS_GRUPO_ESTUDIANTE.dbf' SIZE 200M;

-----asignacion de tablas a tablespaces 
ALTER TABLE ESTUDIANTE MOVE TABLESPACE TS_ESTUDIANTE;
ALTER TABLE PROFESOR MOVE TABLESPACE TS_DOCENTE;
ALTER TABLE EXAMEN MOVE TABLESPACE TS_EXAMEN;
ALTER TABLE LUGAR MOVE TABLESPACE TS_LUGAR;
ALTER TABLE HORARIO MOVE TABLESPACE TS_HORARIO;
ALTER TABLE RESPUESTA MOVE TABLESPACE TS_RESPUESTA;
ALTER TABLE GRUPO MOVE TABLESPACE TS_GRUPO;
ALTER TABLE PREGUNTA MOVE TABLESPACE TS_PREGUNTA;
ALTER TABLE OPCION MOVE TABLESPACE TS_OPCION;
ALTER TABLE LUGAR_HORARIO MOVE TABLESPACE TS_LUGAR_HORARIO;
ALTER TABLE EXAMEN_PREGUNTA MOVE TABLESPACE TS_EXAMEN_PREGUNTA;
ALTER TABLE EXAMEN_GRUPO MOVE TABLESPACE TS_EXAMEN_GRUPO;
ALTER TABLE EXAMEN_ESTUDIANTE MOVE TABLESPACE TS_EXAMEN_ESTUDIANTE;
ALTER TABLE EXAMEN_PROFESOR MOVE TABLESPACE TS_EXAMEN_PROFESOR;
ALTER TABLE GRUPO_ESTUDIANTE MOVE TABLESPACE TS_GRUPO_ESTUDIANTE;

--POBLAR TABLAS

--TABLA ESTUDIANTE ***
INSERT INTO ESTUDIANTE 
VALUES (1, 'Juan', 'Perez', 'Activo');

-- Registro 2
INSERT INTO ESTUDIANTE VALUES (2, 'María', 'López', 'Activo');

-- Registro 3
INSERT INTO ESTUDIANTE VALUES (3, 'Pedro', 'Martínez', 'Inactivo');

-- Registro 4
INSERT INTO ESTUDIANTE VALUES (4, 'Ana', 'Rodríguez', 'Activo');

-- Registro 5
INSERT INTO ESTUDIANTE VALUES (5, 'Carlos', 'Gómez', 'Inactivo');

-- Registro 6
INSERT INTO ESTUDIANTE VALUES (6, 'Laura', 'Fernández', 'Activo');

-- Registro 7
INSERT INTO ESTUDIANTE VALUES (7, 'Pablo', 'Díaz', 'Inactivo');

-- Registro 8
INSERT INTO ESTUDIANTE VALUES (8, 'Sofía', 'González', 'Activo');

-- Registro 9
INSERT INTO ESTUDIANTE VALUES (9, 'Miguel', 'Pérez', 'Activo');

-- Registro 10
INSERT INTO ESTUDIANTE VALUES (10, 'Lucía', 'Ruiz', 'Inactivo');

-- Registro 11
INSERT INTO ESTUDIANTE VALUES (11, 'Diego', 'Hernández', 'Activo');

-- Registro 12
INSERT INTO ESTUDIANTE VALUES (12, 'Elena', 'Sánchez', 'Inactivo');

-- Registro 13
INSERT INTO ESTUDIANTE VALUES (13, 'Javier', 'Gutiérrez', 'Activo');

-- Registro 14
INSERT INTO ESTUDIANTE VALUES (14, 'Isabel', 'Torres', 'Inactivo');

-- Registro 15
INSERT INTO ESTUDIANTE VALUES (15, 'Alejandro', 'Jiménez', 'Activo');

-- Registro 16
INSERT INTO ESTUDIANTE VALUES (16, 'Paula', 'Navarro', 'Activo');

-- Registro 17
INSERT INTO ESTUDIANTE VALUES (17, 'Andrés', 'Rivera', 'Inactivo');

-- Registro 18
INSERT INTO ESTUDIANTE VALUES (18, 'Carmen', 'Romero', 'Activo');

-- Registro 19
INSERT INTO ESTUDIANTE VALUES (19, 'Roberto', 'Vargas', 'Inactivo');

-- Registro 20
INSERT INTO ESTUDIANTE VALUES (20, 'Natalia', 'Molina', 'Activo');

-- Registro 21
INSERT INTO ESTUDIANTE VALUES (21, 'Jorge', 'Ortega', 'Inactivo');

-- Registro 22
INSERT INTO ESTUDIANTE VALUES (22, 'Valeria', 'Castro', 'Activo');

-- Registro 23
INSERT INTO ESTUDIANTE VALUES (23, 'Francisco', 'Suárez', 'Inactivo');

-- Registro 24
INSERT INTO ESTUDIANTE VALUES (24, 'Marina', 'Lara', 'Activo');

-- Registro 25
INSERT INTO ESTUDIANTE VALUES (25, 'Daniel', 'Dominguez', 'Inactivo');

-- Registro 26
INSERT INTO ESTUDIANTE VALUES (26, 'María', 'González', 'Activo');

-- Registro 27
INSERT INTO ESTUDIANTE VALUES (27, 'Carlos', 'López', 'Activo');

-- Registro 28
INSERT INTO ESTUDIANTE VALUES (28, 'Laura', 'Martínez', 'Inactivo');

-- Registro 29
INSERT INTO ESTUDIANTE VALUES (29, 'Alejandro', 'Hernández', 'Activo');

-- Registro 30
INSERT INTO ESTUDIANTE VALUES (30, 'Sofía', 'Pérez', 'Inactivo');

-- Registro 31
INSERT INTO ESTUDIANTE VALUES (31, 'David', 'García', 'Activo');

-- Registro 32
INSERT INTO ESTUDIANTE VALUES (32, 'Paula', 'Sánchez', 'Inactivo');

-- Registro 33
INSERT INTO ESTUDIANTE VALUES (33, 'Javier', 'Rodríguez', 'Activo');

-- Registro 34
INSERT INTO ESTUDIANTE VALUES (34, 'Carmen', 'Fernández', 'Inactivo');

-- Registro 35
INSERT INTO ESTUDIANTE VALUES (35, 'Manuel', 'Gómez', 'Activo');

-- Registro 36
INSERT INTO ESTUDIANTE VALUES (36, 'Ana', 'Díaz', 'Inactivo');

-- Registro 37
INSERT INTO ESTUDIANTE VALUES (37, 'Pedro', 'Muñoz', 'Activo');

-- Registro 38
INSERT INTO ESTUDIANTE VALUES (38, 'Elena', 'Vázquez', 'Inactivo');

-- Registro 39
INSERT INTO ESTUDIANTE VALUES (39, 'Juan', 'Jiménez', 'Activo');

-- Registro 40
INSERT INTO ESTUDIANTE VALUES (40, 'Isabel', 'Torres', 'Inactivo');


--TABLA EXAMEN *******
-- Registro 1
INSERT INTO EXAMEN 
VALUES 
(1, 'Examen de Matemáticas', 80.0, 'Matemáticas', 4.0, 50, TO_DATE('2024-04-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-17 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 1);

-- Registro 2
INSERT INTO EXAMEN 
VALUES 
(2, 'Examen de Historia', 75.0, 'Historia', 3.5, 40, TO_DATE('2024-04-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-17 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 70.0, 30.0, 2);

-- Registro 3
INSERT INTO EXAMEN 
VALUES 
(3, 'Examen de Ciencias', 85.0, 'Ciencias', 4.5, 60, TO_DATE('2024-04-18 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-18 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 3);

-- Registro 4
INSERT INTO EXAMEN 
VALUES 
(4, 'Examen de Literatura', 90.0, 'Literatura', 5.0, 70, TO_DATE('2024-04-18 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 4);

-- Registro 5
INSERT INTO EXAMEN 
VALUES 
(5, 'Examen de Biología', 70.0, 'Biología', 3.0, 45, TO_DATE('2024-04-19 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-19 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 75.0, 25.0, 5);

-- Registro 6
INSERT INTO EXAMEN 
VALUES 
(6, 'Examen de Química', 78.0, 'Química', 3.7, 55, TO_DATE('2024-04-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-19 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 6);

-- Registro 7
INSERT INTO EXAMEN 
VALUES 
(7, 'Examen de Física', 82.0, 'Física', 4.2, 50, TO_DATE('2024-04-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-20 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 7);

-- Registro 8
INSERT INTO EXAMEN 
VALUES 
(8, 'Examen de Geografía', 73.0, 'Geografía', 3.3, 35, TO_DATE('2024-04-20 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-20 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 70.0, 30.0, 8);

-- Registro 9
INSERT INTO EXAMEN 
VALUES 
(9, 'Examen de Lengua', 87.0, 'Lengua', 4.7, 65, TO_DATE('2024-04-21 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-21 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 9);

-- Registro 10
INSERT INTO EXAMEN 
VALUES 
(10, 'Examen de Informática', 79.0, 'Informática', 3.9, 55, TO_DATE('2024-04-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-21 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 10);

-- Registro 11
INSERT INTO EXAMEN 
VALUES 
(11, 'Examen de Música', 72.0, 'Música', 3.2, 40, TO_DATE('2024-04-22 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-22 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 75.0, 25.0, 11);

-- Registro 12
INSERT INTO EXAMEN 
VALUES 
(12, 'Examen de Arte', 85.0, 'Arte', 4.5, 60, TO_DATE('2024-04-22 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-22 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 12);

-- Registro 13 (corregido)
INSERT INTO EXAMEN 
VALUES 
(13, 'Examen de Educación Física', 78.0, 'Educación', 3.7, 55, TO_DATE('2024-04-23 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-23 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 13);


-- Registro 14
INSERT INTO EXAMEN 
VALUES 
(14, 'Examen de Tecnología', 82.0, 'Tecnología', 4.2, 50, TO_DATE('2024-04-23 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-23 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 14);

-- Registro 15
INSERT INTO EXAMEN 
VALUES 
(15, 'Examen de Filosofía', 73.0, 'Filosofía', 3.3, 35, TO_DATE('2024-04-24 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-24 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 70.0, 30.0, 15);

-- Registro 16
INSERT INTO EXAMEN 
VALUES 
(16, 'Examen de Religión', 87.0, 'Religión', 4.7, 65, TO_DATE('2024-04-24 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-24 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 16);

-- Registro 17
INSERT INTO EXAMEN 
VALUES 
(17, 'Examen de Inglés', 79.0, 'Inglés', 3.9, 55, TO_DATE('2024-04-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-25 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 17);

-- Registro 18
INSERT INTO EXAMEN 
VALUES 
(18, 'Examen de Francés', 72.0, 'Francés', 3.2, 40, TO_DATE('2024-04-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-25 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 75.0, 25.0, 18);

-- Registro 19 (corregido)
INSERT INTO EXAMEN 
VALUES (19, 'Examen de Educación', 85.0, 'Educación', 4.5, 60, TO_DATE('2024-04-26 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-26 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 19);


-- Registro 20
INSERT INTO EXAMEN 
VALUES 
(20, 'Examen de Biología', 78.0, 'Biología', 3.7, 55, TO_DATE('2024-04-26 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-26 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 20);

-- Registro 21 (corregido)
INSERT INTO EXAMEN 
VALUES 
(21, 'Examen de Economía', 82.0, 'Economía', 4.2, 50, TO_DATE('2024-04-27 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-27 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 21);


-- Registro 22
INSERT INTO EXAMEN 
VALUES 
(22, 'Examen de Historia', 73.0, 'Historia', 3.3, 35, TO_DATE('2024-04-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-27 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 70.0, 30.0, 22);

-- Registro 23
INSERT INTO EXAMEN 
VALUES 
(23, 'Examen de Química', 87.0, 'Química', 4.7, 65, TO_DATE('2024-04-28 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-28 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 23);

-- Registro 24
INSERT INTO EXAMEN 
VALUES 
(24, 'Examen de Geografía', 79.0, 'Geografía', 3.9, 55, TO_DATE('2024-04-28 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-28 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 24);

-- Registro 25
INSERT INTO EXAMEN 
VALUES 
(25, 'Examen de Literatura', 72.0, 'Literatura', 3.2, 40, TO_DATE('2024-04-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-29 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 75.0, 25.0, 25);

-- Registro 26
INSERT INTO EXAMEN VALUES (26, 'Examen de Biología', 84.0, 'Biología', 4.4, 60, TO_DATE('2024-04-29 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-29 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 26);

-- Registro 27
INSERT INTO EXAMEN VALUES (27, 'Examen de Arte', 75.0, 'Arte', 3.5, 45, TO_DATE('2024-04-30 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-30 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 27);

-- Registro 28
INSERT INTO EXAMEN VALUES (28, 'Examen de Informática', 88.0, 'Informática', 4.6, 65, TO_DATE('2024-04-30 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-30 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 28);

-- Registro 29
INSERT INTO EXAMEN VALUES (29, 'Examen de Música', 81.0, 'Música', 4.1, 55, TO_DATE('2024-05-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 29);

-- Registro 30
INSERT INTO EXAMEN 
VALUES 
(30, 'Examen de Educación Física', 77.0, 'Educación', 3.7, 50, TO_DATE('2024-05-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 30);

-- Registro 31
INSERT INTO EXAMEN VALUES (31, 'Examen de Astronomía', 86.0, 'Astronomía', 4.5, 70, TO_DATE('2024-05-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-02 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 31);

-- Registro 32
INSERT INTO EXAMEN VALUES (32, 'Examen de Filosofía', 80.0, 'Filosofía', 4.0, 60, TO_DATE('2024-05-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-02 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 32);

-- Registro 33
INSERT INTO EXAMEN VALUES (33, 'Examen de Idiomas', 75.0, 'Idiomas', 3.5, 45, TO_DATE('2024-05-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-03 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 33);

-- Registro 34
INSERT INTO EXAMEN VALUES (34, 'Examen de Literatura', 79.0, 'Literatura', 3.9, 55, TO_DATE('2024-05-03 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-03 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 34);

-- Registro 35
INSERT INTO EXAMEN VALUES (35, 'Examen de Ciencias', 82.0, 'Ciencias', 4.2, 50, TO_DATE('2024-05-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-04 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 35);

-- Registro 36
INSERT INTO EXAMEN VALUES (36, 'Examen de Matemáticas', 85.0, 'Matemáticas', 4.5, 60, TO_DATE('2024-05-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-04 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 95.0, 5.0, 36);

-- Registro 37
INSERT INTO EXAMEN VALUES (37, 'Examen de Tecnología', 78.0, 'Tecnología', 3.8, 55, TO_DATE('2024-05-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-05 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 37);

-- Registro 38
INSERT INTO EXAMEN VALUES (38, 'Examen de Economía', 80.0, 'Economía', 4.0, 60, TO_DATE('2024-05-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-05 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90.0, 10.0, 38);

-- Registro 39
INSERT INTO EXAMEN VALUES (39, 'Examen de Biología', 83.0, 'Biología', 4.3, 65, TO_DATE('2024-05-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-06 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85.0, 15.0, 39);

-- Registro 40
INSERT INTO EXAMEN VALUES (40, 'Examen de Historia', 77.0, 'Historia', 3.7, 55, TO_DATE('2024-05-06 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-06 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80.0, 20.0, 40);


--TABLA HORARIO ****
-- Insertar datos en la tabla HORARIO
INSERT INTO HORARIO 
VALUES (1, 'Lunes', TO_DATE('2024-04-17 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (2, 'Martes', TO_DATE('2024-04-18 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-18 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (3, 'Miércoles', TO_DATE('2024-04-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (4, 'Jueves', TO_DATE('2024-04-20 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-20 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (5, 'Viernes', TO_DATE('2024-04-21 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-21 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insertar más datos en la tabla HORARIO
INSERT INTO HORARIO
VALUES (6, 'Sábado', TO_DATE('2024-04-22 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-22 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (7, 'Domingo', TO_DATE('2024-04-23 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-23 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (8, 'Lunes', TO_DATE('2024-04-24 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-24 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (9, 'Martes', TO_DATE('2024-04-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-25 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (10, 'Miércoles', TO_DATE('2024-04-26 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-26 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insertar más datos en la tabla HORARIO
INSERT INTO HORARIO
VALUES (11, 'Jueves', TO_DATE('2024-04-27 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-27 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (12, 'Viernes', TO_DATE('2024-04-28 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-28 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (13, 'Sábado', TO_DATE('2024-04-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-29 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (14, 'Domingo', TO_DATE('2024-04-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-04-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (15, 'Lunes', TO_DATE('2024-05-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insertar más datos en la tabla HORARIO
INSERT INTO HORARIO
VALUES (16, 'Martes', TO_DATE('2024-05-02 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-02 17:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (17, 'Miércoles', TO_DATE('2024-05-03 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-03 18:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (18, 'Jueves', TO_DATE('2024-05-04 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-04 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (19, 'Viernes', TO_DATE('2024-05-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (20, 'Sábado', TO_DATE('2024-05-06 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-06 17:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insertar más datos en la tabla HORARIO
INSERT INTO HORARIO
VALUES (21, 'Domingo', TO_DATE('2024-05-07 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-07 18:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (22, 'Lunes', TO_DATE('2024-05-08 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-08 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (23, 'Martes', TO_DATE('2024-05-09 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-09 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (24, 'Miércoles', TO_DATE('2024-05-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-10 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO HORARIO
VALUES (25, 'Jueves', TO_DATE('2024-05-11 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 26
INSERT INTO HORARIO VALUES (26, 'Viernes', TO_DATE('2024-05-12 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-12 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 27
INSERT INTO HORARIO VALUES (27, 'Sábado', TO_DATE('2024-05-13 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 28
INSERT INTO HORARIO VALUES (28, 'Domingo', TO_DATE('2024-05-14 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-14 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 29
INSERT INTO HORARIO VALUES (29, 'Lunes', TO_DATE('2024-05-15 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-15 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 30
INSERT INTO HORARIO VALUES (30, 'Martes', TO_DATE('2024-05-16 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-16 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 31
INSERT INTO HORARIO VALUES (31, 'Miércoles', TO_DATE('2024-05-17 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 32
INSERT INTO HORARIO VALUES (32, 'Jueves', TO_DATE('2024-05-18 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-18 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 33
INSERT INTO HORARIO VALUES (33, 'Viernes', TO_DATE('2024-05-19 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-19 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 34
INSERT INTO HORARIO VALUES (34, 'Sábado', TO_DATE('2024-05-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-20 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 35
INSERT INTO HORARIO VALUES (35, 'Domingo', TO_DATE('2024-05-21 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-21 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 36
INSERT INTO HORARIO VALUES (36, 'Lunes', TO_DATE('2024-05-22 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 37
INSERT INTO HORARIO VALUES (37, 'Martes', TO_DATE('2024-05-23 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-23 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 38
INSERT INTO HORARIO VALUES (38, 'Miércoles', TO_DATE('2024-05-24 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 39
INSERT INTO HORARIO VALUES (39, 'Jueves', TO_DATE('2024-05-25 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Registro 40
INSERT INTO HORARIO VALUES (40, 'Viernes', TO_DATE('2024-05-26 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-05-26 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));



--TABLA EXAMEN_ESTUDIANTE ****
-- Registro 1
INSERT INTO EXAMEN_ESTUDIANTE VALUES (1, 1, 3.75);

-- Registro 2
INSERT INTO EXAMEN_ESTUDIANTE VALUES (2, 2, 4.0);

-- Registro 3
INSERT INTO EXAMEN_ESTUDIANTE VALUES (3, 3, 4.4);

-- Registro 4
INSERT INTO EXAMEN_ESTUDIANTE VALUES (4, 4, 4.525);

-- Registro 5
INSERT INTO EXAMEN_ESTUDIANTE VALUES (5, 5, 3.5);

-- Registro 6
INSERT INTO EXAMEN_ESTUDIANTE VALUES (6, 6, 4.125);

-- Registro 7
INSERT INTO EXAMEN_ESTUDIANTE VALUES (7, 7, 4.25);

-- Registro 8
INSERT INTO EXAMEN_ESTUDIANTE VALUES (8, 8, 3.9);

-- Registro 9
INSERT INTO EXAMEN_ESTUDIANTE VALUES (9, 9, 4.55);

-- Registro 10
INSERT INTO EXAMEN_ESTUDIANTE VALUES (10, 10, 4.375);

-- Registro 11
INSERT INTO EXAMEN_ESTUDIANTE VALUES (11, 11, 4.15);

-- Registro 12
INSERT INTO EXAMEN_ESTUDIANTE VALUES (12, 12, 3.975);

-- Registro 13
INSERT INTO EXAMEN_ESTUDIANTE VALUES (13, 13, 4.45);

-- Registro 14
INSERT INTO EXAMEN_ESTUDIANTE VALUES (14, 14, 4.325);

-- Registro 15
INSERT INTO EXAMEN_ESTUDIANTE VALUES (15, 15, 4.05);

-- Registro 16
INSERT INTO EXAMEN_ESTUDIANTE VALUES (16, 16, 4.225);

-- Registro 17
INSERT INTO EXAMEN_ESTUDIANTE VALUES (17, 17, 3.875);

-- Registro 18
INSERT INTO EXAMEN_ESTUDIANTE VALUES (18, 18, 4.65);

-- Registro 19
INSERT INTO EXAMEN_ESTUDIANTE VALUES (19, 19, 4.425);

-- Registro 20
INSERT INTO EXAMEN_ESTUDIANTE VALUES (20, 20, 3.75);

-- Registro 21
INSERT INTO EXAMEN_ESTUDIANTE VALUES (21, 21, 4.175);

-- Registro 22
INSERT INTO EXAMEN_ESTUDIANTE VALUES (22, 22, 4.275);

-- Registro 23
INSERT INTO EXAMEN_ESTUDIANTE VALUES (23, 23, 4.025);

-- Registro 24
INSERT INTO EXAMEN_ESTUDIANTE VALUES (24, 24, 3.975);

-- Registro 25
INSERT INTO EXAMEN_ESTUDIANTE VALUES (25, 25, 4.35);

-- Registro 26
INSERT INTO EXAMEN_ESTUDIANTE VALUES (26, 26, 4.5);

-- Registro 27
INSERT INTO EXAMEN_ESTUDIANTE VALUES (27, 27, 4.125);

-- Registro 28
INSERT INTO EXAMEN_ESTUDIANTE VALUES (28, 28, 3.925);

-- Registro 29
INSERT INTO EXAMEN_ESTUDIANTE VALUES (29, 29, 4.25);

-- Registro 30
INSERT INTO EXAMEN_ESTUDIANTE VALUES (30, 30, 4.65);

-- Registro 31
INSERT INTO EXAMEN_ESTUDIANTE VALUES (31, 31, 4.075);

-- Registro 32
INSERT INTO EXAMEN_ESTUDIANTE VALUES (32, 32, 4.4);

-- Registro 33
INSERT INTO EXAMEN_ESTUDIANTE VALUES (33, 33, 3.8);

-- Registro 34
INSERT INTO EXAMEN_ESTUDIANTE VALUES (34, 34, 4.2);

-- Registro 35
INSERT INTO EXAMEN_ESTUDIANTE VALUES (35, 35, 4.3);

-- Registro 36
INSERT INTO EXAMEN_ESTUDIANTE VALUES (36, 36, 3.975);

-- Registro 37
INSERT INTO EXAMEN_ESTUDIANTE VALUES (37, 37, 4.525);

-- Registro 38
INSERT INTO EXAMEN_ESTUDIANTE VALUES (38, 38, 3.775);

-- Registro 39
INSERT INTO EXAMEN_ESTUDIANTE VALUES (39, 39, 4.0);

-- Registro 40
INSERT INTO EXAMEN_ESTUDIANTE VALUES (40, 40, 4.4);

---tabla examen_grupo

-- Registro 1
INSERT INTO EXAMEN_GRUPO VALUES (1, 1);

-- Registro 2
INSERT INTO EXAMEN_GRUPO VALUES (2, 2);

-- Registro 3
INSERT INTO EXAMEN_GRUPO VALUES (3, 3);

-- Registro 4
INSERT INTO EXAMEN_GRUPO VALUES (4, 4);

-- Registro 5
INSERT INTO EXAMEN_GRUPO VALUES (5, 5);

-- Registro 6
INSERT INTO EXAMEN_GRUPO VALUES (6, 6);

-- Registro 7
INSERT INTO EXAMEN_GRUPO VALUES (7, 7);

-- Registro 8
INSERT INTO EXAMEN_GRUPO VALUES (8, 8);

-- Registro 9
INSERT INTO EXAMEN_GRUPO VALUES (9, 9);

-- Registro 10
INSERT INTO EXAMEN_GRUPO VALUES (10, 10);

-- Registro 11
INSERT INTO EXAMEN_GRUPO VALUES (11, 11);

-- Registro 12
INSERT INTO EXAMEN_GRUPO VALUES (12, 12);

-- Registro 13
INSERT INTO EXAMEN_GRUPO VALUES (13, 13);

-- Registro 14
INSERT INTO EXAMEN_GRUPO VALUES (14, 14);

-- Registro 15
INSERT INTO EXAMEN_GRUPO VALUES (15, 15);

-- Registro 16
INSERT INTO EXAMEN_GRUPO VALUES (16, 16);

-- Registro 17
INSERT INTO EXAMEN_GRUPO VALUES (17, 17);

-- Registro 18
INSERT INTO EXAMEN_GRUPO VALUES (18, 18);

-- Registro 19
INSERT INTO EXAMEN_GRUPO VALUES (19, 19);

-- Registro 20
INSERT INTO EXAMEN_GRUPO VALUES (20, 20);

-- Registro 21
INSERT INTO EXAMEN_GRUPO VALUES (21, 21);

-- Registro 22
INSERT INTO EXAMEN_GRUPO VALUES (22, 22);

-- Registro 23
INSERT INTO EXAMEN_GRUPO VALUES (23, 23);

-- Registro 24
INSERT INTO EXAMEN_GRUPO VALUES (24, 24);

-- Registro 25
INSERT INTO EXAMEN_GRUPO VALUES (25, 25);

-- Registro 26
INSERT INTO EXAMEN_GRUPO VALUES (26, 26);

-- Registro 27
INSERT INTO EXAMEN_GRUPO VALUES (27, 27);

-- Registro 28
INSERT INTO EXAMEN_GRUPO VALUES (28, 28);

-- Registro 29
INSERT INTO EXAMEN_GRUPO VALUES (29, 29);

-- Registro 30
INSERT INTO EXAMEN_GRUPO VALUES (30, 30);

-- Registro 31
INSERT INTO EXAMEN_GRUPO VALUES (31, 31);

-- Registro 32
INSERT INTO EXAMEN_GRUPO VALUES (32, 32);

-- Registro 33
INSERT INTO EXAMEN_GRUPO VALUES (33, 33);

-- Registro 34
INSERT INTO EXAMEN_GRUPO VALUES (34, 34);

-- Registro 35
INSERT INTO EXAMEN_GRUPO VALUES (35, 35);

-- Registro 36
INSERT INTO EXAMEN_GRUPO VALUES (36, 36);

-- Registro 37
INSERT INTO EXAMEN_GRUPO VALUES (37, 37);

-- Registro 38
INSERT INTO EXAMEN_GRUPO VALUES (38, 38);

-- Registro 39
INSERT INTO EXAMEN_GRUPO VALUES (39, 39);

-- Registro 40
INSERT INTO EXAMEN_GRUPO VALUES (40, 40);


--tabla grupo

-- Registro 1
INSERT INTO GRUPO VALUES (1, 'Grupo 1', 'Activo');

-- Registro 2
INSERT INTO GRUPO VALUES (2, 'Grupo 2', 'Activo');

-- Registro 3
INSERT INTO GRUPO VALUES (3, 'Grupo 3', 'Activo');

-- Registro 4
INSERT INTO GRUPO VALUES (4, 'Grupo 4', 'Activo');

-- Registro 5
INSERT INTO GRUPO VALUES (5, 'Grupo 5', 'Activo');

-- Registro 6
INSERT INTO GRUPO VALUES (6, 'Grupo 6', 'Activo');

-- Registro 7
INSERT INTO GRUPO VALUES (7, 'Grupo 7', 'Activo');

-- Registro 8
INSERT INTO GRUPO VALUES (8, 'Grupo 8', 'Activo');

-- Registro 9
INSERT INTO GRUPO VALUES (9, 'Grupo 9', 'Activo');

-- Registro 10
INSERT INTO GRUPO VALUES (10, 'Grupo 10', 'Activo');

-- Registro 11
INSERT INTO GRUPO VALUES (11, 'Grupo 11', 'Activo');

-- Registro 12
INSERT INTO GRUPO VALUES (12, 'Grupo 12', 'Activo');

-- Registro 13
INSERT INTO GRUPO VALUES (13, 'Grupo 13', 'Activo');

-- Registro 14
INSERT INTO GRUPO VALUES (14, 'Grupo 14', 'Activo');

-- Registro 15
INSERT INTO GRUPO VALUES (15, 'Grupo 15', 'Activo');

-- Registro 16
INSERT INTO GRUPO VALUES (16, 'Grupo 16', 'Activo');

-- Registro 17
INSERT INTO GRUPO VALUES (17, 'Grupo 17', 'Activo');

-- Registro 18
INSERT INTO GRUPO VALUES (18, 'Grupo 18', 'Activo');

-- Registro 19
INSERT INTO GRUPO VALUES (19, 'Grupo 19', 'Activo');

-- Registro 20
INSERT INTO GRUPO VALUES (20, 'Grupo 20', 'Activo');

-- Registro 21
INSERT INTO GRUPO VALUES (21, 'Grupo 21', 'Activo');

-- Registro 22
INSERT INTO GRUPO VALUES (22, 'Grupo 22', 'Activo');

-- Registro 23
INSERT INTO GRUPO VALUES (23, 'Grupo 23', 'Activo');

-- Registro 24
INSERT INTO GRUPO VALUES (24, 'Grupo 24', 'Activo');

-- Registro 25
INSERT INTO GRUPO VALUES (25, 'Grupo 25', 'Activo');

-- Registro 26
INSERT INTO GRUPO VALUES (26, 'Grupo 26', 'Activo');

-- Registro 27
INSERT INTO GRUPO VALUES (27, 'Grupo 27', 'Activo');

-- Registro 28
INSERT INTO GRUPO VALUES (28, 'Grupo 28', 'Activo');

-- Registro 29
INSERT INTO GRUPO VALUES (29, 'Grupo 29', 'Activo');

-- Registro 30
INSERT INTO GRUPO VALUES (30, 'Grupo 30', 'Activo');

-- Registro 31
INSERT INTO GRUPO VALUES (31, 'Grupo 31', 'Activo');

-- Registro 32
INSERT INTO GRUPO VALUES (32, 'Grupo 32', 'Activo');

-- Registro 33
INSERT INTO GRUPO VALUES (33, 'Grupo 33', 'Activo');

-- Registro 34
INSERT INTO GRUPO VALUES (34, 'Grupo 34', 'Activo');

-- Registro 35
INSERT INTO GRUPO VALUES (35, 'Grupo 35', 'Activo');

-- Registro 36
INSERT INTO GRUPO VALUES (36, 'Grupo 36', 'Activo');

-- Registro 37
INSERT INTO GRUPO VALUES (37, 'Grupo 37', 'Activo');

-- Registro 38
INSERT INTO GRUPO VALUES (38, 'Grupo 38', 'Activo');

-- Registro 39
INSERT INTO GRUPO VALUES (39, 'Grupo 39', 'Activo');

-- Registro 40
INSERT INTO GRUPO VALUES (40, 'Grupo 40', 'Activo');

--*tabla examen_pregunta

---**TABABLA DE PREGUNTA Y OPCIONES

-- Pregunta 1
INSERT INTO PREGUNTA
VALUES (1, 'Opc_Múltiple', '¿Cuál es la capital de Francia?', 20.0, TO_DATE('2024-04-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));


-- Opciones para la pregunta 1
INSERT INTO OPCION VALUES ('OPT1A', 'París', 'S', 1);
INSERT INTO OPCION VALUES ('OPT1B', 'Madrid', 'N', 1);
INSERT INTO OPCION VALUES ('OPT1C', 'Londres', 'N', 1);

-- Pregunta 2
INSERT INTO PREGUNTA  
VALUES (2, 'Opc_Múltiple', '¿Quién escribió "Don Quijote de la Mancha"?', 20.0, TO_DATE('2024-04-17 10:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 2
INSERT INTO OPCION VALUES ('OPT2A', 'Miguel de Cervantes', 'S', 2);
INSERT INTO OPCION VALUES ('OPT2B', 'Gabriel García Márquez', 'N', 2);
INSERT INTO OPCION VALUES ('OPT2C', 'William Shakespeare', 'N', 2);

-- Pregunta 3
INSERT INTO PREGUNTA 
VALUES (3, 'Opc_Múltiple', '¿Cuál es el símbolo químico del agua?', 20.0, TO_DATE('2024-04-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 3
INSERT INTO OPCION VALUES ('OPT3A', 'H2O', 'S', 3);
INSERT INTO OPCION VALUES ('OPT3B', 'CO2', 'N', 3);
INSERT INTO OPCION VALUES ('OPT3C', 'NaCl', 'N', 3);

-- Pregunta 4
INSERT INTO PREGUNTA  
VALUES (4,  'Opc_Múltiple', '¿Cuál es el resultado de 2 + 2?', 20.0, TO_DATE('2024-04-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 4
INSERT INTO OPCION VALUES ('OPT4A', '3', 'N', 4);
INSERT INTO OPCION VALUES ('OPT4B', '4', 'S', 4);
INSERT INTO OPCION VALUES ('OPT4C', '5', 'N', 4);

-- Pregunta 5
INSERT INTO PREGUNTA 
VALUES (5, 'Opc_Múltiple', '¿Cuál es el planeta más grande del sistema solar?', 20.0, TO_DATE('2024-04-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 5
INSERT INTO OPCION VALUES ('OPT5A', 'Júpiter', 'S', 5);
INSERT INTO OPCION VALUES ('OPT5B', 'Marte', 'N', 5);
INSERT INTO OPCION VALUES ('OPT5C', 'Tierra', 'N', 5);

-- Pregunta 6
INSERT INTO PREGUNTA 
VALUES (6, 'Opc_Múltiple', '¿Cuál es el quinto elemento en la tabla periódica?', 20.0, TO_DATE('2024-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 6
INSERT INTO OPCION VALUES ('OPT6A', 'Hidrógeno', 'N', 6);
INSERT INTO OPCION VALUES ('OPT6B', 'Oxígeno', 'N', 6);
INSERT INTO OPCION VALUES ('OPT6C', 'Boro', 'S', 6);

-- Pregunta 7
INSERT INTO PREGUNTA  
VALUES (7, 'Opc_Múltiple', '¿Cuál es el símbolo químico del oro?', 20.0, TO_DATE('2024-04-17 15:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 7
INSERT INTO OPCION VALUES ('OPT7A', 'Ag', 'N', 7);
INSERT INTO OPCION VALUES ('OPT7B', 'Fe', 'N', 7);
INSERT INTO OPCION VALUES ('OPT7C', 'Au', 'S', 7);

-- Pregunta 8
INSERT INTO PREGUNTA  
VALUES (8, 'Opc_Múltiple', '¿Cuál es el símbolo químico del calcio?', 20.0, TO_DATE('2024-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 8
INSERT INTO OPCION VALUES ('OPT8A', 'Ca', 'S', 8);
INSERT INTO OPCION VALUES ('OPT8B', 'Co', 'N', 8);
INSERT INTO OPCION VALUES ('OPT8C', 'Cl', 'N', 8);

-- Pregunta 9
INSERT INTO PREGUNTA  
VALUES (9, 'Opc_Múltiple', '¿Cuál es el símbolo químico del carbono?', 20.0, TO_DATE('2024-04-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 9
INSERT INTO OPCION VALUES ('OPT9A', 'Co', 'N', 9);
INSERT INTO OPCION VALUES ('OPT9B', 'C', 'S', 9);
INSERT INTO OPCION VALUES ('OPT9C', 'Cr', 'N', 9);

-- Pregunta 10
INSERT INTO PREGUNTA  
VALUES (10, 'Opc_Múltiple', '¿Quién descubrió América?', 20.0, TO_DATE('2024-04-17 18:00:00',  'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 10
INSERT INTO OPCION VALUES ('OPT10A', 'Cristóbal Colón', 'S', 10);
INSERT INTO OPCION VALUES ('OPT10B', 'Fernando de Magallanes', 'N', 10);
INSERT INTO OPCION VALUES ('OPT10C', 'Vasco de Gama', 'N', 10);

-- Pregunta 11
INSERT INTO PREGUNTA  
VALUES (11,'Opc_Múltiple', '¿Cuál es el símbolo químico del sodio?', 20.0, TO_DATE('2024-04-17 19:00:00',  'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 11
INSERT INTO OPCION VALUES ('OPT11A', 'Sn', 'N', 11);
INSERT INTO OPCION VALUES ('OPT11B', 'So', 'N', 11);
INSERT INTO OPCION VALUES ('OPT11C', 'Na', 'S', 11);

-- Pregunta 12
INSERT INTO PREGUNTA  
VALUES (12, 'Opc_Múltiple', '¿Quién escribió "Romeo y Julieta"?', 20.0, TO_DATE('2024-04-17 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 12
INSERT INTO OPCION VALUES ('OPT12A', 'William Shakespeare', 'S', 12);
INSERT INTO OPCION VALUES ('OPT12B', 'Miguel de Cervantes', 'N', 12);
INSERT INTO OPCION VALUES ('OPT12C', 'Homero', 'N', 12);

-- Pregunta 13
INSERT INTO PREGUNTA  
VALUES (13, 'Opc_Múltiple', '¿Cuál es el símbolo químico del hierro?', 20.0, TO_DATE('2024-04-17 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 13
INSERT INTO OPCION VALUES ('OPT13A', 'Ir', 'N', 13);
INSERT INTO OPCION VALUES ('OPT13B', 'Fe', 'S', 13);
INSERT INTO OPCION VALUES ('OPT13C', 'Hr', 'N', 13);

-- Pregunta 14
INSERT INTO PREGUNTA 
VALUES (14, 'Opc_Múltiple', '¿Cuál es el resultado de 10 * 5?', 20.0, TO_DATE('2024-04-17 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 14
INSERT INTO OPCION VALUES ('OPT14A', '45', 'N', 14);
INSERT INTO OPCION VALUES ('OPT14B', '50', 'S', 14);
INSERT INTO OPCION VALUES ('OPT14C', '55', 'N', 14);

-- Pregunta 15
INSERT INTO PREGUNTA  
VALUES (15, 'Opc_Múltiple', '¿Cuál es el océano más grande del mundo?', 20.0, TO_DATE('2024-04-17 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 15
INSERT INTO OPCION VALUES ('OPT15A', 'Atlántico', 'N', 15);
INSERT INTO OPCION VALUES ('OPT15B', 'Índico', 'N', 15);
INSERT INTO OPCION VALUES ('OPT15C', 'Pacífico', 'S', 15);

-- Pregunta 16
INSERT INTO PREGUNTA 
VALUES (16,  'Opc_Múltiple', '¿Quién fue el primer presidente de Estados Unidos?', 20.0, TO_DATE('2024-04-18 09:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 16
INSERT INTO OPCION VALUES ('OPT16A', 'Thomas Jefferson', 'N', 16);
INSERT INTO OPCION VALUES ('OPT16B', 'George Washington', 'S', 16);
INSERT INTO OPCION VALUES ('OPT16C', 'John Adams', 'N', 16);

-- Pregunta 17
INSERT INTO PREGUNTA 
VALUES (17,  'Opc_Múltiple', '¿Cuál es el símbolo químico del hidrógeno?', 20.0, TO_DATE('2024-04-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 17
INSERT INTO OPCION VALUES ('OPT17A', 'Hy', 'N', 17);
INSERT INTO OPCION VALUES ('OPT17B', 'Hg', 'N', 17);
INSERT INTO OPCION VALUES ('OPT17C', 'H', 'S', 17);

-- Pregunta 18
INSERT INTO PREGUNTA  
VALUES (18,  'Opc_Múltiple', '¿Cuál es la montaña más alta del mundo?', 20.0, TO_DATE('2024-04-18 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 18
INSERT INTO OPCION VALUES ('OPT18A', 'Monte Everest', 'S', 18);
INSERT INTO OPCION VALUES ('OPT18B', 'Mont Blanc', 'N', 18);
INSERT INTO OPCION VALUES ('OPT18C', 'Monte Kilimanjaro', 'N', 18);

-- Pregunta 19
INSERT INTO PREGUNTA 
VALUES (19,  'Opc_Múltiple', '¿Quién pintó la Mona Lisa?', 20.0, TO_DATE('2024-04-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 19
INSERT INTO OPCION VALUES ('OPT19A', 'Pablo Picasso', 'N', 19);
INSERT INTO OPCION VALUES ('OPT19B', 'Leonardo da Vinci', 'S', 19);
INSERT INTO OPCION VALUES ('OPT19C', 'Vincent van Gogh', 'N', 19);

-- Pregunta 20
INSERT INTO PREGUNTA  
VALUES (20,  'Opc_Múltiple', '¿Cuál es el símbolo químico del helio?', 20.0, TO_DATE('2024-04-18 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 20
INSERT INTO OPCION VALUES ('OPT20A', 'Hl', 'N', 20);
INSERT INTO OPCION VALUES ('OPT20B', 'He', 'S', 20);
INSERT INTO OPCION VALUES ('OPT20C', 'Hl', 'N', 20);

-- Pregunta 21
INSERT INTO PREGUNTA 
VALUES (21,  'Opc_Múltiple', '¿Cuál es el animal terrestre más grande?', 20.0, TO_DATE('2024-04-18 14:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 21
INSERT INTO OPCION VALUES ('OPT21A', 'Caballo', 'N', 21);
INSERT INTO OPCION VALUES ('OPT21B', 'Jirafa', 'N', 21);
INSERT INTO OPCION VALUES ('OPT21C', 'Elefante africano', 'S', 21);

-- Pregunta 22
INSERT INTO PREGUNTA  
VALUES (22,  'Opc_Múltiple', '¿Cuál es la capital de Italia?', 20.0, TO_DATE('2024-04-18 15:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 22
INSERT INTO OPCION VALUES ('OPT22A', 'Madrid', 'N', 22);
INSERT INTO OPCION VALUES ('OPT22B', 'París', 'N', 22);
INSERT INTO OPCION VALUES ('OPT22C', 'Roma', 'S', 22);

-- Pregunta 23
INSERT INTO PREGUNTA 
VALUES (23,  'Opc_Múltiple', '¿Quién escribió "Hamlet"?', 20.0, TO_DATE('2024-04-18 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 23
INSERT INTO OPCION VALUES ('OPT23A', 'Charles Dickens', 'N', 23);
INSERT INTO OPCION VALUES ('OPT23B', 'Mark Twain', 'N', 23);
INSERT INTO OPCION VALUES ('OPT23C', 'William Shakespeare', 'S', 23);

-- Pregunta 24
INSERT INTO PREGUNTA  
VALUES (24,  'Opc_Múltiple', '¿Cuál es el símbolo químico del oxígeno?', 20.0, TO_DATE('2024-04-18 17:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 24
INSERT INTO OPCION VALUES ('OPT24A', 'Og', 'N', 24);
INSERT INTO OPCION VALUES ('OPT24B', 'Ox', 'N', 24);
INSERT INTO OPCION VALUES ('OPT24C', 'O', 'S', 24);

-- Pregunta 25
INSERT INTO PREGUNTA 
VALUES (25,  'Opc_Múltiple', '¿Cuál es el país más poblado del mundo?', 20.0, TO_DATE('2024-04-18 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 25
INSERT INTO OPCION VALUES ('OPT25A', 'India', 'N', 25);
INSERT INTO OPCION VALUES ('OPT25B', 'Estados Unidos', 'N', 25);
INSERT INTO OPCION VALUES ('OPT25C', 'China', 'S', 25);

-- Pregunta 26
INSERT INTO PREGUNTA 
VALUES (26,  'Opc_Múltiple', '¿Quién fue el primer ser humano en viajar al espacio?', 20.0, TO_DATE('2024-04-18 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 26
INSERT INTO OPCION VALUES ('OPT26A', 'Yuri Gagarin', 'S', 26);
INSERT INTO OPCION VALUES ('OPT26B', 'Neil Armstrong', 'N', 26);
INSERT INTO OPCION VALUES ('OPT26C', 'Buzz Aldrin', 'N', 26);

-- Pregunta 27
INSERT INTO PREGUNTA 
VALUES (27,  'Opc_Múltiple', '¿Cuál es el símbolo químico del platino?', 20.0, TO_DATE('2024-04-18 20:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 27
INSERT INTO OPCION VALUES ('OPT27A', 'Pt', 'S', 27);
INSERT INTO OPCION VALUES ('OPT27B', 'Pl', 'N', 27);
INSERT INTO OPCION VALUES ('OPT27C', 'Pm', 'N', 27);

-- Pregunta 28
INSERT INTO PREGUNTA  
VALUES (28,  'Opc_Múltiple', '¿Cuál es la velocidad de la luz en el vacío?', 20.0, TO_DATE('2024-04-18 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 28
INSERT INTO OPCION VALUES ('OPT28A', '300,000 m/s', 'N', 28);
INSERT INTO OPCION VALUES ('OPT28B', '200,000 m/s', 'N', 28);
INSERT INTO OPCION VALUES ('OPT28C', '299,792,458 m/s', 'S', 28);

-- Pregunta 29
INSERT INTO PREGUNTA 
VALUES (29,  'Opc_Múltiple', '¿Quién fue el primer emperador romano?', 20.0, TO_DATE('2024-04-18 22:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 29
INSERT INTO OPCION VALUES ('OPT29A', 'Julio César', 'N', 29);
INSERT INTO OPCION VALUES ('OPT29B', 'Marco Antonio', 'N', 29);
INSERT INTO OPCION VALUES ('OPT29C', 'Augusto', 'S', 29);

-- Pregunta 30
INSERT INTO PREGUNTA 
VALUES (30,  'Opc_Múltiple', '¿Cuál es el símbolo químico del potasio?', 20.0, TO_DATE('2024-04-18 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 30
INSERT INTO OPCION VALUES ('OPT30A', 'P', 'N', 30);
INSERT INTO OPCION VALUES ('OPT30B', 'Po', 'N', 30);
INSERT INTO OPCION VALUES ('OPT30C', 'K', 'S', 30);

-- Pregunta 31
INSERT INTO PREGUNTA 
VALUES (31, 'Opc_Múltiple', '¿Cuál es el río más largo del mundo?', 20.0, TO_DATE('2024-04-19 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 31
INSERT INTO OPCION VALUES ('OPT31A', 'Nilo', 'N', 31);
INSERT INTO OPCION VALUES ('OPT31B', 'Amazonas', 'S', 31);
INSERT INTO OPCION VALUES ('OPT31C', 'Yangtsé', 'N', 31);

-- Pregunta 32
INSERT INTO PREGUNTA 
VALUES (32,  'Opc_Múltiple', '¿Cuál es el símbolo químico del nitrógeno?', 20.0, TO_DATE('2024-04-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 32
INSERT INTO OPCION VALUES ('OPT32A', 'Nr', 'N', 32);
INSERT INTO OPCION VALUES ('OPT32B', 'Ni', 'N', 32);
INSERT INTO OPCION VALUES ('OPT32C', 'N', 'S', 32);

-- Pregunta 33
INSERT INTO PREGUNTA 
VALUES (33, 'Opc_Múltiple', '¿Quién fue el primer hombre en pisar la luna?', 20.0, TO_DATE('2024-04-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 33
INSERT INTO OPCION VALUES ('OPT33A', 'Buzz Aldrin', 'N', 33);
INSERT INTO OPCION VALUES ('OPT33B', 'Yuri Gagarin', 'N', 33);
INSERT INTO OPCION VALUES ('OPT33C', 'Neil Armstrong', 'S', 33);

-- Pregunta 34
INSERT INTO PREGUNTA 
VALUES (34,  'Opc_Múltiple', '¿Cuál es la ciudad más poblada del mundo?', 20.0, TO_DATE('2024-04-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 34
INSERT INTO OPCION VALUES ('OPT34A', 'Shanghái', 'N', 34);
INSERT INTO OPCION VALUES ('OPT34B', 'Delhi', 'N', 34);
INSERT INTO OPCION VALUES ('OPT34C', 'Tokio', 'S', 34);

-- Pregunta 35
INSERT INTO PREGUNTA 
VALUES (35,  'Opc_Múltiple', '¿Cuál es el símbolo químico del cobre?', 20.0, TO_DATE('2024-04-19 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 35
INSERT INTO OPCION VALUES ('OPT35A', 'Cb', 'N', 35);
INSERT INTO OPCION VALUES ('OPT35B', 'Cu', 'S', 35);
INSERT INTO OPCION VALUES ('OPT35C', 'Co', 'N', 35);

-- Pregunta 36
INSERT INTO PREGUNTA 
VALUES (36,  'Opc_Múltiple', '¿Cuál es el animal más veloz del mundo?', 20.0, TO_DATE('2024-04-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 36
INSERT INTO OPCION VALUES ('OPT36A', 'Guepardo', 'S', 36);
INSERT INTO OPCION VALUES ('OPT36B', 'Leopardo', 'N', 36);
INSERT INTO OPCION VALUES ('OPT36C', 'Águila pescadora', 'N', 36);

-- Pregunta 37
INSERT INTO PREGUNTA
VALUES (37,  'Opc_Múltiple', '¿Cuál es la capital de Australia?', 20.0, TO_DATE('2024-04-19 15:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 37
INSERT INTO OPCION VALUES ('OPT37A', 'Melbourne', 'N', 37);
INSERT INTO OPCION VALUES ('OPT37B', 'Sídney', 'N', 37);
INSERT INTO OPCION VALUES ('OPT37C', 'Canberra', 'S', 37);

-- Pregunta 38
INSERT INTO PREGUNTA
VALUES (38,  'Opc_Múltiple', '¿Quién pintó "La noche estrellada"?', 20.0, TO_DATE('2024-04-19 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 38
INSERT INTO OPCION VALUES ('OPT38A', 'Pablo Picasso', 'N', 38);
INSERT INTO OPCION VALUES ('OPT38B', 'Leonardo da Vinci', 'N', 38);
INSERT INTO OPCION VALUES ('OPT38C', 'Vincent van Gogh', 'S', 38);

-- Pregunta 39
INSERT INTO PREGUNTA 
VALUES (39,  'Opc_Múltiple', '¿Cuál es el elemento más abundante en la corteza terrestre?', 20.0, TO_DATE('2024-04-19 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 39
INSERT INTO OPCION VALUES ('OPT39A', 'Hierro', 'N', 39);
INSERT INTO OPCION VALUES ('OPT39B', 'Oxígeno', 'N', 39);
INSERT INTO OPCION VALUES ('OPT39C', 'Silicio', 'S', 39);

-- Pregunta 40
INSERT INTO PREGUNTA 
VALUES (40, 'Opc_Múltiple', '¿Cuál es el océano más grande del mundo?', 20.0, TO_DATE('2024-04-19 18:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Opciones para la pregunta 40
INSERT INTO OPCION VALUES ('OPT40A', 'Océano Atlántico', 'N', 40);
INSERT INTO OPCION VALUES ('OPT40B', 'Océano Índico', 'N', 40);
INSERT INTO OPCION VALUES ('OPT40C', 'Océano Pacífico', 'S', 40);


---TABLA GRUPO_ESTUDIANTE

-- Inserción de datos en la tabla GRUPO_ESTUDIANTE para el grupo 1
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 1);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 2);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 3);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 4);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 5);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 6);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 7);
INSERT INTO GRUPO_ESTUDIANTE VALUES (1, 8);

-- Inserción de datos en la tabla GRUPO_ESTUDIANTE para el grupo 2
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 9);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 10);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 11);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 12);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 13);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 14);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 15);
INSERT INTO GRUPO_ESTUDIANTE VALUES (2, 16);

-- Inserción de datos en la tabla GRUPO_ESTUDIANTE para el grupo 3
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 17);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 18);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 19);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 20);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 21);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 22);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 23);
INSERT INTO GRUPO_ESTUDIANTE VALUES (3, 24);

-- Inserción de datos en la tabla GRUPO_ESTUDIANTE para el grupo 4
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 25);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 26);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 27);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 28);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 29);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 30);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 31);
INSERT INTO GRUPO_ESTUDIANTE VALUES (4, 32);

-- Inserción de datos en la tabla GRUPO_ESTUDIANTE para el grupo 5
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 33);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 34);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 35);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 36);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 37);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 38);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 39);
INSERT INTO GRUPO_ESTUDIANTE VALUES (5, 40);


---TABLA EXAMEN-PREGUNTA
-- Insertar las relaciones examen-pregunta para el examen 1
INSERT INTO EXAMEN_PREGUNTA VALUES (1, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (1, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (1, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (1, 4);
INSERT INTO EXAMEN_PREGUNTA VALUES (1, 5);

-- Insertar las relaciones examen-pregunta para el examen 2
INSERT INTO EXAMEN_PREGUNTA VALUES (2, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (2, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (2, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (2, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (2, 9);

-- Insertar las relaciones examen-pregunta para el examen 3
INSERT INTO EXAMEN_PREGUNTA VALUES (3, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (3, 4);
INSERT INTO EXAMEN_PREGUNTA VALUES (3, 6);
INSERT INTO EXAMEN_PREGUNTA VALUES (3, 8);
INSERT INTO EXAMEN_PREGUNTA VALUES (3, 10);

-- Insertar las relaciones examen-pregunta para el examen 4
INSERT INTO EXAMEN_PREGUNTA VALUES (4, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (4, 4);
INSERT INTO EXAMEN_PREGUNTA VALUES (4, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (4, 10);
INSERT INTO EXAMEN_PREGUNTA VALUES (4, 13);

-- Insertar las relaciones examen-pregunta para el examen 5
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 9);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 11);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 13);
INSERT INTO EXAMEN_PREGUNTA VALUES (5, 15);

-- Insertar las relaciones examen-pregunta para el examen 6
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 4);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 6);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 8);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 10);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 12);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 14);
INSERT INTO EXAMEN_PREGUNTA VALUES (6, 16);

-- Insertar las relaciones examen-pregunta para el examen 7
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 4);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 6);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 8);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 9);
INSERT INTO EXAMEN_PREGUNTA VALUES (7, 10);

-- Insertar las relaciones examen-pregunta para el examen 8
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 11);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 13);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 17);
INSERT INTO EXAMEN_PREGUNTA VALUES (8, 19);

-- Insertar las relaciones examen-pregunta para el examen 9
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 4);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 6);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 8);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 9);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 10);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 11);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 12);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 13);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 14);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 15);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 16);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 17);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 18);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 19);
INSERT INTO EXAMEN_PREGUNTA VALUES (9, 20);

-- Insertar las relaciones examen-pregunta para el examen 10
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 7);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 11);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 13);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 17);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 19);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 23);
INSERT INTO EXAMEN_PREGUNTA VALUES (10, 29);

-- Insertar las relaciones examen-pregunta para el examen 11
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 1);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 3);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 6);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 10);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 15);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 21);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 27);
INSERT INTO EXAMEN_PREGUNTA VALUES (11, 33);

-- Insertar las relaciones examen-pregunta para el examen 12
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 2);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 5);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 9);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 14);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 20);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 26);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 32);
INSERT INTO EXAMEN_PREGUNTA VALUES (12, 38);

--TABLA LUGAR
-- Insertar registros en la tabla LUGAR
INSERT INTO LUGAR VALUES ('Aula 1', 1);
INSERT INTO LUGAR VALUES ('Aula 2', 2);
INSERT INTO LUGAR VALUES ('Aula 3', 3);
INSERT INTO LUGAR VALUES ('Aula 4', 4);
INSERT INTO LUGAR VALUES ('Aula 5', 5);
INSERT INTO LUGAR VALUES ('Aula 6', 6);
INSERT INTO LUGAR VALUES ('Aula 7', 7);
INSERT INTO LUGAR VALUES ('Aula 8', 8);
INSERT INTO LUGAR VALUES ('Aula 9', 9);
INSERT INTO LUGAR VALUES ('Aula 10', 10);
INSERT INTO LUGAR VALUES ('Aula 11', 11);
INSERT INTO LUGAR VALUES ('Aula 12', 12);
INSERT INTO LUGAR VALUES ('Aula 13', 13);
INSERT INTO LUGAR VALUES ('Aula 14', 14);
INSERT INTO LUGAR VALUES ('Aula 15', 15);
INSERT INTO LUGAR VALUES ('Aula 16', 16);
INSERT INTO LUGAR VALUES ('Aula 17', 17);
INSERT INTO LUGAR VALUES ('Aula 18', 18);
INSERT INTO LUGAR VALUES ('Aula 19', 19);
INSERT INTO LUGAR VALUES ('Aula 20', 20);
INSERT INTO LUGAR VALUES ('Aula 21', 21);
INSERT INTO LUGAR VALUES ('Aula 22', 22);
INSERT INTO LUGAR VALUES ('Aula 23', 23);
INSERT INTO LUGAR VALUES ('Aula 24', 24);
INSERT INTO LUGAR VALUES ('Aula 25', 25);
INSERT INTO LUGAR VALUES ('Aula 26', 26);
INSERT INTO LUGAR VALUES ('Aula 27', 27);
INSERT INTO LUGAR VALUES ('Aula 28', 28);
INSERT INTO LUGAR VALUES ('Aula 29', 29);
INSERT INTO LUGAR VALUES ('Aula 30', 30);
INSERT INTO LUGAR VALUES ('Aula 31', 31);
INSERT INTO LUGAR VALUES ('Aula 32', 32);
INSERT INTO LUGAR VALUES ('Aula 33', 33);
INSERT INTO LUGAR VALUES ('Aula 34', 34);
INSERT INTO LUGAR VALUES ('Aula 35', 35);
INSERT INTO LUGAR VALUES ('Aula 36', 36);
INSERT INTO LUGAR VALUES ('Aula 37', 37);
INSERT INTO LUGAR VALUES ('Aula 38', 38);
INSERT INTO LUGAR VALUES ('Aula 39', 39);
INSERT INTO LUGAR VALUES ('Aula 40', 40);


--TABLA LUGAR HORARIO
-- Insertar registros para la tabla LUGAR_HORARIO
INSERT INTO LUGAR_HORARIO VALUES (1, 1);
INSERT INTO LUGAR_HORARIO VALUES (1, 2);
INSERT INTO LUGAR_HORARIO VALUES (2, 3);
INSERT INTO LUGAR_HORARIO VALUES (2, 4);
INSERT INTO LUGAR_HORARIO VALUES (3, 5);
INSERT INTO LUGAR_HORARIO VALUES (3, 6);
INSERT INTO LUGAR_HORARIO VALUES (4, 7);
INSERT INTO LUGAR_HORARIO VALUES (4, 8);
INSERT INTO LUGAR_HORARIO VALUES (5, 9);
INSERT INTO LUGAR_HORARIO VALUES (5, 10);
INSERT INTO LUGAR_HORARIO VALUES (6, 11);
INSERT INTO LUGAR_HORARIO VALUES (6, 12);
INSERT INTO LUGAR_HORARIO VALUES (7, 13);
INSERT INTO LUGAR_HORARIO VALUES (7, 14);
INSERT INTO LUGAR_HORARIO VALUES (8, 15);
INSERT INTO LUGAR_HORARIO VALUES (8, 16);
INSERT INTO LUGAR_HORARIO VALUES (9, 17);
INSERT INTO LUGAR_HORARIO VALUES (9, 18);
INSERT INTO LUGAR_HORARIO VALUES (10, 19);
INSERT INTO LUGAR_HORARIO VALUES (10, 20);
INSERT INTO LUGAR_HORARIO VALUES (11, 21);
INSERT INTO LUGAR_HORARIO VALUES (11, 22);
INSERT INTO LUGAR_HORARIO VALUES (12, 23);
INSERT INTO LUGAR_HORARIO VALUES (12, 24);
INSERT INTO LUGAR_HORARIO VALUES (13, 25);
INSERT INTO LUGAR_HORARIO VALUES (13, 26);
INSERT INTO LUGAR_HORARIO VALUES (14, 27);
INSERT INTO LUGAR_HORARIO VALUES (14, 28);
INSERT INTO LUGAR_HORARIO VALUES (15, 29);
INSERT INTO LUGAR_HORARIO VALUES (15, 30);
INSERT INTO LUGAR_HORARIO VALUES (16, 31);
INSERT INTO LUGAR_HORARIO VALUES (16, 32);
INSERT INTO LUGAR_HORARIO VALUES (17, 33);
INSERT INTO LUGAR_HORARIO VALUES (17, 34);
INSERT INTO LUGAR_HORARIO VALUES (18, 35);
INSERT INTO LUGAR_HORARIO VALUES (18, 36);
INSERT INTO LUGAR_HORARIO VALUES (19, 37);
INSERT INTO LUGAR_HORARIO VALUES (19, 38);
INSERT INTO LUGAR_HORARIO VALUES (20, 39);
INSERT INTO LUGAR_HORARIO VALUES (20, 40);
INSERT INTO LUGAR_HORARIO VALUES (21, 1);
INSERT INTO LUGAR_HORARIO VALUES (21, 2);
INSERT INTO LUGAR_HORARIO VALUES (22, 3);
INSERT INTO LUGAR_HORARIO VALUES (22, 4);
INSERT INTO LUGAR_HORARIO VALUES (23, 5);
INSERT INTO LUGAR_HORARIO VALUES (23, 6);
INSERT INTO LUGAR_HORARIO VALUES (24, 7);
INSERT INTO LUGAR_HORARIO VALUES (24, 8);
INSERT INTO LUGAR_HORARIO VALUES (25, 9);
INSERT INTO LUGAR_HORARIO VALUES (25, 10);
INSERT INTO LUGAR_HORARIO VALUES (26, 11);
INSERT INTO LUGAR_HORARIO VALUES (26, 12);
INSERT INTO LUGAR_HORARIO VALUES (27, 13);
INSERT INTO LUGAR_HORARIO VALUES (27, 14);
INSERT INTO LUGAR_HORARIO VALUES (28, 15);
INSERT INTO LUGAR_HORARIO VALUES (28, 16);
INSERT INTO LUGAR_HORARIO VALUES (29, 17);
INSERT INTO LUGAR_HORARIO VALUES (29, 18);
INSERT INTO LUGAR_HORARIO VALUES (30, 19);
INSERT INTO LUGAR_HORARIO VALUES (30, 20);
INSERT INTO LUGAR_HORARIO VALUES (31, 21);
INSERT INTO LUGAR_HORARIO VALUES (31, 22);
INSERT INTO LUGAR_HORARIO VALUES (32, 23);
INSERT INTO LUGAR_HORARIO VALUES (32, 24);
INSERT INTO LUGAR_HORARIO VALUES (33, 25);
INSERT INTO LUGAR_HORARIO VALUES (33, 26);
INSERT INTO LUGAR_HORARIO VALUES (34, 27);
INSERT INTO LUGAR_HORARIO VALUES (34, 28);
INSERT INTO LUGAR_HORARIO VALUES (35, 29);
INSERT INTO LUGAR_HORARIO VALUES (35, 30);
INSERT INTO LUGAR_HORARIO VALUES (36, 31);
INSERT INTO LUGAR_HORARIO VALUES (36, 32);
INSERT INTO LUGAR_HORARIO VALUES (37, 33);
INSERT INTO LUGAR_HORARIO VALUES (37, 34);
INSERT INTO LUGAR_HORARIO VALUES (38, 35);
INSERT INTO LUGAR_HORARIO VALUES (38, 36);
INSERT INTO LUGAR_HORARIO VALUES (39, 37);
INSERT INTO LUGAR_HORARIO VALUES (39, 38);
INSERT INTO LUGAR_HORARIO VALUES (40, 39);
INSERT INTO LUGAR_HORARIO VALUES (40, 40);


---TABLA PROFESOR
-- Insertar 40 registros en la tabla PROFESOR con nombres y apellidos
INSERT INTO PROFESOR VALUES (1, 'Juan', 'García');
INSERT INTO PROFESOR VALUES (2, 'María', 'López');
INSERT INTO PROFESOR VALUES (3, 'Carlos', 'Martínez');
INSERT INTO PROFESOR VALUES (4, 'Ana', 'Rodríguez');
INSERT INTO PROFESOR VALUES (5, 'Pedro', 'Hernández');
INSERT INTO PROFESOR VALUES (6, 'Laura', 'González');
INSERT INTO PROFESOR VALUES (7, 'David', 'Pérez');
INSERT INTO PROFESOR VALUES (8, 'Sofía', 'Sánchez');
INSERT INTO PROFESOR VALUES (9, 'Diego', 'Romero');
INSERT INTO PROFESOR VALUES (10, 'Elena', 'Díaz');
INSERT INTO PROFESOR VALUES (11, 'Alejandro', 'Torres');
INSERT INTO PROFESOR VALUES (12, 'Carmen', 'Ruiz');
INSERT INTO PROFESOR VALUES (13, 'Javier', 'Jiménez');
INSERT INTO PROFESOR VALUES (14, 'Paula', 'Álvarez');
INSERT INTO PROFESOR VALUES (15, 'Mario', 'Fernández');
INSERT INTO PROFESOR VALUES (16, 'Isabel', 'Moreno');
INSERT INTO PROFESOR VALUES (17, 'Lucía', 'Vázquez');
INSERT INTO PROFESOR VALUES (18, 'Fernando', 'Serrano');
INSERT INTO PROFESOR VALUES (19, 'Natalia', 'Iglesias');
INSERT INTO PROFESOR VALUES (20, 'Adrián', 'Ortega');
INSERT INTO PROFESOR VALUES (21, 'Raquel', 'Navarro');
INSERT INTO PROFESOR VALUES (22, 'Rubén', 'Gómez');
INSERT INTO PROFESOR VALUES (23, 'Sara', 'Delgado');
INSERT INTO PROFESOR VALUES (24, 'Héctor', 'Molina');
INSERT INTO PROFESOR VALUES (25, 'Patricia', 'Cortés');
INSERT INTO PROFESOR VALUES (26, 'Antonio', 'Reyes');
INSERT INTO PROFESOR VALUES (27, 'Eva', 'Peña');
INSERT INTO PROFESOR VALUES (28, 'Víctor', 'Blanco');
INSERT INTO PROFESOR VALUES (29, 'Nuria', 'Márquez');
INSERT INTO PROFESOR VALUES (30, 'Óscar', 'Garrido');
INSERT INTO PROFESOR VALUES (31, 'Marta', 'Vidal');
INSERT INTO PROFESOR VALUES (32, 'Ángela', 'Luna');
INSERT INTO PROFESOR VALUES (33, 'Ricardo', 'Fuentes');
INSERT INTO PROFESOR VALUES (34, 'Beatriz', 'Ramos');
INSERT INTO PROFESOR VALUES (35, 'Ignacio', 'Crespo');
INSERT INTO PROFESOR VALUES (36, 'Luisa', 'Santos');
INSERT INTO PROFESOR VALUES (37, 'Roberto', 'Esteban');
INSERT INTO PROFESOR VALUES (38, 'Cristina', 'Arias');
INSERT INTO PROFESOR VALUES (39, 'Gloria', 'Morales');
INSERT INTO PROFESOR VALUES (40, 'Manuel', 'Benítez');

--TABLA EXAMEN PROFESOR
-- Insertar relaciones examen-profesor con diferentes combinaciones
-- Para el examen 1
INSERT INTO EXAMEN_PROFESOR VALUES (1, 1);
INSERT INTO EXAMEN_PROFESOR VALUES (1, 2);
INSERT INTO EXAMEN_PROFESOR VALUES (1, 3);

-- Para el examen 2
INSERT INTO EXAMEN_PROFESOR VALUES (2, 4);
INSERT INTO EXAMEN_PROFESOR VALUES (2, 5);

-- Para el examen 3
INSERT INTO EXAMEN_PROFESOR VALUES (3, 6);
INSERT INTO EXAMEN_PROFESOR VALUES (3, 7);
INSERT INTO EXAMEN_PROFESOR VALUES (3, 8);

-- Para el examen 4
INSERT INTO EXAMEN_PROFESOR VALUES (4, 9);
INSERT INTO EXAMEN_PROFESOR VALUES (4, 10);
INSERT INTO EXAMEN_PROFESOR VALUES (4, 11);
INSERT INTO EXAMEN_PROFESOR VALUES (4, 12);

-- Para el examen 5
INSERT INTO EXAMEN_PROFESOR VALUES (5, 13);
INSERT INTO EXAMEN_PROFESOR VALUES (5, 14);
INSERT INTO EXAMEN_PROFESOR VALUES (5, 15);
INSERT INTO EXAMEN_PROFESOR VALUES (5, 16);

-- Para el examen 6
INSERT INTO EXAMEN_PROFESOR VALUES (6, 17);
INSERT INTO EXAMEN_PROFESOR VALUES (6, 18);
INSERT INTO EXAMEN_PROFESOR VALUES (6, 19);
INSERT INTO EXAMEN_PROFESOR VALUES (6, 20);
INSERT INTO EXAMEN_PROFESOR VALUES (6, 21);

-- Para el examen 7
INSERT INTO EXAMEN_PROFESOR VALUES (7, 22);
INSERT INTO EXAMEN_PROFESOR VALUES (7, 23);

-- Para el examen 8
INSERT INTO EXAMEN_PROFESOR VALUES (8, 24);
INSERT INTO EXAMEN_PROFESOR VALUES (8, 25);
INSERT INTO EXAMEN_PROFESOR VALUES (8, 26);

-- Para el examen 9
INSERT INTO EXAMEN_PROFESOR VALUES (9, 27);
INSERT INTO EXAMEN_PROFESOR VALUES (9, 28);
INSERT INTO EXAMEN_PROFESOR VALUES (9, 29);
INSERT INTO EXAMEN_PROFESOR VALUES (9, 30);

-- Para el examen 10
INSERT INTO EXAMEN_PROFESOR VALUES (10, 31);
INSERT INTO EXAMEN_PROFESOR VALUES (10, 32);
INSERT INTO EXAMEN_PROFESOR VALUES (10, 33);
INSERT INTO EXAMEN_PROFESOR VALUES (10, 34);
-- Para el examen 11
INSERT INTO EXAMEN_PROFESOR VALUES (11, 35);
INSERT INTO EXAMEN_PROFESOR VALUES (11, 36);

-- Para el examen 12
INSERT INTO EXAMEN_PROFESOR VALUES (12, 37);
INSERT INTO EXAMEN_PROFESOR VALUES (12, 38);
INSERT INTO EXAMEN_PROFESOR VALUES (12, 39);

-- Para el examen 13
INSERT INTO EXAMEN_PROFESOR VALUES (13, 40);
INSERT INTO EXAMEN_PROFESOR VALUES (13, 1);
INSERT INTO EXAMEN_PROFESOR VALUES (13, 2);

-- Para el examen 14
INSERT INTO EXAMEN_PROFESOR VALUES (14, 3);
INSERT INTO EXAMEN_PROFESOR VALUES (14, 4);
INSERT INTO EXAMEN_PROFESOR VALUES (14, 5);
INSERT INTO EXAMEN_PROFESOR VALUES (14, 6);

-- Para el examen 15
INSERT INTO EXAMEN_PROFESOR VALUES (15, 7);
INSERT INTO EXAMEN_PROFESOR VALUES (15, 8);
INSERT INTO EXAMEN_PROFESOR VALUES (15, 9);
INSERT INTO EXAMEN_PROFESOR VALUES (15, 10);

-- Para el examen 16
INSERT INTO EXAMEN_PROFESOR VALUES (16, 11);
INSERT INTO EXAMEN_PROFESOR VALUES (16, 12);
INSERT INTO EXAMEN_PROFESOR VALUES (16, 13);

-- Para el examen 17
INSERT INTO EXAMEN_PROFESOR VALUES (17, 14);
INSERT INTO EXAMEN_PROFESOR VALUES (17, 15);
INSERT INTO EXAMEN_PROFESOR VALUES (17, 16);

-- Para el examen 18
INSERT INTO EXAMEN_PROFESOR VALUES (18, 17);
INSERT INTO EXAMEN_PROFESOR VALUES (18, 18);

-- Para el examen 19
INSERT INTO EXAMEN_PROFESOR VALUES (19, 19);
INSERT INTO EXAMEN_PROFESOR VALUES (19, 20);
INSERT INTO EXAMEN_PROFESOR VALUES (19, 21);
INSERT INTO EXAMEN_PROFESOR VALUES (19, 22);

-- Para el examen 20
INSERT INTO EXAMEN_PROFESOR VALUES (20, 23);
INSERT INTO EXAMEN_PROFESOR VALUES (20, 24);
INSERT INTO EXAMEN_PROFESOR VALUES (20, 25);
INSERT INTO EXAMEN_PROFESOR VALUES (20, 26);
-- Para el examen 21
INSERT INTO EXAMEN_PROFESOR VALUES (21, 27);
INSERT INTO EXAMEN_PROFESOR VALUES (21, 28);
INSERT INTO EXAMEN_PROFESOR VALUES (21, 29);

-- Para el examen 22
INSERT INTO EXAMEN_PROFESOR VALUES (22, 30);
INSERT INTO EXAMEN_PROFESOR VALUES (22, 31);
INSERT INTO EXAMEN_PROFESOR VALUES (22, 32);
INSERT INTO EXAMEN_PROFESOR VALUES (22, 33);

-- Para el examen 23
INSERT INTO EXAMEN_PROFESOR VALUES (23, 34);
INSERT INTO EXAMEN_PROFESOR VALUES (23, 35);
INSERT INTO EXAMEN_PROFESOR VALUES (23, 36);
INSERT INTO EXAMEN_PROFESOR VALUES (23, 37);

-- Para el examen 24
INSERT INTO EXAMEN_PROFESOR VALUES (24, 38);
INSERT INTO EXAMEN_PROFESOR VALUES (24, 39);
INSERT INTO EXAMEN_PROFESOR VALUES (24, 40);

-- Para el examen 25
INSERT INTO EXAMEN_PROFESOR VALUES (25, 1);
INSERT INTO EXAMEN_PROFESOR VALUES (25, 2);
INSERT INTO EXAMEN_PROFESOR VALUES (25, 3);
INSERT INTO EXAMEN_PROFESOR VALUES (25, 4);

-- Para el examen 26
INSERT INTO EXAMEN_PROFESOR VALUES (26, 5);
INSERT INTO EXAMEN_PROFESOR VALUES (26, 6);
INSERT INTO EXAMEN_PROFESOR VALUES (26, 7);
INSERT INTO EXAMEN_PROFESOR VALUES (26, 8);
-- Para el examen 27
INSERT INTO EXAMEN_PROFESOR VALUES (27, 9);
INSERT INTO EXAMEN_PROFESOR VALUES (27, 14);
INSERT INTO EXAMEN_PROFESOR VALUES (27, 18);

-- Para el examen 28
INSERT INTO EXAMEN_PROFESOR VALUES (28, 10);
INSERT INTO EXAMEN_PROFESOR VALUES (28, 15);
INSERT INTO EXAMEN_PROFESOR VALUES (28, 19);

-- Para el examen 29
INSERT INTO EXAMEN_PROFESOR VALUES (29, 11);
INSERT INTO EXAMEN_PROFESOR VALUES (29, 16);
INSERT INTO EXAMEN_PROFESOR VALUES (29, 20);

-- Para el examen 30
INSERT INTO EXAMEN_PROFESOR VALUES (30, 12);
INSERT INTO EXAMEN_PROFESOR VALUES (30, 17);
INSERT INTO EXAMEN_PROFESOR VALUES (30, 21);

-- Para el examen 31
INSERT INTO EXAMEN_PROFESOR VALUES (31, 13);
INSERT INTO EXAMEN_PROFESOR VALUES (31, 18);
INSERT INTO EXAMEN_PROFESOR VALUES (31, 22);

-- Para el examen 32
INSERT INTO EXAMEN_PROFESOR VALUES (32, 14);
INSERT INTO EXAMEN_PROFESOR VALUES (32, 19);
INSERT INTO EXAMEN_PROFESOR VALUES (32, 23);

-- Para el examen 33
INSERT INTO EXAMEN_PROFESOR VALUES (33, 15);
INSERT INTO EXAMEN_PROFESOR VALUES (33, 20);
INSERT INTO EXAMEN_PROFESOR VALUES (33, 24);

-- Para el examen 34
INSERT INTO EXAMEN_PROFESOR VALUES (34, 16);
INSERT INTO EXAMEN_PROFESOR VALUES (34, 21);
INSERT INTO EXAMEN_PROFESOR VALUES (34, 25);

-- Para el examen 35
INSERT INTO EXAMEN_PROFESOR VALUES (35, 17);
INSERT INTO EXAMEN_PROFESOR VALUES (35, 22);
INSERT INTO EXAMEN_PROFESOR VALUES (35, 26);



-- Para el examen 36
INSERT INTO EXAMEN_PROFESOR VALUES (36, 18);
INSERT INTO EXAMEN_PROFESOR VALUES (36, 23);
INSERT INTO EXAMEN_PROFESOR VALUES (36, 27);

-- Para el examen 37
INSERT INTO EXAMEN_PROFESOR VALUES (37, 19);
INSERT INTO EXAMEN_PROFESOR VALUES (37, 24);
INSERT INTO EXAMEN_PROFESOR VALUES (37, 28);

-- Para el examen 38
INSERT INTO EXAMEN_PROFESOR VALUES (38, 20);
INSERT INTO EXAMEN_PROFESOR VALUES (38, 25);
INSERT INTO EXAMEN_PROFESOR VALUES (38, 29);

-- Para el examen 39
INSERT INTO EXAMEN_PROFESOR VALUES (39, 21);
INSERT INTO EXAMEN_PROFESOR VALUES (39, 26);
INSERT INTO EXAMEN_PROFESOR VALUES (39, 30);

-- Para el examen 40
INSERT INTO EXAMEN_PROFESOR VALUES (40, 22);
INSERT INTO EXAMEN_PROFESOR VALUES (40, 27);
INSERT INTO EXAMEN_PROFESOR VALUES (40, 31);



alter table RESPUESTA MODIFy ID_RESPUESTA VARCHAR(20);
alter table RESPUESTA modify CORRECTA null ;

COMMIT;


CREATE SEQUENCE seq_estudiante START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tr_estudiante
BEFORE INSERT ON estudiante
FOR EACH ROW
BEGIN
    SELECT seq_estudiante.nextval INTO :new.id_documento FROM dual;
END;

COMMIT;
