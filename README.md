🍕 Pizzeria Don Piccolo

Base de datos desarrollada en MySQL para gestionar los pedidos, clientes, pizzas, ingredientes y domicilios de una pizzería.

📂 Archivos del proyecto
🗄️ database.sql

Es la estructura principal de la base de datos.

Aquí se crea la base de datos, las tablas, sus relaciones mediante llaves foráneas y se agregan datos de prueba para trabajar con el proyecto.

⚙️ funciones.sql

Contiene las funciones encargadas de realizar cálculos automáticos.

Calcula el total de un pedido incluyendo IVA y domicilio.
Calcula la ganancia neta de un día.
Actualiza automáticamente el estado de un pedido cuando se registra su entrega.
🔄 triggers.sql

Contiene procesos que se ejecutan automáticamente cuando cambian los datos.

Descuenta los ingredientes del inventario cuando se realiza un pedido.
Cambia al repartidor a estado disponible cuando termina una entrega.
👀 vistas.sql

Contiene vistas para consultar información de forma más sencilla.

Resumen de clientes: muestra la cantidad de pedidos realizados por cada cliente.
Rendimiento de repartidores: muestra la cantidad de domicilios registrados por cada repartidor.
Stock bajo: muestra los ingredientes que necesitan revisión por tener poco inventario.
🔎 consultas.sql

Contiene las consultas solicitadas para analizar la información de la pizzería.

Se realizan consultas para:

Buscar clientes por fechas.
Identificar las pizzas más vendidas.
Consultar pedidos por repartidor.
Calcular el promedio de entrega por zona.
Encontrar clientes que superan un monto de gasto.
Buscar pizzas por coincidencia de nombre.
Identificar clientes frecuentes.
▶️ Orden de ejecución

Para ejecutar el proyecto correctamente:

1. database.sql
2. funciones.sql
3. triggers.sql
4. vistas.sql
5. consultas.sql

🎯 Objetivo

Crear una base de datos funcional para administrar la información de Pizzeria Don Piccolo, aplicando relaciones entre tablas, consultas SQL, funciones, triggers y vistas para facilitar la gestión de pedidos, inventario y domicilios.
