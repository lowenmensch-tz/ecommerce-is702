from flask import Flask, Blueprint, render_template, request, jsonify, url_for, redirect,session

import requests
import json
general_bp = Blueprint("general_bp", __name__ , template_folder="templates/general", static_url_path="/static")
@general_bp.route("/")
def home():
    #session.clear() #Esta línea solo es de prueba para eliminar la session al logearse
    #Para obtener el valor de una variable en session se debe usar session['email']
    return render_template("index.html", title="Home")

@general_bp.route("/search")
def search():
    query = request.args['keyword']
    products = requests.get("http://localhost:5000/api/products/groceries/"+query)
    return render_template("search_results.html",search_results={"products":products.json(), "number":len(products.json())}, title=query)

