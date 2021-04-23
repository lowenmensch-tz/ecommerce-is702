/*
    @author kenneth.cruz@unah.hn
    @version 0.1.2
    @date 17/04/2021
*/


USE Ecommerce;

--
-- Laptop
--

DROP VIEW IF EXISTS vw_laptops;
CREATE VIEW vw_laptops AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Computer.sma_storage, "GB, ", Portable.dec_diagonal, "\ ", OperativeSystem.tex_name, " ", VersionOS.tex_name) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Computer.tex_processor AS CPU,
        Computer.sma_ram AS RAM,
        Computer.sma_storage AS Almacenamiento,
        Portable.dec_diagonal AS Diagonal,
        Laptop.tex_graphic AS Grafica,
        OperativeSystem.tex_name AS OS
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN  
        Computer ON Product.id = Computer.id_product_fk 
    INNER JOIN 
        Portable ON Computer.id = Portable.id_computer_fk
    INNER JOIN 
        Laptop ON Portable.id = Laptop.id_portable_fk
    INNER JOIN 
        VersionOS ON Portable.id_version_os_fk = VersionOS.id
    INNER JOIN
        OperativeSystem ON VersionOS.id_operative_system_fk = OperativeSystem.id
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;

--
-- Celular
--

DROP VIEW IF EXISTS vw_celulares;
CREATE VIEW vw_celulares AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Computer.sma_storage, "GB ", Smartphone.sma_front_camera, "MP") AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Computer.tex_processor AS CPU,
        Computer.sma_ram AS RAM,
        Computer.sma_storage AS Almacenamiento,
        Portable.dec_diagonal AS Diagonal,
        Smartphone.sma_rear_camera AS Trasera,
        Smartphone.sma_front_camera AS Frontal,
        Smartphone.sma_battery AS Bateria,
        OperativeSystem.tex_name AS OS
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN  
        Computer ON Product.id = Computer.id_product_fk 
    INNER JOIN 
        Portable ON Computer.id = Portable.id_computer_fk
    INNER JOIN 
        Smartphone ON Portable.id = Smartphone.id_portable_fk
    INNER JOIN 
        VersionOS ON Portable.id_version_os_fk = VersionOS.id
    INNER JOIN
        OperativeSystem ON VersionOS.id_operative_system_fk = OperativeSystem.id
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;


--
-- Escritorio
--

DROP VIEW IF EXISTS vw_escritorio;
CREATE VIEW vw_escritorio AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Computer.sma_storage, "GB ", Desktop.cod_format) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Computer.tex_processor AS CPU,
        Computer.sma_ram AS RAM,
        Computer.sma_storage AS Almacenamiento,
        Desktop.cod_format AS Formato,
        Desktop.tex_color AS Color
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN  
        Computer ON Product.id = Computer.id_product_fk 
    INNER JOIN 
        Desktop ON Computer.id = Desktop.id_computer_fk
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;

--
-- Consola
--

DROP VIEW IF EXISTS vw_consolas;
CREATE VIEW vw_consolas AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Computer.sma_storage, "GB ", Console.cod_type) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Computer.tex_processor AS CPU,
        Computer.sma_ram AS RAM,
        Computer.sma_storage AS Almacenamiento,
        Console.tex_accessory AS Accesorio,
        Console.cod_type AS Tipo
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN  
        Computer ON Product.id = Computer.id_product_fk 
    INNER JOIN 
        Console ON Computer.id = Console.id_computer_fk
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;


--
-- Televisor
--

DROP VIEW IF EXISTS vw_televisores;
CREATE VIEW vw_televisores AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Interface.cod_panel_technology, " ", Interface.cod_resolution) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Interface.cod_panel_technology AS Panel,
        Interface.dec_diagonal AS Diagonal,
        Interface.cod_resolution AS Resolucion
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN  
        Interface ON Product.id = Interface.id_product_fk 
    INNER JOIN 
        Tv ON Interface.id = Tv.id_interface_fk
    INNER JOIN 
        VersionOS ON Tv.id_version_os_fk = VersionOS.id
    INNER JOIN
        OperativeSystem ON VersionOS.id_operative_system_fk = OperativeSystem.id
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;

--
-- Monitores
--

DROP VIEW IF EXISTS vw_monitores;
CREATE VIEW vw_monitores AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Interface.cod_panel_technology, " ", Interface.cod_resolution, " ", Monitor.sma_refresh_rate, " HZ") AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Interface.cod_panel_technology AS Panel,
        Interface.dec_diagonal AS Diagonal,
        Interface.cod_resolution AS Resolucion,
        Monitor.dec_response_time AS Ratio,
        Monitor.sma_refresh_rate AS Rate
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN  
        Interface ON Product.id = Interface.id_product_fk 
    INNER JOIN 
        Monitor ON Interface.id = Monitor.id_interface_fk
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;


--
-- Impresoras
--

DROP VIEW IF EXISTS vw_impresoras;
CREATE VIEW vw_impresoras AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Printer.cod_type) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Printer.cod_type AS Tipo,
        Printer.tex_print_size AS 'Dimensiones impresión',
        Printer.sma_print_speed AS 'Velocidad impresión'
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN 
        Printer ON Product.id = Printer.id_product_fk 
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;


--
-- Tarjetas gráficas
--

DROP VIEW IF EXISTS vw_graficas;
CREATE VIEW vw_graficas AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", GraphicCard.sma_memory, " GB ", GraphicCard.cod_memory_type) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        GraphicCard.sma_cores AS Cores,
        GraphicCard.sma_memory AS VRAM,
        GraphicCard.cod_memory_type AS Tipo
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN 
        GraphicCard ON Product.id = GraphicCard.id_product_fk 
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;



--
-- Accesorios
--

DROP VIEW IF EXISTS vw_accesorios;
CREATE VIEW vw_accesorios AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Accessory.tex_type) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Accessory.tex_type AS Tipo
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN 
        Accessory ON Product.id = Accessory.id_product_fk 
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id 
;


--
-- Teatro en casa 
--

DROP VIEW IF EXISTS vw_teatro;
CREATE VIEW vw_teatro AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Audio.sma_power, "Watts") AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Audio.sma_power AS Watts,
        HomeTheater.tex_port AS Puerto
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN 
        Audio ON Product.id = Audio.id_product_fk 
    INNER JOIN 
        HomeTheater ON Audio.id = HomeTheater.id_audio_fk 
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id 
;

--
-- Audio
--

DROP VIEW IF EXISTS vw_audiosistema;
CREATE VIEW vw_audiosistema AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Audio.sma_power, "Watts ", AudioSystem.tex_format_reproduction) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Audio.sma_power AS Watts,
        AudioSystem.tex_format_reproduction AS 'Formato reproducción'
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN 
        Audio ON Product.id = Audio.id_product_fk 
    INNER JOIN 
        AudioSystem ON Audio.id = AudioSystem.id_audio_fk 
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk 
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id
;


--
-- Parlante inalámbrico
--

DROP VIEW IF EXISTS vw_inalambrico;
CREATE VIEW vw_inalambrico AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Audio.sma_power, "Watts ", IF(PortableSpeaker.bit_water_resistant=1, "Resistente al agua", "")  ) AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio,  
        Inventory.med_quantity AS Cantidad, 
        Product.id AS id, 
        Category.tex_category AS Categoria,

        Audio.sma_power AS Watts,
        PortableSpeaker.tim_battery AS Bateria
    FROM 
        Manufacturer
    INNER JOIN 
        Product ON Manufacturer.id = Product.id_manufacturer_fk
    INNER JOIN 
        Audio ON Product.id = Audio.id_product_fk 
    INNER JOIN 
        PortableSpeaker ON Audio.id = PortableSpeaker.id_audio_fk 
    INNER JOIN 
        Inventory ON Product.id = Inventory.id_product_fk
    INNER JOIN 
        Category ON Product.id_category_fk = Category.id 
;
DROP VIEW IF EXISTS vw_informationProduct;
CREATE VIEW vw_informationProduct AS 
    (
        select 
            `vw_celulares`.`Titulo` AS `Titulo`,`vw_celulares`.`Foto` AS `Foto`,`vw_celulares`.`Precio` AS `Precio`,`vw_celulares`.`Categoria` AS `Categoria`,`vw_celulares`.`id` AS `id` 
        from `Ecommerce`.`vw_celulares`
    ) 
        union 
    (
        select 
            `vw_laptops`.`Titulo` AS `Titulo`,`vw_laptops`.`Foto` AS `Foto`,`vw_laptops`.`Precio` AS `Precio`,`vw_laptops`.`Categoria` AS `Categoria`,`vw_laptops`.`id` AS `id` 
        from `Ecommerce`.`vw_laptops`
    ) 
        union 
    (
        select 
            `vw_monitores`.`Titulo` AS `Titulo`,`vw_monitores`.`Foto` AS `Foto`,`vw_monitores`.`Precio` AS `Precio`,`vw_monitores`.`Categoria` AS `Categoria`,`vw_monitores`.`id` AS `id` 
        from `Ecommerce`.`vw_monitores`
    ) 
    union 
    (
        select 
            `vw_escritorio`.`Titulo` AS `Titulo`,`vw_escritorio`.`Foto` AS `Foto`,`vw_escritorio`.`Precio` AS `Precio`,`vw_escritorio`.`Categoria` AS `Categoria`,`vw_escritorio`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_escritorio`
    ) 
    union 
    (
        select 
            `vw_consolas`.`Titulo` AS `Titulo`,`vw_consolas`.`Foto` AS `Foto`,`vw_consolas`.`Precio` AS `Precio`,`vw_consolas`.`Categoria` AS `Categoria`,`vw_consolas`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_consolas`
    ) 
    union 
    (
        select 
            `vw_televisores`.`Titulo` AS `Titulo`,`vw_televisores`.`Foto` AS `Foto`,`vw_televisores`.`Precio` AS `Precio`,`vw_televisores`.`Categoria` AS `Categoria`,`vw_televisores`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_televisores`
    ) 
    union 
    (
        select 
            `vw_monitores`.`Titulo` AS `Titulo`,`vw_monitores`.`Foto` AS `Foto`,`vw_monitores`.`Precio` AS `Precio`,`vw_monitores`.`Categoria` AS `Categoria`,`vw_monitores`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_monitores`
    ) 
    union 
    (
        select 
            `vw_impresoras`.`Titulo` AS `Titulo`,`vw_impresoras`.`Foto` AS `Foto`,`vw_impresoras`.`Precio` AS `Precio`,`vw_impresoras`.`Categoria` AS `Categoria`,`vw_impresoras`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_impresoras`
    ) 
    union 
    (
        select 
            `vw_graficas`.`Titulo` AS `Titulo`,`vw_graficas`.`Foto` AS `Foto`,`vw_graficas`.`Precio` AS `Precio`,`vw_graficas`.`Categoria` AS `Categoria`,`vw_graficas`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_graficas`
    ) 
    union 
    (
        select 
            `vw_accesorios`.`Titulo` AS `Titulo`,`vw_accesorios`.`Foto` AS `Foto`,`vw_accesorios`.`Precio` AS `Precio`,`vw_accesorios`.`Categoria` AS `Categoria`,`vw_accesorios`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_accesorios`
    ) 
    union 
    (
        select 
            `vw_teatro`.`Titulo` AS `Titulo`,`vw_teatro`.`Foto` AS `Foto`,`vw_teatro`.`Precio` AS `Precio`,`vw_teatro`.`Categoria` AS `Categoria`,`vw_teatro`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_teatro`
    ) 
    union 
    (
        select 
            `vw_audiosistema`.`Titulo` AS `Titulo`,`vw_audiosistema`.`Foto` AS `Foto`,`vw_audiosistema`.`Precio` AS `Precio`,`vw_audiosistema`.`Categoria` AS `Categoria`,`vw_audiosistema`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_audiosistema`
    ) 
    union 
    (
        select 
            `vw_inalambrico`.`Titulo` AS `Titulo`,`vw_inalambrico`.`Foto` AS `Foto`,`vw_inalambrico`.`Precio` AS `Precio`,`vw_inalambrico`.`Categoria` AS `Categoria`,`vw_inalambrico`.`id` AS `id` 
        from 
            `Ecommerce`.`vw_inalambrico`
    ) 
;
