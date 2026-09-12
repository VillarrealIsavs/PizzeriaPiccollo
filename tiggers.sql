USE Pizzeria_Piccollo;
DELIMITER //
CREATE TRIGGER descontar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE ingredientes i
    INNER JOIN pizza_ingrediente pi
        ON i.id_ingrediente = pi.id_ingrediente
    SET i.stock = i.stock - (pi.cantidad * NEW.cantidad)
    WHERE pi.id_pizza = NEW.id_pizza;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER repartidor_disponible
AFTER UPDATE ON domicilios
FOR EACH ROW
BEGIN
    IF NEW.hora_entrega IS NOT NULL
       AND OLD.hora_entrega IS NULL THEN

        UPDATE repartidores
        SET estado = 'disponible'
        WHERE id_repartidor = NEW.id_repartidor;

    END IF;
END//
DELIMITER ;