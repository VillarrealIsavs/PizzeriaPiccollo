CREATE DATABASE Pizzeria_Piccollo;
USE Pizzeria_Piccollo;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    correo VARCHAR(50),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO clientes (nombre, telefono, direccion, correo) VALUES
('Mario Rojas', '3001112233', 'Calle 10 #20-30', 'mario.rojas@gmail.com'),
('Pablo Navas', '3012223344', 'Carrera 15 #30-40', 'pablo.navas@gmail.com'),
('Sara Ramirez', '3023334455', 'Calle 25 #10-20', 'sara.ramirez@gmail.com'),
('Danna Tellez', '3034445566', 'Carrera 8 #12-15', 'danna.tellez@gmail.com'),
('Santiago Mendoza', '3045556677', 'Calle 50 #18-22', 'santiago.mendoza@gmail.com'),
('Isabella Villarreal', '3056667788', 'Carrera 20 #15-25', 'isabella.villarreal@gmail.com');

CREATE TABLE repartidores (
    id_repartidor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    zona VARCHAR(80) NOT NULL,
    estado ENUM('disponible', 'no disponible') DEFAULT 'disponible'
);

INSERT INTO repartidores (nombre, zona, estado)
VALUES
('Alejandro Solano', 'Norte', 'disponible'),
('David Dominguez', 'Sur', 'disponible'),
('Daniel Vargas', 'Centro', 'disponible'),
('Oscar Rodriguez', 'Occidente', 'no disponible');

CREATE TABLE ingredientes (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    stock DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_minimo DECIMAL(10,2) NOT NULL DEFAULT 5,
    unidad VARCHAR(20) NOT NULL DEFAULT 'unidad',
    costo_unitario DECIMAL(10,2) NOT NULL DEFAULT 0
);

INSERT INTO ingredientes (nombre, stock, stock_minimo, unidad, costo_unitario) VALUES
('Harina', 100, 20, 'kg', 3000),
('Queso', 50, 10, 'kg', 18000),
('Tomate', 40, 8, 'kg', 5000),
('Jamon', 30, 5, 'kg', 22000),
('Piña', 25, 5, 'kg', 7000),
('Pepperoni', 30, 5, 'kg', 25000),
('Champiñones', 20, 4, 'kg', 12000),
('Pollo', 35, 5, 'kg', 16000);

CREATE TABLE pizzas (
    id_pizza INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tamano ENUM('personal', 'mediana', 'grande') NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL,
    tipo ENUM('vegetariana', 'especial', 'clasica') NOT NULL,
    disponible BOOLEAN DEFAULT TRUE
);

INSERT INTO pizzas (nombre, tamano, precio_base, tipo) VALUES
('Pizza Hawaiana', 'mediana', 30000, 'clasica'),
('Pizza Pepperoni', 'mediana', 32000, 'clasica'),
('Pizza Pollo Champiñones', 'grande', 42000, 'especial'),
('Pizza Vegetariana', 'mediana', 35000, 'vegetariana'),
('Pizza Especial Don Piccolo', 'grande', 48000, 'especial'),
('Pizza de Jamon', 'personal', 22000, 'clasica');

CREATE TABLE pizza_ingrediente (
    id_pizza INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pizza, id_ingrediente),
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza),
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)
);
INSERT INTO pizza_ingrediente (id_pizza, id_ingrediente, cantidad)
VALUES
(1, 1, 0.25), (1, 2, 0.20), (1, 4, 0.10), (1, 5, 0.10),
(2, 1, 0.25), (2, 2, 0.20), (2, 6, 0.12), 
(3, 1, 0.35), (3, 2, 0.25), (3, 8, 0.15), (3, 7, 0.10),
(4, 1, 0.25), (4, 2, 0.20), (4, 3, 0.10), (4, 7, 0.10),
(5, 1, 0.35), (5, 2, 0.30), (5, 4, 0.10), (5, 6, 0.10), (5, 7, 0.10),
(6, 1, 0.20), (6, 2, 0.15), (6, 4, 0.10);



CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('efectivo', 'tarjeta', 'app') NOT NULL,
    estado ENUM('pendiente', 'en preparacion', 'entregado', 'cancelado') DEFAULT 'pendiente',
    es_domicilio BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO pedidos (id_cliente, fecha_pedido, metodo_pago, estado, es_domicilio) VALUES
(1, '2026-01-05 12:30:00', 'efectivo', 'entregado', TRUE),
(2, '2026-01-10 18:00:00', 'tarjeta', 'entregado', TRUE),
(3, '2026-01-15 19:30:00', 'app', 'entregado', TRUE),
(7, '2026-01-20 13:00:00', 'efectivo', 'pendiente', FALSE),
(4, '2026-01-25 20:00:00', 'tarjeta', 'en preparacion', TRUE),
(5, '2026-02-02 19:00:00', 'app', 'entregado', TRUE);

CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_pizza INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza)
);

INSERT INTO detalle_pedido (id_pedido, id_pizza, cantidad, precio_unitario) VALUES
(1, 1, 2, 30000), (1, 2, 1, 32000),
(2, 3, 1, 42000), (2, 4, 2, 35000),
(3, 5, 1, 48000), (3, 1, 1, 30000),
(4, 2, 2, 32000),
(5, 3, 2, 42000),
(6, 4, 1, 35000);

CREATE TABLE domicilios (
    id_domicilio INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE,
    id_repartidor INT NOT NULL,
    zona VARCHAR(80) NOT NULL,
    hora_salida DATETIME,
    hora_entrega DATETIME,
    distancia_km DECIMAL(6,2) NOT NULL DEFAULT 0,
    costo_envio DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_repartidor) REFERENCES repartidores(id_repartidor)
);

INSERT INTO domicilios (id_pedido, id_repartidor, zona, hora_salida, hora_entrega, distancia_km, costo_envio) VALUES
(1, 1, 'Norte', '2026-01-05 12:50:00', '2026-01-05 13:20:00', 4.5, 5000),
(2, 2, 'Sur', '2026-01-10 18:20:00', '2026-01-10 18:55:00', 6.2, 6000),
(3, 3, 'Centro', '2026-01-15 19:50:00', '2026-01-15 20:15:00', 3.1, 4000),
(5, 1, 'Norte', '2026-01-25 20:20:00', NULL, 5.0, 5000),
(6, 2, 'Sur', '2026-02-02 19:20:00', '2026-02-02 19:50:00', 5.5, 6000);
