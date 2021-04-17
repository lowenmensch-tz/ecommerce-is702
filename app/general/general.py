from flask import Flask, Blueprint, render_template, request, jsonify, url_for, redirect,session

import requests
import json
from mariaDB.dbConnection import *

general_bp = Blueprint("general_bp", __name__ , template_folder="templates/general", static_url_path="/static")
@general_bp.route("/")
def home():
    #session.clear() #Esta línea solo es de prueba para eliminar la session al logearse
    #Para obtener el valor de una variable en session se debe usar session['email']

    con = dbConnectionService() # Objeto de conexión hacia la base de datos
    con.connect()

    res = con.query("SELECT Product.tex_model AS 'Modelo', JSON_UNQUOTE(JSON_EXTRACT(Product.jso_link_photo, '$.photo1')) AS 'Foto', CONCAT('L. ', Inventory.dec_purchase_price, '.00')  AS 'Precio' FROM Product INNER JOIN Inventory ON Product.id = Inventory.id_product_fk LIMIT 12;") #Consulta para obtener los productos a mostrar
    print(len(res))
    return render_template("index.html", title="Home",products=res)

@general_bp.route("/search")
def search():
    query = request.args['keyword']
    products = requests.get("http://localhost:5000/api/products/groceries/"+query)
    return render_template("search_results.html",search_results={"products":products.json(), "number":len(products.json())}, title=query)

