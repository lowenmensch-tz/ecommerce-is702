/*
    @author kenneth.cruz@unah.hn
    @version 0.1.1
    @date 21/04/2021
*/

USE Ecommerce;

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