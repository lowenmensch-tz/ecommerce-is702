from app.models import Product
import traceback
from flask import Flask , Blueprint, jsonify, request, abort
import time
from mariaDB.dbConnection import dbConnectionService
import json

ajax_bp = Blueprint("ajax_bp", __name__)

@ajax_bp.route("/search")
def search_query():
    jso = []

    con = dbConnectionService()
    query = request.args.get("query")

    result = con.findAllProduct(query)
    
    product = Product()
    product_items = product.show_all_items()

    if product_items: 
        [
            jso.append(
                {
                    "id":element[0],
                    "title":element[1],
                    "photo":element[2],
                    "price":element[3],
                    "category":element[4]
                }
            )
            for element in result
        ]
    
    print( jso )
    print( json.dumps(jso) )

    #return jsonify([dict(p) for p in product_items if p['name'].lower().startswith(query)])
    return jsonify( jso )