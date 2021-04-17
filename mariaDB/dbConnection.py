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
