/*
    @author kenneth.cruz@unah.hn
    @version 0.2.1
    @date 20/03/2021
*/


DROP DATABASE IF EXISTS Ecommerce; 
CREATE DATABASE Ecommerce CHARACTER SET utf8; 
USE Ecommerce; 

--
--  Login
--  



CREATE TABLE User(
    id SERIAL PRIMARY KEY, 
    -- id_person_fk BIGINT UNSIGNED NOT NULL UNIQUE, 
    tex_email VARCHAR(40) NOT NULL UNIQUE COMMENT "Email con el que entra el sistema"
    CHECK( tex_email RLIKE "[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]+)+"), 
    tex_password TINYTEXT NOT NULL COMMENT "Contraseña",
    cod_rol ENUM("cliente", "empresa", "empleado", "administrador") DEFAULT "cliente" COMMENT "Roles del usuario en el sistema"

) COMMENT "Rol de acceso al sistema, dependiendo de este tendrá cierto control de acceso";

CREATE TABLE Person(
    id SERIAL PRIMARY KEY, 
    id_user_fk BIGINT UNSIGNED NOT NULL COMMENT "Referencia hacia la entidad User",
    tex_dni TINYTEXT NOT NULL COMMENT "Identificación de usuario asignada por parte de una nación"
    CHECK( tex_dni RLIKE "[0-9- ]+" ),
    tex_first_name TINYTEXT NOT NULL COMMENT "Primer nombre de la persona"
    CHECK( tex_first_name RLIKE "[a-zA-Z ]+" ),
    tex_last_name TINYTEXT NOT NULL COMMENT "Apellido de la persona"
    CHECK( tex_first_name RLIKE "[a-zA-Z ]+" ),
    cod_gender ENUM("female", "male", "other") NOT NULL DEFAULT "female" COMMENT "Género de la persona",
    tim_birthday TIMESTAMP NOT NULL COMMENT "Fecha de nacimiento",
    
    FOREIGN KEY (id_user_fk) REFERENCES User(id)
) COMMENT "Entidad que contiene los atriutos básicos, información necesaria para una persona";

CREATE TABLE Country(
    id SERIAL PRIMARY KEY, 
    tex_name VARCHAR(50) NOT NULL UNIQUE COMMENT "Nombre del país",
    tex_iso TINYTEXT NOT NULL COMMENT "Iso o abreviatura"
) COMMENT "Nombre de país";



--
--  Clientes corporativos
--

CREATE TABLE Business(
    id SERIAL PRIMARY KEY, 
    id_user_fk BIGINT UNSIGNED NOT NULL COMMENT "Referencia hacia la entidad User",
    id_country_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea que relaciona esta entidad con la entidad País",
    tex_name TINYTEXT NOT NULL COMMENT "Nombre de la empresa o asociado",
    tex_rtn TINYTEXT NOT NULL COMMENT "Registro Tributario Nacional Numérico",
    tex_bankAccount TINYTEXT NOT NULL COMMENT "Cuenta bancaria",
    
    FOREIGN KEY (id_country_fk) REFERENCES Country(id),
    FOREIGN KEY (id_user_fk) REFERENCES User(id)
) COMMENT = "Clientes empresariales, estos mantienen cuentan bancarias";


--
--  Clientes
--

CREATE TABLE Client(
    id SERIAL PRIMARY KEY, 
    id_person_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea que relaciona esta entidad con la entidad Persona",
    id_country_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea que relaciona esta entidad con la entidad País",
    bit_type BIT(1) DEFAULT 0 NOT NULL COMMENT "Cliente poco frecuente: 0 | Cliente por contrato: 1 ",

    FOREIGN KEY (id_country_fk) REFERENCES Country(id),
    FOREIGN KEY (id_person_fk) REFERENCES Person(id)
) COMMENT "Entidad Cliente";

CREATE TABLE CreditCard(
    id SERIAL PRIMARY KEY, 
    id_client_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea que relaciona esta entidad con la entidad Cliente | Un cliente puede tener varias tarjetas",
    tex_number VARCHAR(25) NOT NULL UNIQUE COMMENT "Número de la tarjeta de credito"
     CHECK( tex_number RLIKE "[0-9 ]+" ), 
    -- tex_name TINYTEXT NOT NULL COMMENT "Nombre asociado a la tarjeta"
    -- CHECK( tex_name RLIKE "([a-zA-Z ]+\.?)+" ),
    tim_expiration_date TIMESTAMP NOT NULL COMMENT "Fecha de vencimiento",
    tex_code TINYTEXT NOT NULL COMMENT "Número de la tarjeta de credito"
     CHECK( tex_number RLIKE "[0-9]{3,5}" ), 


    FOREIGN KEY (id_client_fk) REFERENCES Client(id)
) COMMENT "Entidad Tarjeta de credito | debito";

CREATE TABLE Address(
    id SERIAL PRIMARY KEY, 
    -- id_client_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea que relaciona esta entidad con la entidad Cliente | Un cliente puede tener varias direcciones",
    tex_street_address TINYTEXT NOT NULL COMMENT "Dirección de la calle donde reside",
    tex_number_street TINYTEXT NOT NULL COMMENT "Número de la calle/bloque/zona",
    tex_zip TINYTEXT NOT NULL COMMENT "Código postal",
    tex_city TINYTEXT NOT NULL COMMENT "Ciudad",
    tex_state TINYTEXT NOT NULL COMMENT "Departamento"

    -- FOREIGN KEY (id_client_fk) REFERENCES Client(id)
) COMMENT "Dirección donde se harán los envíos de los productos";

CREATE TABLE AddressClient(
    id SERIAL PRIMARY KEY, 
    id_client_fk BIGINT UNSIGNED NOT NULL COMMENT "Referencia hacia la entidad Client",
    id_address_fk BIGINT UNSIGNED NOT NULL COMMENT "Referencia hacia la entidad Address",

    FOREIGN KEY (id_client_fk) REFERENCES Client(id),
    FOREIGN KEY (id_address_fk) REFERENCES Address(id)
)COMMENT = "Relación muchos a muchos con clientes";


CREATE TABLE AddressBusiness(
    id SERIAL PRIMARY KEY, 
    id_business_fk BIGINT UNSIGNED NOT NULL COMMENT "Referencia hacia la entidad Business",
    id_address_fk BIGINT UNSIGNED NOT NULL COMMENT "Referencia hacia la entidad Address",

    FOREIGN KEY (id_business_fk) REFERENCES Client(id),
    FOREIGN KEY (id_address_fk) REFERENCES Business(id)
)COMMENT = "Relación muchos a muchos con clientes de tipo Empresa";

--
--  Empleados
--

CREATE TABLE Employee(
    id SERIAL PRIMARY KEY, 
    id_person_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Persona",
    id_mgr BIGINT UNSIGNED COMMENT "ID del gerente del empleado",
    dec_salary DECIMAL UNSIGNED NOT NULL COMMENT "Sueldo del empleado",
    tim_date_hire TIMESTAMP DEFAULT NOW() NOT NULL COMMENT "Fecha de contratación del empleado",

    FOREIGN KEY (id_person_fk) REFERENCES Person(id)
) COMMENT "Entidad Empleado";

CREATE TABLE Store(
    id SERIAL PRIMARY KEY, 
    tex_name_store TINYTEXT NOT NULL COMMENT "Nombre de la tienda", 
    tex_address TINYTEXT NOT NULL COMMENT "Dirección de la tienda" 

) COMMENT "Tienda Física donde laboran los empleados";

CREATE TABLE EmployeeStore(
    id SERIAL PRIMARY KEY, 
    id_employee_fk BIGINT UNSIGNED NOT NULL UNIQUE COMMENT "Clave foránea que relaciona esta entidad con la entidad Empleado",
    id_store_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Tienda donde laboran fisicamente los empleados",
    
    FOREIGN KEY (id_employee_fk) REFERENCES Employee(id),
    FOREIGN KEY (id_store_fk) REFERENCES Store(id)
) COMMENT "Relación: Empleado - tienda Fisica donde labora";

CREATE TABLE Cellphone(
    id SERIAL PRIMARY KEY, 
    id_person_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea que relaciona esta entidad con la entidad Proveedor",
    tex_cellphone_number TINYTEXT NOT NULL COMMENT "Número de télefono"
     CHECK( tex_cellphone_number RLIKE "([0-9]+((\-)|(\/)|([ ])))+" ),

    FOREIGN KEY (id_person_fk) REFERENCES Person(id)
) COMMENT "Número de teléfono";


--
--  Proveedor
--

CREATE TABLE Supplier(
    id SERIAL PRIMARY KEY, 
    id_employee_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Empleado | Empleado que atenderá al proveedor",
    tex_name_business TINYTEXT NOT NULL COMMENT "Nombre de la empresa que representa",
    tex_cellphone_business TINYTEXT NOT NULL COMMENT "Número de teléfono de la empresa"
     CHECK( tex_cellphone_manager RLIKE "([0-9]+((\-)|(\/)|([ ])))+" ),
    tex_address_business TINYTEXT NOT NULL COMMENT "Dirección de la empresa",
    tex_name_manager TINYTEXT NOT NULL COMMENT "nombre del encargado o representante de la empresa",
    tex_cellphone_manager TINYTEXT NOT NULL COMMENT "Número de teléfono del encargado o representante de la empresa"
     CHECK( tex_cellphone_manager RLIKE "([0-9]+((\-)|(\/)|([ ])))+" ),
 
    FOREIGN KEY (id_employee_fk) REFERENCES Employee(id)
) COMMENT "Proveedores"; 


--
--  Producto  
--

CREATE TABLE Category(
    id SERIAL PRIMARY KEY, 
    tex_category TEXT NOT NULL COMMENT "Nombre de las categorias disponibles en la tienda"
) COMMENT = "Nombre de las categorias de cada producto";

CREATE TABLE Manufacturer(
    id SERIAL PRIMARY KEY, 
    tex_manufacturer TINYTEXT NOT NULL COMMENT "Fabricante del producto",
    tex_brand TINYTEXT NOT NULL COMMENT "Marca del producto", 
    tex_website TINYTEXT NOT NULL COMMENT "Enlace de la página web"
) COMMENT "Entidad que contiene las marcas de los productos";

CREATE TABLE Product(
    id SERIAL PRIMARY KEY, 
    id_manufacturer_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Manufacturer", 
    id_category_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Category", 
    -- tex_manufacturer TINYTEXT NOT NULL COMMENT "Fabricante del producto",
    -- tex_brand TINYTEXT NOT NULL COMMENT "Marca del producto",
    tex_model TINYTEXT NOT NULL COMMENT "Modelo para el producto",
    tex_description TEXT DEFAULT '' COMMENT "Breve descripción del producto que incluya características", 
    tim_year_launch YEAR NOT NULL COMMENT "Fecha de fabricación o año de lanzamiento del producto", 
    jso_link_photo JSON DEFAULT '{}' NOT NULL COMMENT "Enlace que redirige a un sitio o página que contiene la imagen del producto",
    FULLTEXT(tex_model, tex_description),
    FOREIGN KEY (id_manufacturer_fk) REFERENCES Manufacturer(id)
) COMMENT "Entidad que contiene los datos generales de cualquier producto";

CREATE TABLE OperativeSystem(
    id SERIAL PRIMARY KEY, 
    tex_name VARCHAR(20) NOT NULL UNIQUE COMMENT "Nombre del sistema operativo" 
    -- tex_version TINYTEXT DEFAULT '' COMMENT "Version del sistema operativo"

) COMMENT "Tipo de sistema operativo";

CREATE TABLE VersionOS(
    id  SERIAL PRIMARY KEY, 
    id_operative_system_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que apunta a la entidad Sietema operativo",
    tex_name VARCHAR(20) NOT NULL UNIQUE COMMENT "Nombre de la version" ,

    FOREIGN KEY (id_operative_system_fk) REFERENCES OperativeSystem(id)
) COMMENT "Versión del Sistema operativo del dispositivo";

CREATE TABLE Port(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto",
    sma_hdmi SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto HDMI",
    sma_usb SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto USB",
    sma_display_port SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto Display Port",
    sma_typec SMALLINT UNSIGNED DEFAULT 0 COMMENT "Cantidad de puerto tipo-c",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Numero de puertos";

CREATE TABLE GraphicCard (
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    sma_cores SMALLINT UNSIGNED DEFAULT 0 COMMENT "Números de nucleos de la GPU",
    sma_boot_clock SMALLINT UNSIGNED DEFAULT 0 COMMENT "Frecuencia base numerada en megahertz a la que funciona la tarjeta gráfica",
    sma_memory SMALLINT  UNSIGNED DEFAULT 0 COMMENT "Cantidad de memoria vRAM, con unidad de medidad en GB",
    cod_memory_type ENUM("GDDR5", "GDDR5X", "GDDR6") DEFAULT "GDDR5" COMMENT "Tipo de tecnología usada en la memoria que incluye la tarjeta gráfica", 

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad de Tarjetas gráficas";


CREATE TABLE Printer(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    cod_type ENUM("matricial", "láser", "multifuncional") NOT NULL COMMENT "Tipos de impresoras",
    tex_print_size TINYTEXT NOT NULL COMMENT "Tamaño del papel que puede imprimir 8.5x14 pulgadas",
    tex_conectivity TINYTEXT DEFAULT "" COMMENT "Conectividad (Bluethoot, USB 2.0...)",
    sma_print_speed SMALLINT UNSIGNED NOT NULL COMMENT "Cantidad de páginas que imprime por minuto (ppm)",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad de Impresoras";


CREATE TABLE Accessory(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_type TINYTEXT NOT NULL COMMENT "Cualquier tipo de accesorio dentro del depto de electrónica (auricular, reloj inteligente)",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad Accesorio";


CREATE TABLE Interface(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    cod_panel_technology ENUM("LCD", "IPS", "LED", "QLED", "OLED", "AMOLED") COMMENT "Tecnología en el panel", 
    dec_diagonal DECIMAL(3, 1) UNSIGNED NOT NULL COMMENT "Longitud de la diagonal del panel medido en pulgadas",
    cod_resolution ENUM("SD", "HD", "FHD", "QHD", "UHD") COMMENT "Resolucifón del panel HD(720p), FHD(1080p), QHD( 1440p, 2k), UHD(4K, 2160p)", 

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad que contiene los componentes esenciales para las entidades Monitor y Tv";


CREATE TABLE Monitor(
    id SERIAL PRIMARY KEY, 
    id_interface_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Interface; hereda sus atributos",
    dec_response_time DECIMAL(3, 1) UNSIGNED DEFAULT 10 NOT NULL COMMENT "Tiempo de respuesta medido en microsegundos (0.5ms, 6ms, 12ms)", 
    sma_refresh_rate SMALLINT DEFAULT 60 NOT NULL COMMENT "Tasa de refresco medido en hertz 60h",

    FOREIGN KEY (id_interface_fk) REFERENCES Interface(id)
) COMMENT "Entidad que contiene la información para monitores";


CREATE TABLE Tv(
    id SERIAL PRIMARY KEY, 
    id_interface_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    id_version_os_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    bit_smart BIT(1) DEFAULT 1 COMMENT "Queremos saber sí un tv es smart o no, hacemos la suposición que lo es asignando el valor 1",

    FOREIGN KEY (id_interface_fk) REFERENCES Interface(id),
    FOREIGN KEY (id_version_os_fk) REFERENCES VersionOS(id)
) COMMENT "Entidad que contiene la información para los Televisores";


CREATE TABLE Audio(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    sma_power SMALLINT UNSIGNED NOT NULL COMMENT "Potencia de los parlantes medido en Watts", 
    tex_conectivity TINYTEXT DEFAULT "" COMMENT "Conectividad (Bluethoot, USB 2.0...)",
    
    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad que contiene las componentes esenciales para las entidades Parlante portatil, Teatro en Casa y Equipo de sonido";

CREATE TABLE PortableSpeaker(
    id SERIAL PRIMARY KEY, 
    id_audio_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tim_battery TIME NOT NULL COMMENT "Tiempo de duración de la carga de la bateria medido en horas siguiendo el formato: hh:mm:ss",
    bit_water_resistant BIT(1) DEFAULT 1 COMMENT "Queremos conocer sí un parlante es resistente al agua o no, hacemos la suposición que lo es asignando el valor 1",

    FOREIGN KEY (id_audio_fk) REFERENCES Audio(id)
) COMMENT "";

CREATE TABLE HomeTheater(
    id SERIAL PRIMARY KEY, 
    id_audio_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_port TINYTEXT DEFAULT "" COMMENT "Puertos disponibles en el tatro en casa",

    FOREIGN KEY (id_audio_fk) REFERENCES Audio(id)
) COMMENT "";

CREATE TABLE AudioSystem(
    id SERIAL PRIMARY KEY, 
    id_audio_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_format_reproduction TINYTEXT DEFAULT '' COMMENT "Formatos de reproducción: Cd player, AM-FM...",

    FOREIGN KEY (id_audio_fk) REFERENCES Audio(id)
) COMMENT "Equipo de sonido";

CREATE TABLE Computer(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_processor TINYTEXT NOT NULL COMMENT "Especificaciones esenciales sobre el procesador", 
    sma_ram SMALLINT UNSIGNED NOT NULL COMMENT "Memoria RAM medido en GB",
    sma_storage SMALLINT UNSIGNED NOT NULL COMMENT "Almacenamiento medido en GB", 
    cod_storage_device ENUM("HDD", "SDD", "M.2", "NVMe", "interno") DEFAULT "Interno" COMMENT "Tipo de almacenamiento | 'Interno' propio para celulares",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Caracteristicas principales para dispositivos moviles y de mesa";

CREATE TABLE Console(
    id SERIAL PRIMARY KEY, 
    id_computer_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_serie TINYTEXT DEFAULT '' COMMENT "Serie a la que pertenece la consola",
    cod_type ENUM("slim", "pórtatil") DEFAULT "slim" COMMENT "Tipos de consolas", 
    tex_accessory TINYTEXT DEFAULT '' COMMENT "Accesorio que incluye la consola JOYSTICK",

    FOREIGN KEY (id_computer_fk) REFERENCES Computer(id)
) COMMENT "";


CREATE TABLE Desktop(
    id SERIAL PRIMARY KEY, 
    id_computer_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    cod_format ENUM("mini", "micro", "mid", "full") DEFAULT "mid" COMMENT "Formato de dimensiones para el case, concatenar 'Tower'",
    tex_color TINYTEXT NOT NULL COMMENT "Color del case",

    FOREIGN KEY (id_computer_fk) REFERENCES Computer(id)
) COMMENT "Computadora de escritorio";


CREATE TABLE Portable(
    id SERIAL PRIMARY KEY, 
    id_computer_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    id_version_os_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona el Tipo de sistema operativo con el dispositivo", 
    dec_diagonal DECIMAL(3, 1) UNSIGNED NOT NULL COMMENT "Longitud de la diagonal del panel medido en pulgadas",
    --    sma_battery SMALLINT NOT NULL COMMENT "Capacidad de la bateria medida en miliamperes", 

    FOREIGN KEY (id_computer_fk) REFERENCES Computer(id),
    FOREIGN KEY (id_version_os_fk) REFERENCES VersionOS(id)
) COMMENT "Entidad Portátil mantiene características para las entidades 'Laptop' y 'Celular'";


CREATE TABLE Laptop(
    id SERIAL PRIMARY KEY, 
    id_portable_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
    tex_graphic TINYTEXT DEFAULT 'interna' COMMENT "Gráfica dedicada para portátil", 
    cod_type ENUM("notebook", "ultrabook", "gaming", "touch", "chromebook", "mac") COMMENT "Tipos de laptop de venta en el mercado",
    tim_battery TIME DEFAULT '4:00:00' NOT NULL COMMENT "Tiempo de duración de la carga de la bateria medido en horas siguiendo el formato: hh:mm:ss",

    FOREIGN KEY (id_portable_fk) REFERENCES Portable(id)
) COMMENT "Entidad Laptop";


CREATE TABLE Smartphone(
    id SERIAL PRIMARY KEY, 
    id_portable_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Producto, dado que hereda sus atributos",
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
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL,
    med_quantity MEDIUMINT UNSIGNED NOT NULL COMMENT "Cantidad disponible del producto",
    tim_date TIMESTAMP DEFAULT NOW() ON UPDATE NOW() COMMENT "última actualización del estado de la cantidad del producto",
    dec_sale_price DECIMAL NOT NULL COMMENT "Precio de venta de del producto",
    dec_purchase_price DECIMAL NOT NULL COMMENT "Precio de compra de del producto",

    FOREIGN KEY (id_product_fk) REFERENCES Product(id)
) COMMENT "Entidad Inventario, número de productos dentro de la tienda";


CREATE TABLE Invoice(
    id SERIAL PRIMARY KEY, 
    id_product_fk BIGINT UNSIGNED NOT NULL,
    tim_date_issue TIMESTAMP DEFAULT NOW() COMMENT "Fecha de emisión"
    -- dec_subtotal DECIMAL UNSIGNED NOT NULL COMMENT "Subtotal suma de cada uno de los artículos según su cantidad",
    -- dec_iva DECIMAL(3,2) UNSIGNED DEFAULT 0.15 COMMENT "Impuesto",
    -- dec_total_pay DECIMAL UNSIGNED NOT NULL COMMENT "El total a pagar",
    -- dec_total_paid DECIMAL UNSIGNED NOT NULL COMMENT "El total pagado por parte del cliente",
    -- dec_change DECIMAL DEFAULT 0.0 COMMENT "Cambio, vuelto"

) COMMENT "Factura";

CREATE TABLE InvoiceDetail(
    id SERIAL, 
    id_invoice_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foranea de la entidad Factura", 
    id_inventory_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave Foranea de la entidad Inventario", 
    sma_quantity SMALLINT UNSIGNED DEFAULT 1 COMMENT "Cantidad de los productos que comprará",
    -- dec_total_product DECIMAL UNSIGNED COMMENT "Total por la cantidad de producto y el precio del producto",

    PRIMARY KEY(id, id_invoice_fk),

    FOREIGN KEY (id_invoice_fk) REFERENCES Invoice(id),
    FOREIGN KEY (id_inventory_fk) REFERENCES Inventory(id)
) COMMENT "Detalles de la factura que incluye la información de la cantidad de productos a comprar";


--
--  Orden | Orden de clientes, orden de empresa y orden al proveedor
--

CREATE TABLE GeneralOrder(
    id SERIAL PRIMARY KEY, 
    -- id_client_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Empleado",
    id_invoice_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Factura",
    tex_number_order TINYTEXT NOT NULL COMMENT "Número de orden", 
    tim_delivery_date TIMESTAMP NOT NULL COMMENT "Orden de entrega del producto",

    FOREIGN KEY (id_invoice_fk) REFERENCES Invoice(id)
    -- FOREIGN KEY (id_client_fk) REFERENCES Client(id)
)COMMENT = "Pedidos que realizan los distintos tipos de clientes (empresarial, cliente)";

CREATE TABLE CustomerOrder (
    id SERIAL PRIMARY KEY, 
    id_client_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Cliente",
    id_generalOrder_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad General order",

    FOREIGN KEY (id_client_fk) REFERENCES Client(id),
    FOREIGN KEY (id_generalOrder_fk) REFERENCES GeneralOrder(id)
) COMMENT ="Relación muchos a muchos entre las entidades Customer y Order";

CREATE TABLE BusinessOrder (
    id SERIAL PRIMARY KEY, 
    id_business_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Cliente",
    id_generalOrder_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad General order",

    FOREIGN KEY (id_business_fk) REFERENCES Business(id),
    FOREIGN KEY (id_generalOrder_fk) REFERENCES GeneralOrder(id)
) COMMENT ="Relación muchos a muchos entre las entidades Business y Order";


CREATE TABLE SupplierOrder(
    id SERIAL PRIMARY KEY, 
    id_supplier_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Proveedor",
    id_inventory_fk BIGINT UNSIGNED NOT NULL COMMENT "Clave foránea que relaciona esta entidad con la entidad Inventario",
    
    tex_number_order TINYTEXT NOT NULL COMMENT "Número de orden",
    sma_quantity SMALLINT UNSIGNED NOT NULL COMMENT "Cantidad de productos a encargar",
    tim_order_date TIMESTAMP DEFAULT NOW() COMMENT "Fecha en que se realiza la orden",
 
    FOREIGN KEY (id_inventory_fk) REFERENCES Inventory(id),
    FOREIGN KEY (id_supplier_fk) REFERENCES Supplier(id)
) COMMENT "Orden de pedidos que realiza la empresa a los Proveedores cada vez que el inventario se agota"; 