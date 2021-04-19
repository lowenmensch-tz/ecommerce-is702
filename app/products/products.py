from flask import Flask , Blueprint , render_template, jsonify, request, abort ,redirect, url_for
from app.models import Product
from mariaDB.dbConnection import *
products_bp = Blueprint("products_bp", __name__, template_folder="templates/products")


@products_bp.route("/<product>")
def main(product):

	product_name = product
	product = Product(product)

	con = dbConnectionService() # Objeto de conexión hacia la base de datos
	con.connect() #Conexión hacia la base de datos

	#Consulta para obtener todos los productos en la categoría
	
	product_items = con.query("SELECT * FROM vw_%s" %  product_name ) 

	# Paginación
	page = int(request.args.get("page") or 1)
	previous = page - 1
	start = previous * 8
	end = start + 8

	if product_items is None:
		abort(404)
	else:
		return render_template("list.html", products= product_items[start:end], title=product_name , length=len(product_items))

	
	
@products_bp.route("/<product>/<product_id>")
def view_product(product, product_id):

	#product = Product(product)
	
	con = dbConnectionService() # Objeto de conexión hacia la base de datos
	con.connect() #Conexión hacia la base de datos

	product_items = con.query( "SELECT * FROM vw_%s WHERE id = '%s';"%( product.strip(), product_id.strip() ) ) # Consulta para obtener los datos del producto

	quantity = product_items[0][6]

	# Se modifica la cantidad de stock en caso que sea demasiado grande
	if product_items[0][6]  > 10:
		quantity = 10


	if len( product_items ) == 0:
		abort(404)
	else:
		return render_template(
			"view.html", 
			results= list(product_items[0]),  
			title=product_items[0][0], 
			quantity=quantity
			) 

@products_bp.route("/view")
def view():
	id = int(request.args.get("id"))
	product = Product()
	product_items = product.show_all_items()
	product_items = [dict(p) for p in product_items if p['id'] == id]
	print(product_items)
	return render_template("view.html", 
			results={"item":product_items},
			title="Product View"
			)

