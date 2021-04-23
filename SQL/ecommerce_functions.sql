/*
    @author kenneth.cruz@unah.hn
    @version 0.1.1
    @date 21/04/2021
*/

USE Ecommerce;
SET GLOBAL log_bin_trust_function_creators = 1;
--
-- último usuario creado
--

DROP FUNCTION IF EXISTS fn_getLastUserCreated;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastUserCreated() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        User
                    ORDER BY 
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;


--
-- último 'persona' creado
--

DROP FUNCTION IF EXISTS fn_getLastPersonCreated;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastPersonCreated() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        Person
                    ORDER BY 
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;


--
-- último cliente creado
--

DROP FUNCTION IF EXISTS fn_getLastClientCreated;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastClientCreated() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        Client
                    ORDER BY 
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;


--
-- último cliente EMPRESARIAL creado
--

DROP FUNCTION IF EXISTS fn_getLastBusinessCreated;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastBusinessCreated() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        Business
                    ORDER BY
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;


--
-- último dirección creada
--

DROP FUNCTION IF EXISTS fn_getLastAddressCreated;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastAddressCreated() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        Address
                    ORDER BY
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;

--
-- Match con el país
--

DROP FUNCTION IF EXISTS fn_getCountry;

DELIMITER $$
    
    CREATE FUNCTION fn_getCountry(country TEXT) RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        CASE
                            WHEN country  IN (
                                SELECT 
                                    tex_name
                                FROM 
                                    Country
                            ) THEN (
                                SELECT 
                                    id
                                FROM 
                                    Country
                                WHERE 
                                    tex_name = country
                            )

                            ELSE 92
                        END
                )
            ;
    END $$

DELIMITER ;



--
-- última factura creada
--

DROP FUNCTION IF EXISTS fn_getLastInvoice;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastInvoice() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        Invoice
                    ORDER BY
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;


--
-- Trae el id del Producto que se encuentra en el inventario
--

DROP FUNCTION IF EXISTS fn_getIdInventoryProduct;

DELIMITER $$
    
    CREATE FUNCTION fn_getIdInventoryProduct(id_product BIGINT UNSIGNED) RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        Inventory
                    WHERE 
                        id_product_fk = id_product
                )
            ;
    END $$

DELIMITER ;


--
-- Trae el id del usuario a partir del correo
--

DROP FUNCTION IF EXISTS fn_getIdByEmail;

DELIMITER $$
    
    CREATE FUNCTION fn_getIdByEmail(email VARCHAR(40)) RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        Users.id
                    FROM 
                        User
                    INNER JOIN 
                        (
                            (
                                SELECT 
                                    id, 
                                    id_user_fk
                                FROM 
                                    Business
                            )
                            UNION 
                            (
                                SELECT 
                                    Client.id AS id,
                                    Person.id_user_fk AS id_user_fk
                                FROM 
                                    Person
                                INNER JOIN 
                                    Client ON Person.id = Client.id_person_fk
                            )

                        ) AS Users  ON User.id = Users.id_user_fk
                    WHERE 
                        User.tex_email = email
                )
            ;
    END $$

DELIMITER ;


--
-- última orden creada
--

DROP FUNCTION IF EXISTS fn_getLastGeneralOrder;

DELIMITER $$
    
    CREATE FUNCTION fn_getLastGeneralOrder() RETURNS BIGINT UNSIGNED
    BEGIN 
        RETURN (
                    SELECT 
                        id
                    FROM 
                        GeneralOrder
                    ORDER BY
                        id DESC
                    LIMIT 1
                )
            ;
    END $$

DELIMITER ;
