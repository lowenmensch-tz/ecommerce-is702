from flask import Flask, Blueprint, render_template, request, jsonify, url_for, redirect,session

import requests
import json
import re
from mariaDB.dbConnection import *

general_bp = Blueprint("general_bp", __name__ , template_folder="templates/general", static_url_path="/static")
@general_bp.route("/")
def home():

    # Crear la sesión (si no existe) que cuente la cantidad de productos en el carrito de compras y que almacene la lista con los productos y cantidades

    if session.get('cartCounter') is None or session.get('shoppingCart') is None:
        session['cartCounter'] = 0
        session['shoppingCart'] = []

    con = dbConnectionService() # Objeto de conexión hacia la base de datos
    con.connect()
    
    #Modelo, foto, precio
    res = con.query("""
            (
                SELECT 
                    Titulo, 
                    Foto, 
                    Precio, 
                    Categoria, 
                    id
                FROM 
                    vw_celulares
                LIMIT 4
            )
            UNION 
            (
                SELECT 
                    Titulo, 
                    Foto, 
                    Precio, 
                    Categoria, 
                    id
                FROM 
                    vw_laptops
                LIMIT 4
            )
            UNION 
            (
                SELECT 
                    Titulo, 
                    Foto, 
                    Precio, 
                    Categoria,
                    id
                FROM 
                    vw_monitores
                LIMIT 4
            )
            ;
        """) #Consulta para obtener los productos a mostrar

    return render_template("index.html", title="Home",products=res)

@general_bp.route("/search")
def search():
    query = request.args['keyword']
    products = requests.get("http://localhost:5000/api/products/groceries/"+query)
    return render_template("search_results.html",search_results={"products":products.json(), "number":len(products.json())}, title=query)

# Ruta para agregar los productos en la sesión
@general_bp.route("/addToCart",methods = ['POST'])
def addToCart():

    # Obtener y limpiar los datos del post, se obtiene una lista con el id y la cantidad a comprar de ese producto
    data = re.sub("(b'idProduct=)|(cantidad=)|(categoria=)|(')","",str(request.get_data())).split("&")
    print(data)

    # Se aumenta la cantidad de productos en la sesión
    counter = int(session['cartCounter'])+1
    session['cartCounter'] = counter

    # Se agrega a la sesión el producto con su cantidad
    shoppingList = session['shoppingCart']
    shoppingList.append(data)
    session['shoppingCart'] = shoppingList

    return "True"

# Ruta para restar la cantidad de un producto en la sesión
@general_bp.route("/updateQuantity",methods = ['POST'])
def updateQuantity():
    products = session['shoppingCart']
    data = re.sub("(b'idProduct=)|(cantidad=)|(')","",str(request.get_data())).split("&")

    for i in range (0,len(products)):
        if products[i][0] == data[0]:
            products[i][1] = data[1]
            break
    session['shoppingCart'] = products
    return "Eula"

@general_bp.route("/deleteItem", methods = ['POST'])
def deleteItem():
    products = session['shoppingCart']
    data = re.sub("(b'idProduct=)|(')","",str(request.get_data())).split("&")

    for i in range (0,len(products)):
        if products[i][0] == data[0]:
            del products[i]
            break
    session['shoppingCart'] = products

    # Se disminuye la cantidad de productos en la sesión
    counter = int(session['cartCounter'])-1
    session['cartCounter'] = counter

    return "Eula"