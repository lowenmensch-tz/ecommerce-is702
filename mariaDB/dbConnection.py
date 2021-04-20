"""
    @author LxrDev
    @date 22/03/2021
    @version 1.0

"""
import mariadb
import configparser

class dbConnectionService:

    def __init__(self):
        config = configparser.ConfigParser()
        config.read('mariaDB/dbServerConfig.ini')

        self.host = config['mariadb']['host']
        self.port = int(config['mariadb']['port'])
        self.user = config['mariadb']['user']
        self.password = config['mariadb']['password']
        self.database = config['mariadb']['database']

    def connect(self):     
        try:
            self.connection = mariadb.connect(
                host = self.host,
                port = self.port,
                user = self.user,
                password = self.password,
                database = self.database
            )
            self.cursor = self.connection.cursor()

            print('Connection Stablished to MariaDB')

        except mariadb.Error as e:
            print(f"Error connecting to MariaDB: {e}")


    def query(self,sqlQuery):
        
        self.connect()
        self.cursor.execute(sqlQuery)
        result = self.cursor.fetchall()
        self.connection.close()
        return  result
            
    def DMSQuery(self,sqlQuery):
        self.connect()
        self.cursor.execute(sqlQuery)
        self.connection.commit()
        print('Success!')
        self.connection.close()

    
    #Coincidencia de productos 
    def findAllProduct(self, search):

        query = """
            SELECT 
                Product.id AS id, 
                vw_informationProduct.Titulo AS Title,
                JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, "$.photo1")) AS Photo,
                vw_informationProduct.Precio AS Price,
                vw_informationProduct.Categoria AS Category
            FROM 
                Product
            INNER JOIN 
                vw_informationProduct ON Product.id = vw_informationProduct.id
            WHERE 
                MATCH (Product.tex_model, Product.tex_description)
                AGAINST ('{}' IN NATURAL LANGUAGE MODE)
            ;
        """.format( search )

        return self.query( sqlQuery=query )