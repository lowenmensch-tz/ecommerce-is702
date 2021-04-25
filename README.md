# Proyecto de la clase Analisis y Diseño de Sistemas
## Seccion 1801
Integrantes
- Alexis Daniel Ochoa 20161002139
- Kenneth Leonel Cruz 20141010391
- Marco Tulio Ruiz 20171006559
- Andres Alberto Zuniga 20161003850

# Instrucciones para correr el Programa
## Instalar MariaDB
Descarga he instalacion
```Bash
sudo apt update
sudo apt install mariadb-server
```
Iniciar y configurar el servidor
```Bash
sudo /etc/init.d/mysql start
sudo mysql_secure_installation
```
correrlo
```Bash
sudo mysql -u root -p
```

## Instalar PIP, Vitualenv y Flask
Para instalar Pip utilizamos el comando dependiendo nuestra version de python de preferencia utilizar python3

```Bash
sudo apt install python3-pip
```
ahora instalamos en virtualenv con ayuda de pip
```Bash
sudo pip3 install virtualenv 
```
con todo esto nos ubucamos en la raiz del proyecto y activamos el virtual env con el siguiente comando y luego procedemos a instalar flask
```Bash
source venv/bin/activate
sudo apt install python3-flask
```
para poder hacer las conecciones a MariaDB tenemos que descargar la libreria necesaria
```bash
sudo apt-get install libmariadbclient-dev
pip3 install mariadb
pip3 install Flask-WTF 
pip3 install email_validator
pip3 install flask_cors
sudo apt-get install python3-mysql.connector
```
## Variables de ejecucion
- para poder correr flask en el entorno virtual hay que guardar en una variable globlal el nombre del archivo principal donde esta la instancia de flask en este caso el main desde la consola de linux
```bash
export FLASK_APP=app.py
```
- otra variable que se puede activar es la debug que sirve para que la pagina se refresque cuando hay cmabios en el codigo sin tener que estar reiniciando el servidor y tambien mostrara en el servidor los errores generados
```bash
export FLASK_DEBUG=1
```
## Correr el proyecto
con todo lo demas configurado solo se corre la instruccion
``` bash
flask run
```
