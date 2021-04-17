/*
    @author kenneth.cruz@unah.hn
    @version 0.1.0
    @date 17/04/2021
*/

--
-- Laptop
--
CREATE VIEW vw_Laptop AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Computer.sma_storage, "GB", Portable.dec_diagonal, "") AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        Computer.tex_processor AS CPU,
        Computer.sma_ram AS RAM,
        Computer.sma_storage AS Almacenamiento,
        Portable.dec_diagonal AS Diagonal,
        Laptop.tex_graphic AS Grafica,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio
  --      
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
        Inventory ON Product.id = Inventory.id_product_fk 
;

--
-- Celular
--
CREATE VIEW vw_Celulares AS
    SELECT 
        CONCAT(Manufacturer.tex_brand, " ", Computer.sma_storage, "GB", Smartphone.sma_front_camera, "MP") AS Titulo,
        Manufacturer.tex_brand AS Marca,
        Product.tex_model AS Modelo,
        Product.tex_description AS Descripcion,
        Computer.tex_processor AS CPU,
        Computer.sma_ram AS RAM,
        Computer.sma_storage AS Almacenamiento,
        Portable.dec_diagonal AS Diagonal,
        Smartphone.sma_rear_camera AS Trasera,
        Smartphone.sma_front_camera AS Frontal,
        Smartphone.sma_battery AS Bateria,
        JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS Foto,
        CONCAT('L. ', FORMAT(Inventory.dec_purchase_price, '#,#'), '.00')  AS Precio
  --      
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
        Inventory ON Product.id = Inventory.id_product_fk 
;

--
-- Portátil
--