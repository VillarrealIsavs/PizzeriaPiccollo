SELECT  c.nombre, p.id_pedido, p.fecha_pedido 
FROM clientes c INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente
WHERE p.fecha_pedido BETWEEN '2026-01-01' AND '2026-01-31';


SELECT p.nombre, COUNT(dp.id_detalle) AS veces_vendida
FROM pizzas p JOIN detalle_pedido dp ON p.id_pizza = dp.id_pizza
GROUP BY p.id_pizza, p.nombre ORDER BY veces_vendida DESC;


SELECT r.nombre AS repartidor, COUNT(d.id_pedido) AS cantidad_pedidos
FROM repartidores r INNER JOIN domicilios d
ON r.id_repartidor = d.id_repartidor
GROUP BY r.id_repartidor, r.nombre;


SELECT d.zona, AVG(TIMESTAMPDIFF(MINUTE, d.hora_salida, d.hora_entrega)) AS promedio_minutos
FROM domicilios d INNER JOIN repartidores r
ON d.id_repartidor = r.id_repartidor
WHERE d.hora_salida IS NOT NULL AND d.hora_entrega IS NOT NULL 
GROUP BY d.zona;


SELECT c.nombre, SUM(dp.cantidad * dp.precio_unitario) AS total_gastado
FROM clientes c JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.id_cliente, c.nombre HAVING SUM(dp.cantidad * dp.precio_unitario) > 100000;

SELECT id_pizza, nombre, precio_base
FROM pizzas WHERE nombre LIKE '%pollo%';


SELECT c.id_cliente, c.nombre FROM clientes c
WHERE c.id_cliente IN (
SELECT p.id_cliente FROM pedidos p
GROUP BY p.id_cliente HAVING COUNT(p.id_pedido) > 5
);