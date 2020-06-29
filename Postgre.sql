---Tabla Profesion
create table Profesion(
	cod_profesion serial primary key,
	nombre varchar(50) not null
);

---Tabla Pais
create table Pais(
	cod_pais serial primary key,
	nombre varchar(50) not null UNIQUE
);
CREATE UNIQUE INDEX u_name on Pais(Nombre);

---Tabla Miembro
create table Miembro(
	cod_miembro serial primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	edad real not null, 
	telefono varchar(30),
	residencia varchar(100),
	cod_profesion serial not null,
	cod_pais serial not null,
	FOREIGN KEY (cod_profesion) REFERENCES Profesion(cod_profesion),
	FOREIGN KEY (cod_pais) REFERENCES Pais(cod_pais)
);

---Tabla Puesto
create table Puesto(
	cod_puesto serial primary key,
	nombre varchar(50) not null
);

---Tabla Departamento
create table Departamento(
	cod_depto serial primary key,
	nombre varchar(50) not null UNIQUE
);
CREATE UNIQUE INDEX u_nombre on Departamento(nombre);


---Tabla Puesto_miembro
create table Puesto_miembro(
	fecha_inicio date not null,
	fecha_fin date,
	cod_depto serial not null,
	cod_puesto serial not null,
	cod_miembro serial not null,
	FOREIGN KEY (cod_depto) REFERENCES Departamento(cod_depto),
	FOREIGN KEY (cod_puesto) REFERENCES Puesto(cod_puesto),
	FOREIGN KEY (cod_miembro) REFERENCES Miembro(cod_miembro)
);

---Tabla Tipo_medalla
create table Tipo_medalla(
	cod_tipo serial primary key,
	medalla varchar(50) not null
);
CREATE UNIQUE INDEX u_medalla on Tipo_medalla(medalla);


---Tabla Medallero
create table Medallero(
	cantidad_medallas numeric not null,
	cod_pais serial not null,
	cod_tipo serial not null,
	FOREIGN KEY (cod_pais) REFERENCES Pais(cod_pais),
	FOREIGN KEY (cod_tipo) REFERENCES Tipo_medalla(cod_tipo)
);

---Tabla Disciplina
create table Disciplina(
	cod_disciplina serial primary key,
	nombre varchar(50) not null,
	descripcion varchar(150) not null
);

---Tabla Atleta
create table Atleta(
	cod_atleta serial primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	edad real not null,
	participaciones real not null,
	cod_disciplina serial not null,
	cod_pais serial not null,
	FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina),
	FOREIGN KEY (cod_pais) REFERENCES Pais(cod_pais)
);

---Tabla Categoria
create table Categoria(
	cod_categoria serial primary key,
	categoria varchar(50) not null
);

---Tabla Tipo_Participacion
create table Tipo_participacion(
	cod_participacion serial primary key,
	tipo_participacion varchar(20) not null
);

---Tabla evento
create table Evento(
	cod_evento serial primary key,
	fecha date not null,
	ubicacion varchar(50) not null,
	cod_disciplina serial not null,
	cod_participacion serial not null,
	cod_categoria serial not null,
	FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina),
	FOREIGN KEY (cod_participacion) REFERENCES Tipo_participacion(cod_participacion),
	FOREIGN KEY (cod_categoria) REFERENCES Categoria(cod_categoria)
);

---Tabla Evento_atleta
create table Evento_atleta(
	cod_atleta serial not null,
	cod_evento serial not null,
	FOREIGN KEY (cod_atleta) REFERENCES Atleta(cod_atleta),
	FOREIGN KEY (cod_evento) REFERENCES Evento(cod_evento)
);

---Tabla Televisora
create table Televisora(
	cod_televisora serial primary key,
	nombre varchar(50) not null
);

---Tabla Costo_evento
create table Costo_evento(
	tarifa decimal not null,
	cod_televisora serial not null,
	cod_evento serial not null,
	FOREIGN KEY (cod_televisora) REFERENCES Televisora(cod_televisora),
	FOREIGN KEY (cod_evento) REFERENCES Evento(cod_evento)
);

select * from Evento;

---Manejando fecha y hora en lugar de hora.
ALTER TABLE Evento ALTER COLUMN fecha SET DATA TYPE timestamp;
ALTER TABLE Evento RENAME COLUMN fecha TO fecha_hora;

---Añadiendo rango para la fecha
alter table Evento
add constraint CK_rango_fecha_hora
check (fecha_hora>='2020-07-24 09:00:00'and fecha_hora<='2020-08-09 20:00:00');

--Tabla Sede
create table Sede(
	codigo numeric primary key,
	sede varchar(50) not null
);

ALTER TABLE Evento 
ALTER COLUMN ubicacion 
SET DATA TYPE numeric 
using ubicacion::numeric;

ALTER TABLE Evento
ADD CONSTRAINT fk_sede_ubicacion
FOREIGN KEY (ubicacion)
REFERENCES Sede(codigo);

---Añadir un cero por defecto en el telefono.
ALTER TABLE Miembro
ALTER COLUMN telefono
SET DEFAULT('0');

---Insertar valores en las tablas.
INSERT INTO Pais values (1,'Guatemala');
INSERT INTO Pais values (2,'Francia');
INSERT INTO Pais values (3,'Argentina');
INSERT INTO Pais values (4,'Alemania');
INSERT INTO Pais values (5,'Italia');
INSERT INTO Pais values (6,'Brasil');
INSERT INTO Pais values (7,'Estados Unidos');
SELECT * FROM Pais;

INSERT INTO Profesion values (1,'Médico');
INSERT INTO Profesion values (2,'Arquitecto');
INSERT INTO Profesion values (3,'Ingeniero');
INSERT INTO Profesion values (4,'Secretaria');
INSERT INTO Profesion values (5,'Auditor');
SELECT * FROM Profesion;

INSERT INTO Miembro values (1,'Scott','Mitchel',32,default,'1092 Highland Drive Manitowoc, WI 54220',3,7);
INSERT INTO Miembro values (2,'Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY',4,2);
INSERT INTO Miembro values (3,'Laura','Cunha Silva',55,default,'Rua Onze, 86 Uberaba-MG',5,6);
INSERT INTO Miembro values (4,'Juan José','López',38,36985247,'26 calle 4-10 zona 11',2,1);
INSERT INTO Miembro values (5,'Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 114 90010-Geraci Siculo PA',1,5);
INSERT INTO Miembro values (6,'Jeuel','Villalpando',31,default,'Acuña de Figeroa 6106 80101 Playa Pascual',5,3);
SELECT * FROM Miembro;

INSERT INTO Disciplina values (1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.');
INSERT INTO Disciplina values (2,'Badminton','');
INSERT INTO Disciplina values (3,'Ciclismo','');
INSERT INTO Disciplina values (4,'Judo','Es un arte marcial que se originó en Japón alrededor de 1880');
INSERT INTO Disciplina values (5,'Lucha','');
INSERT INTO Disciplina values (6,'Tenis de mesa','');
INSERT INTO Disciplina values (7,'Boxeo','');
INSERT INTO Disciplina values (8,'Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
INSERT INTO Disciplina values (9,'Esgrima','');
INSERT INTO Disciplina values (10,'Vela','');
SELECT * FROM Disciplina;

INSERT INTO Tipo_medalla values (1,'Oro');
INSERT INTO Tipo_medalla values (2,'Plata');
INSERT INTO Tipo_medalla values (3,'Bronce');
INSERT INTO Tipo_medalla values (4,'Platino');
SELECT * FROM Tipo_medalla;

INSERT INTO Categoria values (1,'Clasificatorio');
INSERT INTO Categoria values (2,'Eliminatorio');
INSERT INTO Categoria values (3,'Final');
SELECT * FROM Categoria;

INSERT INTO Tipo_participacion values (1,'Individual');
INSERT INTO Tipo_participacion values (2,'Parejas');
INSERT INTO Tipo_participacion values (3,'Equipos');
SELECT * FROM Tipo_participacion;

INSERT INTO Medallero values (3,5,1);
INSERT INTO Medallero values (5,2,1);
INSERT INTO Medallero values (4,6,3);
INSERT INTO Medallero values (3,4,4);
INSERT INTO Medallero values (10,7,3);
INSERT INTO Medallero values (8,3,2);
INSERT INTO Medallero values (2,1,1);
INSERT INTO Medallero values (5,1,4);
INSERT INTO Medallero values (7,5,2);
SELECT * FROM Medallero;

INSERT INTO Sede values(1,'Gimnasio Metropolitano de Tokio');
INSERT INTO Sede values(2,'Jardín del Palacio Imperial de Tokio');
INSERT INTO Sede values(3,'Gimnasio Nacional Yoyogi');
INSERT INTO Sede values(4,'Nippon Budokan');
INSERT INTO Sede values(5,'Estadio Olímpico');
SELECT * FROM Sede;

INSERT INTO Evento VALUES(1,'2020-07-24 11:00:00',3,2,2,1);
INSERT INTO Evento VALUES(2,'2020-07-26 10:30:00',1,6,1,3);
INSERT INTO Evento VALUES(3,'2020-07-30 18:45:00',5,7,1,2);
INSERT INTO Evento VALUES(4,'2020-08-01 12:15:00',2,1,1,1);
INSERT INTO Evento VALUES(5,'2020-08-08 19:35:00',4,10,3,1);
SELECT * FROM Evento;

---Eliminar la restricción Unique
DROP INDEX u_medalla;
DROP INDEX u_name;
DROP INDEX u_nombre;


---Permitir que los atletas participen en varias disciplinas.
ALTER TABLE Atleta DROP CONSTRAINT atleta_cod_disciplina_fkey;

create table Disciplina_atleta(
	cod_atleta serial not null,
	cod_disciplina serial not null,
	foreign key (cod_atleta) references Atleta(cod_atleta),
	foreign key (cod_disciplina) references Disciplina(cod_disciplina)
);

---Cambiar el tipo de dato para que acepte solamente 2 decimales
ALTER TABLE Costo_evento
ALTER COLUMN tarifa
SET DATA TYPE float(2);

---Borrar el registro 4 de la tabla Tipo_medalla
DELETE FROM Medallero 
WHERE cod_tipo = 4;
DELETE FROM Tipo_medalla
WHERE cod_tipo = 4;

---Borrar Costo_evento y Televisora
drop TABLE Costo_evento;
drop TABLE Televisora;

---Borrar todos los registros de Disciplina
TRUNCATE TABLE Disciplina CASCADE;

UPDATE Miembro SET telefono=55464601 WHERE nombre='Laura' AND apellido='Cunha Silva';
UPDATE Miembro SET telefono=91514243 WHERE nombre='Jeuel' AND apellido='Villalpando';
UPDATE Miembro SET telefono=920686670 WHERE nombre='Scott' AND apellido='Mitchel';
SELECT * FROM Miembro;

---Añadir columna para fotografía
ALTER TABLE Atleta ADD COLUMN Fotografia varchar(200);

---Añadiendo rango para la edad de los atletas.
ALTER TABLE Atleta
ADD CONSTRAINT CK_rango_edad_atleta
check (edad<25);

