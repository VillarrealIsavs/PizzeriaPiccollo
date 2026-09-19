
-- tabla pedidos--
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('efectivo', 'tarjeta', 'app') NOT NULL,
    estado ENUM('pendiente', 'en preparacion', 'entregado', 'cancelado') DEFAULT 'pendiente',
    es_domicilio BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- tabla intermedia --
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_pizza INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza)
);

-- Consulta de pedidos por cliente-- 
SELECT c.nombre AS clientes, COUNT(d.id_pedido) AS cantidad_pedidos
FROM clientes c INNER JOIN domicilios d
ON c.id_cliente= p.id_pedido
GROUP BY c.id_clientes, c.nombre;

-- Consulta de pedidos entregados en un rango de fechas--
SELECT  c.nombre, p.id_pedido, p.fecha_pedido 
FROM clientes c INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente
WHERE p.fecha_pedido BETWEEN '2026-01-01' AND '2026-01-31';

-- Consulta de resumen de pedidos por método de pago--
SELECT p.metodo_pago, COUNT(*) AS cantidad_pedidos, SUM(calcular_total_pedido(p.id_pedido)) AS total_a
FROM pedidos p GROUP BY p.metodo_pago;

-- Consulta de clientes frecuentes --
SELECT c.id_cliente, c.nombre, c.telefono, COUNT(*) AS cantidad_pedidos
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.telefono
HAVING COUNT(*) > 5;