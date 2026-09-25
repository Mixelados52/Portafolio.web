CREATE DATABASE Hospital_DB;
USE Hospital_DB;
-- Parte 1: Creación de tablas principales
CREATE TABLE Persona (
    Clave INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

CREATE TABLE Personal (
    Clave INT PRIMARY KEY,
    num_emp INT UNIQUE,
    carrera VARCHAR(100),
    sueldo DECIMAL(10,2),
    FOREIGN KEY (Clave) REFERENCES Persona(Clave)
);

CREATE TABLE Paciente (
    Clave INT PRIMARY KEY,
    num_registro INT UNIQUE,
    peso DECIMAL(5,2),
    altura DECIMAL(5,2),
    glucosa DECIMAL(5,2),
    edad INT,
    tipo_sangre VARCHAR(5),
    sexo VARCHAR(15),
    FOREIGN KEY (Clave) REFERENCES Persona(Clave),
    CHECK (peso > 0),
    CHECK (altura > 0)
);

CREATE TABLE Salas (
    nombre VARCHAR(50) PRIMARY KEY,
    cant_camas INT
);

CREATE TABLE Especialidades (
    id_especialidad INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion VARCHAR(100)
);

CREATE TABLE Medico (
    id_medico INT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(100)
);

CREATE TABLE Tratamiento (
    id_tratamiento INT PRIMARY KEY,
    nombre VARCHAR(100),
    costo DECIMAL(10,2)
);

CREATE TABLE Medicamento (
    id_medicamento INT PRIMARY KEY,
    nombre VARCHAR(100),
    laboratorio VARCHAR(100),
    precio DECIMAL(10,2)
);

-- Parte 2: Tablas relacionadas

CREATE TABLE Trabajan (
    Clave INT,
    nombre VARCHAR(50),
    PRIMARY KEY (Clave,nombre),
    FOREIGN KEY (Clave) REFERENCES Personal(Clave),
    FOREIGN KEY (nombre) REFERENCES Salas(nombre)
);

CREATE TABLE Ingresa (
    Clave INT,
    nombre VARCHAR(50),
    PRIMARY KEY (Clave,nombre),
    FOREIGN KEY (Clave) REFERENCES Paciente(Clave),
    FOREIGN KEY (nombre) REFERENCES Salas(nombre)
);

CREATE TABLE Enfermero (
    id_enfermero INT PRIMARY KEY,
    Clave INT,
    turno VARCHAR(20),
    FOREIGN KEY (Clave) REFERENCES Personal(Clave)
);

CREATE TABLE Consulta (
    id_consulta INT PRIMARY KEY,
    fecha DATE,
    diagnostico VARCHAR(200),
    Clave_paciente INT,
    id_medico INT,
    FOREIGN KEY (Clave_paciente) REFERENCES Paciente(Clave),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);

CREATE TABLE Receta (
    id_receta INT PRIMARY KEY,
    id_consulta INT,
    id_medicamento INT,
    dosis VARCHAR(100),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);

CREATE TABLE Paciente_Tratamiento (
    Clave INT,
    id_tratamiento INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    PRIMARY KEY (Clave,id_tratamiento),
    FOREIGN KEY (Clave) REFERENCES Paciente(Clave),
    FOREIGN KEY (id_tratamiento) REFERENCES Tratamiento(id_tratamiento)
);

CREATE TABLE Citas (
    id_cita INT PRIMARY KEY,
    fecha DATE,
    Clave_paciente INT,
    id_medico INT,
    hora TIME,
    motivo VARCHAR(200),
    estado VARCHAR(30),
    FOREIGN KEY (Clave_paciente) REFERENCES Paciente(Clave),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);

-- Parte 3: Tablas adicionales del hospital
CREATE TABLE Expediente (
    id_expediente INT PRIMARY KEY,
    Clave_paciente INT,
    fecha_creacion DATE,
    antecedentes TEXT,
    alergias TEXT,
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave)
);

CREATE TABLE Estudio_Laboratorio (
    id_estudio INT PRIMARY KEY,
    nombre VARCHAR(100),
    costo DECIMAL(10,2)
);

CREATE TABLE Resultado_Laboratorio (
    id_resultado INT PRIMARY KEY,
    id_estudio INT,
    Clave_paciente INT,
    fecha DATE,
    resultado TEXT,
    FOREIGN KEY (id_estudio)
    REFERENCES Estudio_Laboratorio(id_estudio),
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave)
);

CREATE TABLE Hospitalizacion (
    id_hospitalizacion INT PRIMARY KEY,
    Clave_paciente INT,
    nombre_sala VARCHAR(50),
    fecha_ingreso DATE,
    fecha_salida DATE,
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave),
    FOREIGN KEY (nombre_sala)
    REFERENCES Salas(nombre)
);

CREATE TABLE Factura (
    id_factura INT PRIMARY KEY,
    Clave_paciente INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave)
);

CREATE TABLE Detalle_Factura (
    id_detalle INT PRIMARY KEY,
    id_factura INT,
    concepto VARCHAR(150),
    importe DECIMAL(10,2),
    FOREIGN KEY (id_factura)
    REFERENCES Factura(id_factura)
);

CREATE TABLE Ambulancia (
    id_ambulancia INT PRIMARY KEY,
    placas VARCHAR(20),
    modelo VARCHAR(50),
    estado VARCHAR(50)
);

CREATE TABLE Servicio_Ambulancia (
    id_servicio INT PRIMARY KEY,
    id_ambulancia INT,
    Clave_paciente INT,
    fecha DATE,
    origen VARCHAR(100),
    destino VARCHAR(100),
    FOREIGN KEY (id_ambulancia)
    REFERENCES Ambulancia(id_ambulancia),
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave)
);

CREATE TABLE Pago (
    id_pago INT PRIMARY KEY,
    id_factura INT,
    fecha_pago DATE,
    metodo_pago VARCHAR(50),
    monto DECIMAL(10,2),
    FOREIGN KEY (id_factura)
    REFERENCES Factura(id_factura)
);

CREATE TABLE Cama (
    id_cama INT PRIMARY KEY,
    sala VARCHAR(50),
    estado VARCHAR(20),
    FOREIGN KEY (sala)
    REFERENCES Salas(nombre)
);

CREATE TABLE Historial_Tratamientos (
    id_historial INT PRIMARY KEY,
    Clave_paciente INT,
    id_tratamiento INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    observaciones TEXT,
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave),
    FOREIGN KEY (id_tratamiento)
    REFERENCES Tratamiento(id_tratamiento)
);

CREATE TABLE Emergencias (
    id_emergencia INT PRIMARY KEY,
    Clave_paciente INT,
    id_medico INT,
    fecha_ingreso DATETIME,
    nivel_urgencia VARCHAR(20),
    motivo VARCHAR(200),
    estado VARCHAR(50),
    FOREIGN KEY (Clave_paciente)
    REFERENCES Paciente(Clave),
    FOREIGN KEY (id_medico)
    REFERENCES Medico(id_medico)
);

CREATE TABLE Inventario_Medicamentos(
    id_medicamento INT PRIMARY KEY,
    existencia INT,
    FOREIGN KEY(id_medicamento)
    REFERENCES Medicamento(id_medicamento)
);

-- Parte 4: Alter, procedimiento, vista e inserts

ALTER TABLE Medico
ADD id_departamento INT,
ADD FOREIGN KEY (id_departamento)
REFERENCES Departamento(id_departamento);

ALTER TABLE Medico
ADD id_especialidad INT,
ADD FOREIGN KEY (id_especialidad)
REFERENCES Especialidades(id_especialidad);

ALTER TABLE Personal
ADD id_departamento INT,
ADD FOREIGN KEY (id_departamento)
REFERENCES Departamento(id_departamento);
-- INSERT
-- 1. Departamentos
INSERT INTO Departamento VALUES
(1,'Cardiología','Piso 1'),
(2,'Pediatría','Piso 2'),
(3,'Urgencias','Planta Baja');
-- 2. Especialidades
INSERT INTO Especialidades VALUES
(1,'Cardiología'),
(2,'Pediatría'),
(3,'Traumatología'),
(4,'Neurología'),
(5,'Medicina General');
-- 3. Personas
INSERT INTO Persona
(Clave,nombre,direccion,telefono)
VALUES
(1,'Juan Perez','León','4771111111'),
(2,'Ana Lopez','León','4772222222'),
(3,'Carlos Ruiz','León','4773333333'),
(4,'Luis Gomez','León','444444'),
(5,'Pedro Medina','León','4775555555'),
(6,'Sandra Torres','León','4776666666'),
(7,'Mario Díaz','León','4777777777');
-- 4. Personal
INSERT INTO Personal
(Clave,num_emp,carrera,sueldo,id_departamento)
VALUES
(1,1001,'Medicina',15000,1),
(5,1002,'Enfermería',12000,2),
(6,1003,'Enfermería',12500,2),
(7,1004,'Administración',14000,3);
-- 5. Pacientes
INSERT INTO Paciente
(Clave,num_registro,peso,altura,glucosa,edad,tipo_sangre,sexo)
VALUES
(2,2001,70,1.70,90,25,'O+','Femenino'),
(3,2002,80,1.75,110,25,'O+','Masculino'),
(4,2003,65,1.60,85,25,'O+','Masculino');
-- 6. Médicos
INSERT INTO Medico
(id_medico, nombre, especialidad, id_departamento, id_especialidad)
VALUES
(1, 'Roberto Morales', 'Cardiólogo', 1, 1),
(2, 'Marta Díaz', 'Pediatra', 2, 2),
(3, 'Luis Herrera', 'Traumatólogo', 3, 3),
(4, 'Sandra López', 'Neuróloga', 1, 4),
(5, 'Pedro Vega', 'Médico General', 3, 5);
-- 7. Salas
INSERT INTO Salas VALUES
('Urgencias',10),
('Quirófano',5);
-- 8. Trabajan
INSERT INTO Trabajan VALUES
(1,'Urgencias');
-- 9.Ingresa
INSERT INTO Ingresa VALUES
(2,'Urgencias'),
(3,'Quirófano');
-- 10. Enfermeros
INSERT INTO Enfermero VALUES
(1,5,'Matutino'),
(2,6,'Nocturno');
-- 11. Tratamientos
INSERT INTO Tratamiento VALUES
(1,'Terapia Física',1500),
(2,'Control Diabetes',1000),
(3,'Rehabilitación',2500),
(4,'Control Cardiaco',3000);
-- 12. Consultas
INSERT INTO Consulta VALUES
(1,'2025-01-10','Hipertensión',2,1),
(2,'2025-01-15','Gripe',3,5),
(3,'2025-01-20','Fractura de brazo',4,3);
-- 13. Medicamentos
INSERT INTO Medicamento VALUES
(1,'Paracetamol','Pfizer',120),
(2,'Metformina','Bayer',350),
(3,'Ibuprofeno','Sanofi',90),
(4,'Aspirina','Bayer',100);
-- 14. Recetas
INSERT INTO Receta VALUES
(1,1,4,'1 tableta cada 8 horas'),
(2,2,1,'1 tableta cada 12 horas'),
(3,3,3,'1 tableta cada 8 horas');
-- 15. Paciente_Tratamiento
INSERT INTO Paciente_Tratamiento VALUES
(2,4,'2025-01-10','2025-06-10'),
(3,2,'2025-01-15','2025-07-15'),
(4,1,'2025-01-20','2025-03-20');
-- 16. Citas
INSERT INTO Citas
(id_cita,fecha,Clave_paciente,id_medico,hora,motivo,estado)
VALUES
(1,'2025-08-01',2,1,'09:00:00',
'Chequeo cardiológico','Programada'),

(2,'2025-08-02',3,5,'11:30:00',
'Consulta general','Programada');
-- 17. Expedientes
INSERT INTO Expediente
(id_expediente, Clave_paciente, fecha_creacion, antecedentes, alergias)
VALUES
(1, 2, '2025-01-10', 'Hipertensión arterial', 'Penicilina'),
(2, 3, '2025-01-15', 'Diabetes Tipo 2', 'Ninguna'),
(3, 4, '2025-01-20', 'Fractura de brazo', 'Ninguna');
-- 18. Estudios de Laboratorio
INSERT INTO Estudio_Laboratorio VALUES
(1,'Biometría Hemática',350),
(2,'Química Sanguínea',500),
(3,'Glucosa',200);
-- 19. Resultados de Laboratorio
INSERT INTO Resultado_Laboratorio VALUES
(1,1,2,'2025-01-11','Resultados normales'),
(2,3,3,'2025-01-16','Glucosa elevada'),
(3,2,4,'2025-01-21','Sin alteraciones');
-- 20. Hospitalización
INSERT INTO Hospitalizacion VALUES
(1,2,'Urgencias','2025-01-10','2025-01-15'),
(2,3,'Quirófano','2025-01-20','2025-01-25');
-- 21. Facturas
INSERT INTO Factura VALUES
(1,2,'2025-01-15',5000),
(2,3,'2025-01-25',3500);
-- 22. Detalle Factura
INSERT INTO Detalle_Factura VALUES
(1,1,'Consulta Cardiológica',1500),
(2,1,'Medicamentos',3500),
(3,2,'Tratamiento',3500);
-- 23. Ambulancias
INSERT INTO Ambulancia
(id_ambulancia, placas, modelo, estado)
VALUES
(1, 'GTO123A', 'Ford Transit', 'Disponible'),
(2, 'GTO456B', 'Mercedes Sprinter', 'En servicio');
-- 24. Servicios de Ambulancia
INSERT INTO Servicio_Ambulancia VALUES
(1,1,2,'2025-02-01',
'León Centro',
'Hospital General'),

(2,2,3,'2025-02-05',
'Silao',
'Hospital General');
-- 25. Pagos
INSERT INTO Pago VALUES
(1,1,'2025-01-16','Tarjeta',5000),
(2,2,'2025-01-26','Efectivo',3500);
-- 26. Camas
INSERT INTO Cama VALUES
(1,'Urgencias','Ocupada'),
(2,'Urgencias','Disponible'),
(3,'Quirófano','Disponible'),
(4,'Quirófano','Ocupada');
-- 27. Historial de Tratamientos
INSERT INTO Historial_Tratamientos VALUES
(1,2,4,'2025-01-10','2025-06-10',
'Paciente responde favorablemente al tratamiento.'),

(2,3,2,'2025-01-15','2025-07-15',
'Control periódico de glucosa'),

(3,4,1,'2025-01-20','2025-03-20',
'Rehabilitación satisfactoria');
-- 28. Emergencias
INSERT INTO Emergencias
(id_emergencia,Clave_paciente,id_medico,
fecha_ingreso,nivel_urgencia,motivo,estado)
VALUES
(1,2,1,
'2025-05-01 14:30:00',
'Alta',
'Infarto agudo',
'Estabilizado'),

(2,3,3,
'2025-04-05 20:15:00',
'Media',
'Fractura de brazo',
'En observación');
-- 29. Inventario de Medicamentos
INSERT INTO Inventario_Medicamentos VALUES
(1,150),
(2,80),
(3,120),
(4,60);
-- 30. Actualizar Departamentos en Médicos
UPDATE Medico SET id_departamento=1 WHERE id_medico=1;
UPDATE Medico SET id_departamento=2 WHERE id_medico=2;
UPDATE Medico SET id_departamento=3 WHERE id_medico=3;
UPDATE Medico SET id_departamento=1 WHERE id_medico=4;
UPDATE Medico SET id_departamento=3 WHERE id_medico=5;
-- 31. Actualizar Departamentos en Personal
UPDATE Personal SET id_departamento=1 WHERE Clave=1;
UPDATE Personal SET id_departamento=2 WHERE Clave=5;
UPDATE Personal SET id_departamento=2 WHERE Clave=6;
UPDATE Personal SET id_departamento=3 WHERE Clave=7;
-- 32. Correos
UPDATE Persona SET correo='juan@hospital.com' WHERE Clave=1;
UPDATE Persona SET correo='ana@hospital.com' WHERE Clave=2;
UPDATE Persona SET correo='carlos@hospital.com' WHERE Clave=3;
UPDATE Persona SET correo='luis@hospital.com' WHERE Clave=4;
UPDATE Persona SET correo='pedro@hospital.com' WHERE Clave=5;
UPDATE Persona SET correo='sandra@hospital.com' WHERE Clave=6;
UPDATE Persona SET correo='mario@hospital.com' WHERE Clave=7;

Describe Personal;


SELECT * FROM Persona;
SELECT * FROM Personal;
SELECT * FROM Paciente;
SELECT * FROM Salas;
SELECT * FROM Trabajan;
SELECT * FROM Ingresa;
SELECT * FROM Especialidades;
SELECT * FROM Enfermero;
SELECT * FROM Medico;
SELECT * FROM Tratamiento;
SELECT * FROM Consulta;
SELECT * FROM Medicamento;
SELECT * FROM Receta;
SELECT * FROM Paciente_Tratamiento;
SELECT * FROM Citas;
SELECT * FROM Departamento;
SELECT * FROM Expediente;
SELECT * FROM Estudio_Laboratorio;
SELECT * FROM Resultado_Laboratorio;
SELECT * FROM Hospitalizacion;
SELECT * FROM Factura;
SELECT * FROM Detalle_Factura;
SELECT * FROM Ambulancia;
SELECT * FROM Servicio_Ambulancia;
SELECT * FROM Pago;
SELECT * FROM Cama;
SELECT * FROM Historial_Tratamientos;
SELECT * FROM Emergencias;
SELECT * FROM Inventario_Medicamentos;



-- iNSERTAR LOS CORREOS EN LA TABLA PERSONA
UPDATE Persona
SET correo='juan@hospital.com'
WHERE Clave=1;

UPDATE Persona
SET correo='ana@hospital.com'
WHERE Clave=2;

UPDATE Persona
SET correo='carlos@hospital.com'
WHERE Clave=3;

UPDATE Persona
SET correo='luis@hospital.com'
WHERE Clave=4;

UPDATE Persona
SET correo='pedro@hospital.com'
WHERE Clave=5;

UPDATE Persona
SET correo='sandra@hospital.com'
WHERE Clave=6;

UPDATE Persona
SET correo='mario@hospital.com'
WHERE Clave=7;

SELECT p.Clave, pe.nombre, p.peso, p.altura
 
FROM Paciente p
Join Persona pe
ON p.Clave = pe.Clave;
 
SELECT p.Clave, pe.nombre, p.carrera, p.sueldo
 
FROM Personal p
join persona pe
on p.clave = pe.Clave;
 
SELECT e.id_enfermero, pe.nombre, e.turno
FROM Enfermero e
JOIN Personal p
ON e.Clave = p.Clave
JOIN Persona pe
ON p.Clave = pe.Clave;
 
SELECT pa.Clave, pe.nombre, i.nombre
 
FROM Paciente pa
JOIN Persona pe
ON pa.Clave = pe.Clave
JOIN Ingresa i
ON pa.Clave = i.Clave;
