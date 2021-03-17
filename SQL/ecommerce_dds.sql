/*
    @author kenneth.cruz@unah.hn
    @version 0.1.0
    @date 14/03/2021
*/


DROP DATABASE IF EXISTS Ecommerce; 
CREATE DATABASE Ecommerce CHARACTER SET utf8; 
USE Ecommerce; 

--
--  Producto  
--


CREATE TABLE Manufacturer(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    tex_manufacturer TINYTEXT NOT NULL COMMENT "Fabricante del producto",
    tex_brand TINYTEXT NOT NULL COMMENT "Marca del producto"
) COMMENT "Entidad que contiene las marcas de los productos";

CREATE TABLE Product(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_manufacturer_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Manufacturer", 
    -- tex_manufacturer TINYTEXT NOT NULL COMMENT "Fabricante del producto",
    -- tex_brand TINYTEXT NOT NULL COMMENT "Marca del producto",
    tex_model TINYTEXT NOT NULL COMMENT "Modelo para el producto",
    tex_description TEXT DEFAULT '' COMMENT "Breve descripción del producto que incluya características", 
    tim_year_launch YEAR NOT NULL COMMENT "Fecha de fabricación o año de lanzamiento del producto", 

    FOREIGN KEY (id_manufacturer_fk) REFERENCES Manufacturer(id)
) COMMENT "Entidad que contiene los datos generales de cualquier producto";

CREATE TABLE Operative_system(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    tex_name TINYTEXT NOT NULL COMMENT "Nombre del sistema operativo" 
    -- tex_version TINYTEXT DEFAULT '' COMMENT "Version del sistema operativo"

) COMMENT "Tipo de sistema operativo";

CREATE TABLE Port(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto",
    sma_hdmi SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto HDMI",
    sma_usb SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto USB",
    sma_display_port SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto Display Port",
    sma_typec SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto tipo-c",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Numero de puertos";

CREATE TABLE Graphic_card (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    sma_cores SMALLINT UNSIGNED DEFAULT 0 COMMENT "Números de nucleos de la GPU",
    sma_boot_clock SMALLINT UNSIGNED DEFAULT 0 COMMENT "Frecuencia base numerada en megahertz a la que funciona la tarjeta gráfica",
    sma_memory SMALLINT  UNSIGNED DEFAULT 0 COMMENT "Cantidad de memoria vRAM, con unidad de medidad en GB",
    cod_memory_type ENUM("GDDR5", "GDDR5X", "GDDR6") DEFAULT "GDDR5" COMMENT "Tipo de tecnología usada en la memoria que incluye la tarjeta gráfica", 

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad de Tarjetas gráficas";


CREATE TABLE Printer(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    cod_type ENUM("matricial", "láser", "multifuncional") NOT NULL COMMENT "Tipos de impresoras",
    tex_print_size TINYTEXT NOT NULL COMMENT "Tamaño del papel que puede imprimir 8.5x14 pulgadas",
    tex_conectivity TINYTEXT DEFAULT "" COMMENT "Conectividad (Bluethoot, USB 2.0...)",
    sma_print_speed SMALLINT UNSIGNED NOT NULL COMMENT "Cantidad de páginas que imprime por minuto (ppm)",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad de Impresoras";


CREATE TABLE Accessory(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_type TINYTEXT NOT NULL COMMENT "Cualquier tipo de accesorio dentro del depto de electrónica (auricular, reloj inteligente)",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad Accesorio";


CREATE TABLE Interface(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    cod_panel_technology ENUM("LCD", "IPS", "LED", "QLED", "OLED", "AMOLED") COMMENT "Tecnología en el panel", 
    dec_diagonal DECIMAL(3, 1) UNSIGNED NOT NULL COMMENT "Longitud de la diagonal del panel medido en pulgadas",
    cod_resolution ENUM("SD", "HD", "FHD", "QHD", "UHD") COMMENT "Resolucifón del panel HD(720p), FHD(1080p), QHD( 1440p, 2k), UHD(4K, 2160p)", 

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad que contiene los componentes esenciales para las entidades Monitor y Tv";


CREATE TABLE Monitor(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_interface_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Interface; hereda sus atributos",
    dec_response_time DECIMAL(3, 1) UNSIGNED DEFAULT 15 NOT NULL COMMENT "Tiempo de respuesta medido en microsegundos (0.5ms, 6ms, 12ms)", 
    sma_refresh_rate SMALLINT DEFAULT 60 NOT NULL COMMENT "Tasa de refresco medido en hertz 60h",

    FOREIGN KEY (id_interface_fk) REFERENCES Interface(id)
) COMMENT "Entidad que contiene la información para monitores";


CREATE TABLE Tv(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_interface_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    id_operative_sistem_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    bit_smart BIT(1) DEFAULT 1 COMMENT "Queremos saber sí un tv es smart o no, hacemos la suposición que lo es asignando el valor 1",

    FOREIGN KEY (id_interface_fk) REFERENCES Interface(id),
    FOREIGN KEY (id_operative_sistem_fk) REFERENCES Operative_system(id)
) COMMENT "Entidad que contiene la información para los Televisores";


CREATE TABLE Audio(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    sma_power SMALLINT UNSIGNED NOT NULL COMMENT "Potencia de los parlantes medido en Watts", 
    tex_conectivity TINYTEXT DEFAULT "" COMMENT "Conectividad (Bluethoot, USB 2.0...)",
    
    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad que contiene las componentes esenciales para las entidades Parlante portatil, Teatro en Casa y Equipo de sonido";

CREATE TABLE Portable_speaker(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_audio_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tim_battery TIME NOT NULL COMMENT "Tiempo de duración de la carga de la bateria medido en horas siguiendo el formato: hh:mm:ss",
    bit_water_resistant BIT(1) DEFAULT 1 COMMENT "Queremos conocer sí un parlante es resistente al agua o no, hacemos la suposición que lo es asignando el valor 1",

    FOREIGN KEY (id_audio_fk) REFERENCES Audio(id)
) COMMENT "";

CREATE TABLE Home_theater(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_audio_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_port TINYTEXT DEFAULT "" COMMENT "Puertos disponibles en el tatro en casa",

    FOREIGN KEY (id_audio_fk) REFERENCES Audio(id)
) COMMENT "";

CREATE TABLE Audio_system(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_audio_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_format_reproduction TINYTEXT DEFAULT '' COMMENT "Formatos de reproducción: Cd player, AM-FM...",

    FOREIGN KEY (id_audio_fk) REFERENCES Audio(id)
) COMMENT "Equipo de sonido";

CREATE TABLE Computer(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_processor TINYTEXT NOT NULL COMMENT "Especificaciones esenciales sobre el procesador", 
    sma_ram SMALLINT UNSIGNED NOT NULL COMMENT "Memoria RAM medido en GB",
    sma_storage SMALLINT UNSIGNED NOT NULL COMMENT "Almacenamiento medido en GB", 
    cod_storage_device ENUM("HDD", "SDD", "M.2", "NVMe", "interno") DEFAULT "Interno" COMMENT "Tipo de almacenamiento | 'Interno' propio para celulares",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Caracteristicas principales para dispositivos moviles y de mesa";

CREATE TABLE Console(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_computer_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_serie TINYTEXT DEFAULT '' COMMENT "Serie a la que pertenece la consola",
    cod_type ENUM("slim", "pórtatil") DEFAULT "slim" COMMENT "Tipos de consolas", 
    tex_accessory TINYTEXT DEFAULT '' COMMENT "Accesorio que incluye la consola JOYSTICK",

    FOREIGN KEY (id_computer_fk) REFERENCES Computer(id)
) COMMENT "";


CREATE TABLE Desktop(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_computer_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    cod_format ENUM("mini", "micro", "mid", "full") DEFAULT "mid" COMMENT "Formato de dimensiones para el case, concatenar 'Tower'",
    tex_color TINYTEXT NOT NULL COMMENT "Color del case",

    FOREIGN KEY (id_computer_fk) REFERENCES Computer(id)
) COMMENT "Computadora de escritorio";


CREATE TABLE Portable(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_computer_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    id_operative_sistem_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona el Tipo de sistema operativo con el dispositivo", 
    dec_diagonal DECIMAL(3, 1) UNSIGNED NOT NULL COMMENT "Longitud de la diagonal del panel medido en pulgadas",
    tex_version_os TINYTEXT DEFAULT '' COMMENT "Version del Sistema operativo",
    --    sma_battery SMALLINT NOT NULL COMMENT "Capacidad de la bateria medida en miliamperes", 

    FOREIGN KEY (id_computer_fk) REFERENCES Computer(id),
    FOREIGN KEY (id_operative_sistem_fk) REFERENCES Operative_system(id)
) COMMENT "Entidad Portátil mantiene características para las entidades 'Laptop' y 'Celular'";


CREATE TABLE Laptop(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_portable_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_graphic TINYTEXT DEFAULT 'interna' COMMENT "Gráfica dedicada para portátil", 
    cod_type ENUM("ultrabook", "gaming", "touch", "notebook", "chromebook", "mac") COMMENT "Tipos de laptop de venta en el mercado",
    tim_battery TIME DEFAULT '4:00:00' NOT NULL COMMENT "Tiempo de duración de la carga de la bateria medido en horas siguiendo el formato: hh:mm:ss",

    FOREIGN KEY (id_portable_fk) REFERENCES Portable(id)
) COMMENT "Entidad Laptop";


CREATE TABLE Smartphone(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_portable_fk INT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_color TINYTEXT DEFAULT '' COMMENT "Color del celular", 
    sma_front_camera SMALLINT UNSIGNED NOT NULL COMMENT "Camara frontal medido en MP",
    sma_rear_camera SMALLINT UNSIGNED NOT NULL COMMENT "Camara trasera medida en MP",
    cod_connector ENUM("microUSB", "type-c") DEFAULT "microUSB" COMMENT "Tipo de conector",
    sma_battery SMALLINT NOT NULL COMMENT "Capacidad de la bateria medida en miliamperes", 

    FOREIGN KEY (id_portable_fk) REFERENCES Portable(id)
) COMMENT "Entidad Celular";



--
--  Factura
--

CREATE TABLE Inventory(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL,
    med_quantity MEDIUMINT UNSIGNED NOT NULL COMMENT "Cantidad disponible del producto",
    tim_date TIMESTAMP DEFAULT NOW() ON UPDATE NOW() COMMENT "última actualización del estado de la cantidad del producto",
    dec_sale_price DECIMAL NOT NULL COMMENT "Precio de venta de del producto",
    dec_purchase_price DECIMAL NOT NULL COMMENT "Precio de compra de del producto",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad Inventario, número de productos dentro de la tienda";


CREATE TABLE Invoice(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    id_product_fk INT UNSIGNED NOT NULL,
    tim_date_issue TIMESTAMP DEFAULT NOW() COMMENT "Fecha de emisión"
    -- dec_subtotal DECIMAL UNSIGNED NOT NULL COMMENT "Subtotal suma de cada uno de los artículos según su cantidad",
    -- dec_iva DECIMAL(3,2) UNSIGNED DEFAULT 0.15 COMMENT "Impuesto",
    -- dec_total_pay DECIMAL UNSIGNED NOT NULL COMMENT "El total a pagar",
    -- dec_total_paid DECIMAL UNSIGNED NOT NULL COMMENT "El total pagado por parte del cliente",
    -- dec_change DECIMAL DEFAULT 0.0 COMMENT "Cambio, vuelto"

) COMMENT "Factura";

CREATE TABLE Invoice_detail(
    id INT UNSIGNED AUTO_INCREMENT, 
    id_invoice_fk INT UNSIGNED NOT NULL COMMENT "Clave foranea de la entidad Factura", 
    id_inventory_fk INT UNSIGNED NOT NULL COMMENT "Clave Foranea de la entidad Inventario", 
    sma_quantity SMALLINT UNSIGNED DEFAULT 1 COMMENT "Cantidad de los productos que comprará",
    -- dec_total_product DECIMAL UNSIGNED COMMENT "Total por la cantidad de producto y el precio del producto",

    PRIMARY KEY(id, id_invoice_fk),

    FOREIGN KEY (id_invoice_fk) REFERENCES Invoice(id),
    FOREIGN KEY (id_inventory_fk) REFERENCES Inventory(id)
) COMMENT "Detalles de la factura que incluye la información de la cantidad de productos a comprar";


