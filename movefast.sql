-- Tabla de clientes 
CREATE TABLE cliente (
    cliente_id SERIAL,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL, 
    cedula INTEGER UNIQUE NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY(cliente_id)
);

-- Tabla de sucursales 
CREATE TABLE sucursal (
    sucursal_id SERIAL,
    nombre VARCHAR(250) NOT NULL, 
    ciudad VARCHAR(200) NOT NULL,
    direccion VARCHAR(256) NOT NULL,
    CONSTRAINT pk_sucursal PRIMARY KEY(sucursal_id)
);

-- Tabla de vehículos
CREATE TABLE vehiculo (
    placa VARCHAR(6),
    sucursal_id INT,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    anio INT CHECK (anio >= 2000 AND anio <= 2025),
    disponible BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT pk_vehiculo PRIMARY KEY(placa),
    CONSTRAINT fk_vehiculo_sucursal FOREIGN KEY (sucursal_id) 
        REFERENCES sucursal(sucursal_id)  SET NULL ON UPDATE CASCADE
);

-- Tabla de alquileres
CREATE TABLE alquiler (
    alquiler_id SERIAL,
    cliente_id INT NOT NULL,
    vehiculo_placa VARCHAR(15) NOT NULL,
    fecha_inicio DATE DEFAULT CURRENT_DATE,
    fecha_fin DATE NOT NULL CHECK(fecha_fin >= fecha_inicio),
    CONSTRAINT pk_alquiler PRIMARY KEY(alquiler_id),
    CONSTRAINT fk_alquiler_cliente FOREIGN KEY (cliente_id) 
        REFERENCES cliente(cliente_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_alquiler_vehiculo FOREIGN KEY (vehiculo_placa) 
        REFERENCES vehiculo(placa) ON UPDATE CASCADE
);

-- Tabla de pago
CREATE TABLE pago (
    pago_id SERIAL,
    alquiler_id INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    valor DECIMAL(10, 2) NOT NULL,
    metodo VARCHAR(100) NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY(pago_id),
    CONSTRAINT fk_pago_alquiler FOREIGN KEY (alquiler_id) 
        REFERENCES alquiler(alquiler_id) ON DELETE CASCADE ON UPDATE CASCADE
);


--Insertar Datos
INSERT INTO cliente (nombre, correo, telefono, cedula) 
VALUES ('Juan Rincón', 'juanrin@mail.com', '3012345678', 123456789),
       ('Natalia Portman', 'nata@mail.com', '3209876543', 987654321);
INSERT INTO sucursal (nombre, ciudad, direccion) 
VALUES ('Sucursal Univalle', 'Cali', 'Calle 18N #81-09'),
       ('Sucursal Oriental', 'Medellin', 'Carrera 17 #12-34');
INSERT INTO vehiculo (placa, sucursal_id, marca, modelo, anio) 
VALUES ('ABC123', 1, 'Audi', 'Tron', 2020),
       ('XYZ789', 2, 'Ferrari', 'F40', 2023);
INSERT INTO alquiler (cliente_id, vehiculo_placa, fecha_inicio, fecha_fin) 
VALUES (6, 'ABC123', '2025-01-10', '2025-01-15');
INSERT INTO pago (alquiler_id, valor, metodo) 
VALUES (1, 300000.00, 'Tarjeta de crédito');

--Datos que violan restricciones
-- Violación de CHECK: Año del vehículo fuera de rango
INSERT INTO vehiculo (placa, sucursal_id, marca, modelo, anio) 
VALUES ('FLP948', 1, 'Honda', 'Civic', 1999);
-- Violación de NOT NULL: teléfono nulo
INSERT INTO cliente (nombre, correo, telefono, cedula) 
VALUES ('Laura Mora', 'laura@mail.com', NULL, 456789123);
-- Violación de FOREIGN KEY: Sucursal inexistente
INSERT INTO vehiculo (placa, sucursal_id, marca, modelo, anio) 
VALUES ('BAD001', 99, 'Renault', 'Logan', 2021);


--Pruebas para ON DELETE CASCADE
SELECT * FROM alquiler WHERE alquiler_id = 1;
DELETE FROM cliente
WHERE cliente_id = 1;

-- El alquiler asociado debe haber sido eliminado
SELECT * FROM alquiler WHERE alquiler_id = 1;

-- El pago también debe haber sido eliminado
SELECT * FROM pago WHERE alquiler_id = 1;

-- Pruebas para ON UPDATE CASCADE
SELECT * FROM vehiculo WHERE placa = 'ABC123';
UPDATE vehiculo
SET placa = 'OLA456'
WHERE placa = 'ABC123';

SELECT * FROM alquiler WHERE alquiler_id = 1;
-- Debe mostrar vehiculo_placa = 'DEF456'


