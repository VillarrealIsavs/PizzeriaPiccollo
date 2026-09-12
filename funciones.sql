USE Pizzeria_Piccollo;
DELIMITER //
CREATE FUNCTION calcular_total_pedido(p_id_pedido INT) RETURNS DECIMAL(10,2) DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE subtotal DECIMAL(12,2) DEFAULT 0;
    DECLARE envio DECIMAL(12,2) DEFAULT 0;
    DECLARE iva DECIMAL(12,2) DEFAULT 0;

    SELECT COALESCE(SUM(cantidad * precio_unitario), 0)
    INTO subtotal
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    SELECT COALESCE(costo_envio, 0)
    INTO envio
    FROM domicilios
    WHERE id_pedido = p_id_pedido
    LIMIT 1;

    SET iva = subtotal * 0.19;

    RETURN subtotal + envio + iva;
END//
DELIMITER ;

DELIMITER //

CREATE FUNCTION ganancia_neta_diaria(p_fecha DATE)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_ventas DECIMAL(12,2) DEFAULT 0;
    DECLARE total_costos DECIMAL(12,2) DEFAULT 0;

    SELECT COALESCE(SUM(dp.cantidad * dp.precio_unitario), 0)
    INTO total_ventas
    FROM detalle_pedido dp
    INNER JOIN pedidos p ON dp.id_pedido = p.id_pedido
    WHERE DATE(p.fecha_pedido) = p_fecha
      AND p.estado <> 'cancelado';

    SELECT COALESCE(SUM(dp.cantidad * pi.cantidad * i.costo_unitario), 0)
    INTO total_costos
    FROM detalle_pedido dp
    INNER JOIN pedidos p ON dp.id_pedido = p.id_pedido
    INNER JOIN pizza_ingrediente pi ON dp.id_pizza = pi.id_pizza
    INNER JOIN ingredientes i ON pi.id_ingrediente = i.id_ingrediente
    WHERE DATE(p.fecha_pedido) = p_fecha
      AND p.estado <> 'cancelado';

    RETURN total_ventas - total_costos;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER actualizar_estado_entrega
AFTER UPDATE ON domicilios
FOR EACH ROW
BEGIN
    IF NEW.hora_entrega IS NOT NULL
       AND OLD.hora_entrega IS NULL THEN

        UPDATE pedidos
        SET estado = 'entregado'
        WHERE id_pedido = NEW.id_pedido;

    END IF;
END//
DELIMITER ;