from flask import Blueprint, render_template, session
cart_bp = Blueprint("cart_bp", __name__, template_folder = "templates")
from mariaDB.dbConnection import *
import re

@cart_bp.route("/items")
def listItems():
	products = session['shoppingCart']
	shoppingList = []
	quantities = []
	con = dbConnectionService()
	con.connect()
	total = 0

	print(products)

	for product in products:
		p = con.query("SELECT * FROM vw_%s WHERE id = '%s';" % (product[2],product[0]))[0]
		price = re.sub("(L\.)|(,)","",str(p[5])).strip() # Limpiar el valor del precio
		subtotal = float(price)*float(product[1])
		total = total + subtotal
		quantities.append((product[1],subtotal,product[0]))
		shoppingList.append(p)
	
	itemCount = len(shoppingList)

	return render_template("cart/items.html",title="Shopping List",items=shoppingList,cant=quantities,len=itemCount,tot=total)
	
	#return ("Eula")

