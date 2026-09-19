USE Pizzeria_Piccollo;

CREATE VIEW vista_resumen_clientes AS
SELECT 
    c.id_cliente,
    c.nombre,
    c.telefono,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p 
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.telefono;


CREATE VIEW vista_rendimiento_repartidores AS
SELECT
    r.id_repartidor,
    r.nombre,
    r.zona,
    COUNT(d.id_domicilio) AS domicilios_realizados
FROM repartidores r
LEFT JOIN domicilios d
    ON r.id_repartidor = d.id_repartidor
GROUP BY r.id_repartidor, r.nombre, r.zona;


CREATE VIEW vista_stock_bajo AS
SELECT
    id_ingrediente,
    nombre,
    stock,
    stock_minimo,
    unidad
FROM ingredientes
WHERE stock <= stock_minimo;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';