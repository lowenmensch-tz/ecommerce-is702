SELECT 
					CONCAT(
							Address.tex_street_address, ", ",
							Address.tex_number_street, ", ",
							Address.tex_zip, ", ",
							Address.tex_city, ", ",
							Address.tex_state
					) AS Address
				FROM 
					User 
				INNER JOIN 
					(
						(
						SELECT 
							Person.id AS id, 
							Person.id_user_fk AS id_user_fk
						FROM 
							Person 
						INNER JOIN 
							Client ON Person.id_user_fk = Client.id
						)
						UNION 
						(
							SELECT 
								id,
								id_user_fk
							FROM 
								Business
						)
					) AS Clients ON User.id = Clients.id_user_fk
				INNER JOIN 
					(
						(
						SELECT 
							id_client_fk AS id, 
							id_address_fk
						FROM
							AddressClient
						)
						UNION
						(
							SELECT 
								id_business_fk AS id, 
								id_address_fk
							FROM
								AddressBusiness
						)    
					)
					AS Addresses ON Clients.id = Addresses.id
				INNER JOIN 
					Address ON Addresses.id_address_fk = Address.id
				WHERE 
					User.tex_email = "alexis_danielGT@hotmail.com"
				;
