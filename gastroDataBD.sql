CREATE TABLE Cliente (
    id_cliente INT,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    observaciones VARCHAR(45) NOT NULL,
	CONSTRAINT pk_cliente PRIMARY KEY(id_cliente)
);

CREATE TABLE Mesero (
    id_mesero INT,
    nombre VARCHAR(45) NOT NULL,
    apellido1 VARCHAR(45) NOT NULL,
    apellido2 VARCHAR(45),
	CONSTRAINT pk_mesero PRIMARY KEY(id_mesero)
);

CREATE TABLE Platillo (
    id_platillo INT,
    nombre VARCHAR(45) NOT NULL,
    importe INT NOT NULL,
	CONSTRAINT pk_platillo PRIMARY KEY(id_platillo)
);

CREATE TABLE Bebida (
    id_bebida INT,
    nombre VARCHAR(45) NOT NULL,
    importe INT NOT NULL,
	CONSTRAINT pk_bebida PRIMARY KEY(id_bebida)
);

CREATE TABLE Mesa (
    id_mesa INT,
    num_comensales INT NOT NULL,
    ubicacion VARCHAR(45) NOT NULL,
	CONSTRAINT pk_mesa PRIMARY KEY(id_mesa)
);

CREATE TABLE Factura (
    id_factura INT,
    fecha_factura DATE,
    id_cliente INT,
    id_mesero INT,
    id_mesa INT,
    id_paltillo INT,
    id_bebida INT,
	CONSTRAINT pk_factura PRIMARY KEY(id_factura),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_mesero) REFERENCES Mesero(id_mesero) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_mesa) REFERENCES Mesa(id_mesa) ON UPDATE CASCADE ON DELETE SET NULL,
 	FOREIGN KEY (id_paltillo) REFERENCES Platillo(id_platillo) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_bebida) REFERENCES Bebida(id_bebida) ON UPDATE CASCADE ON DELETE SET NULL
);


INSERT INTO Cliente (id_cliente, nombre, apellido, observaciones) VALUES
(1, 'Manuel', 'Pedroza Gonzalez', 'Prefiere mesa en terraza'),
(2, 'Lucía', 'Restrepo Jaramillo', 'Celebración de grado'),
(3, 'Alejandro', 'Buendía Márquez', 'Cliente VIP - dueño de finca cafetera'),
(4, 'Carolina', 'Gaviria Escobar', 'Alérgica al maní'),
(5, 'Santiago', 'Betancourt Ochoa', 'Reservación para reunión de negocios');


INSERT INTO Mesero (id_mesero, nombre, apellido1, apellido2) VALUES
(1, 'Fernando', 'Quintero', 'Vargas'),
(2, 'Daniela', 'Zapata', 'Aristizábal'),
(3, 'Camilo', 'Gutiérrez', 'Monsalve'),
(4, 'Valentina', 'Londoño', 'Ramírez'),
(5, 'Andrés', 'Arboleda', 'Cardona');

INSERT INTO Platillo (id_platillo, nombre, importe) VALUES
(1, 'Bandeja Paisa', 45000),
(2, 'Ajiaco', 38000),
(3, 'Sancocho', 42000),
(4, 'Cazuela', 65000),
(5, 'Lechona', 55000),
(6, 'Mote de Queso', 36000),
(7, 'Arroz con Cocoo', 52000),
(8, 'Patacones', 25000),
(9, 'Empanadas Paisas', 18000),
(10, 'Sobrebarriga', 48000);

INSERT INTO Bebida (id_bebida, nombre, importe) VALUES
(1, 'Limonada de Coco', 12000),
(2, 'Aguardiente', 45000),
(3, 'Refajo Colombiano', 14000),
(4, 'Jugo de Lulo', 9000),
(5, 'Café Juan Valdez', 7500),
(6, 'Cerveza Club Colombia', 8500),
(7, 'Aguapanela con Queso', 6000),
(8, 'Ron Viejo', 38000),
(9, 'Champús', 11000),
(10, 'Vino Tinto', 85000);


INSERT INTO Mesa (id_mesa, num_comensales, ubicacion) VALUES
(1, 2, 'Terraza con vista al Valle'),
(2, 4, 'Interior'),
(3, 6, 'Jardín tropical'),
(10, 8, 'Segundo piso'),
(5, 2, 'Balcón privado'),
(6, 4, 'Área de música'),
(7, 10, 'Terraza cubierta'),
(8, 6, 'Salón principal');


INSERT INTO Factura (id_factura, fecha_factura, id_cliente, id_mesero, id_mesa, id_paltillo, id_bebida) VALUES
(1, '2023-10-15', 1, 2, 2, 1, 2), -- Manuel comió Bandeja Paisa con Aguardiente
(2, '2023-10-16', 2, 1, 1, 4, 1), -- Lucía comió Cazuela con Limonada de Coco
(3, '2023-10-17', 3, 3, 3, 3, 8), -- Alejandro comió Sancocho con Ron Viejo
(4, '2023-10-18', 4, 4, 10, 2, 4), -- Carolina comió Ajiaco con Jugo de Lulo
(5, '2023-10-19', 5, 5, 5, 5, 10), -- Santiago comió Lechona con Vino
(6, '2023-10-20', 1, 2, 10, 7, 3), -- Manuel regresó para Arroz con Coco y Refajo
(7, '2023-10-21', 2, 3, 2, 10, 6), -- Lucía probó Sobrebarriga con Cerveza
(8, '2023-10-22', 3, 4, 3, 6, 5), -- Alejandro comió Mote de Queso con Café
(9, '2023-10-23', 4, 5, 10, 8, 7), -- Carolina probó Patacones con Aguapanela
(10, '2023-10-24', 5, 1, 5, 9, 9), -- Santiago pidió Empanadas con Champús
(11, '2023-10-25', 1, 2, 3, 1, 2), -- Manuel otra vez con Bandeja Paisa y Aguardiente
(12, '2023-10-26', 1, 3, 7, 4, 1); -- Manuel volvió por Cazuela

-- 1. Obtener el nombre y apellido de los clientes que hayan consumido un platillo específico (ej: Bandeja Paisa)
SELECT DISTINCT c.nombre, c.apellido 
FROM Cliente c
JOIN Factura f ON c.id_cliente = f.id_cliente
WHERE f.id_paltillo = 1; -- Bandeja Paisa 

-- 2. Obtener el nombre y apellido de los clientes que hayan consumido arroz con coco
SELECT DISTINCT c.nombre, c.apellido 
FROM Cliente c
JOIN Factura f ON c.id_cliente = f.id_cliente
JOIN Platillo p ON f.id_paltillo = p.id_platillo
WHERE p.nombre = 'Arroz con Cocoo';

-- 3. Listar el nombre del mesero y la fecha en la que atendió una mesa 10 en el segundo piso
SELECT m.nombre, m.apellido1, m.apellido2, f.fecha_factura
FROM Mesero m
JOIN Factura f ON m.id_mesero = f.id_mesero
JOIN Mesa me ON f.id_mesa = me.id_mesa
WHERE me.id_mesa = 10 AND me.ubicacion = 'Segundo piso';

-- 4. Mostrar el nombre de los clientes junto con los nombres de las bebidas que consumieron
SELECT c.nombre, c.apellido, b.nombre AS bebida
FROM Cliente c
JOIN Factura f ON c.id_cliente = f.id_cliente
JOIN Bebida b ON f.id_bebida = b.id_bebida
ORDER BY c.nombre, c.apellido;

-- 5. Consultar facturas con platillos con importe mayor a $50000
SELECT f.id_factura, c.nombre, c.apellido, p.nombre AS platillo, p.importe
FROM Factura f
JOIN Cliente c ON f.id_cliente = c.id_cliente
JOIN Platillo p ON f.id_paltillo = p.id_platillo
WHERE p.importe > 50000;

-- 6. Listar el total de consumo (platillos y bebidas) de Manuel Pedroza Gonzalez
SELECT c.nombre, c.apellido, SUM(p.importe + b.importe) AS total_consumo
FROM Cliente c
JOIN Factura f ON c.id_cliente = f.id_cliente
JOIN Platillo p ON f.id_paltillo = p.id_platillo
JOIN Bebida b ON f.id_bebida = b.id_bebida
WHERE c.nombre = 'Manuel' AND c.apellido = 'Pedroza Gonzalez'
GROUP BY c.nombre, c.apellido;

-- 7. Listar mesas utilizadas al menos una vez, con ubicación y número de comensales
SELECT DISTINCT m.id_mesa, m.ubicacion, m.num_comensales
FROM Mesa m
JOIN Factura f ON m.id_mesa = f.id_mesa
ORDER BY m.id_mesa;


-- 1. Vista de consumo por cliente
CREATE VIEW Vista_Consumo_Cliente AS
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente, 
    c.apellido AS apellido_cliente,
    p.nombre AS platillo,
    b.nombre AS bebida,
    f.fecha_factura,
    p.importe AS precio_platillo,
    b.importe AS precio_bebida,
    (p.importe + b.importe) AS total_consumo
FROM 
    Cliente c
JOIN 
    Factura f ON c.id_cliente = f.id_cliente
JOIN 
    Platillo p ON f.id_paltillo = p.id_platillo
JOIN 
    Bebida b ON f.id_bebida = b.id_bebida
ORDER BY 
    c.nombre, c.apellido, f.fecha_factura;

-- 2. Vista de meseros y facturas atendidas
CREATE VIEW Vista_Mesero_Facturas AS
SELECT 
    m.id_mesero,
    m.nombre AS nombre_mesero, 
    m.apellido1, 
    m.apellido2,
    f.id_factura AS numero_factura, 
    f.fecha_factura,
    me.id_mesa,
    me.ubicacion AS ubicacion_mesa,
    me.num_comensales
FROM 
    Mesero m
JOIN 
    Factura f ON m.id_mesero = f.id_mesero
JOIN 
    Mesa me ON f.id_mesa = me.id_mesa
ORDER BY 
    m.nombre, f.fecha_factura;

-- 3. Vista de valor total de compra por cliente
CREATE VIEW Vista_Total_Compra_Cliente AS
SELECT 
    c.id_cliente,
    c.nombre, 
    c.apellido,
    COUNT(f.id_factura) AS cantidad_facturas,
    SUM(p.importe) AS total_platillos,
    SUM(b.importe) AS total_bebidas,
    SUM(p.importe + b.importe) AS total_compra
FROM 
    Cliente c
JOIN 
    Factura f ON c.id_cliente = f.id_cliente
JOIN 
    Platillo p ON f.id_paltillo = p.id_platillo
JOIN 
    Bebida b ON f.id_bebida = b.id_bebida
GROUP BY 
    c.id_cliente, c.nombre, c.apellido
ORDER BY 
    total_compra DESC;

-- 4. Vista de consumo de Manuel Pedroza (consulta 6)
CREATE VIEW Vista_Consumo_Manuel_Pedroza AS
SELECT 
    c.nombre, 
    c.apellido, 
    SUM(p.importe + b.importe) AS total_consumo
FROM 
    Cliente c
JOIN 
    Factura f ON c.id_cliente = f.id_cliente
JOIN 
    Platillo p ON f.id_paltillo = p.id_platillo
JOIN 
    Bebida b ON f.id_bebida = b.id_bebida
WHERE 
    c.nombre = 'Manuel' AND c.apellido = 'Pedroza Gonzalez'
GROUP BY 
    c.nombre, c.apellido;

-- 5. Vista de mesas utilizadas (consulta 7)
CREATE VIEW Vista_Mesas_Utilizadas AS
SELECT DISTINCT 
    m.id_mesa, 
    m.ubicacion, 
    m.num_comensales
FROM 
    Mesa m
JOIN 
    Factura f ON m.id_mesa = f.id_mesa
ORDER BY 
    m.id_mesa;
