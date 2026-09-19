CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('efectivo', 'tarjeta', 'app') NOT NULL,
    estado ENUM('pendiente', 'en preparacion', 'entregado', 'cancelado') DEFAULT 'pendiente',
    es_domicilio BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_pizza INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza)
);

