from flask import Blueprint, Flask , jsonify, render_template, session, request, redirect, url_for, flash
from .forms import RegistrationForm, LoginForm
auth_bp = Blueprint("auth_bp", __name__, template_folder="templates/auth")
import string
import secrets
from mariaDB.dbConnection import *
import re

@auth_bp.route("/login", methods=["GET", "POST"])
def main():
	if request.method == "POST":
		form = LoginForm()
		email = request.form['email']
		password = request.form['password']

		con = dbConnectionService()

		user = con.query("SELECT COUNT(*) FROM User WHERE tex_email='%s' && tex_password='%s';" % (email,password))

		print(user[0][0])
		if user[0][0] == 1:
			session['email'] = email
			return redirect(url_for("general_bp.home"))
		else:
			flash('El Usuario o Contraseña son Incorrectos!')
			return redirect("/auth/login")

	return render_template("login.html", title="Login")

@auth_bp.route("/logout")
def logout():
	session.clear()
	return redirect("/")

@auth_bp.route("/register", methods=["GET","POST"])
def signup():
	if request.method == "POST":
		form = LoginForm()

		try:
			fname = request.form['fname']
			lname = request.form['lname']
			email = request.form['email']
			gender = str(request.form['gender']).lower()
			country = request.form['fCountry']
			city = request.form['fCity']
			street = request.form['fcalle']
			streetNumber = request.form['fNumeroCalle']
			state = request.form['fEstado']
			zipCode = request.form['fZip']
			idNumber = request.form['idNumber']
			creditCardNumber = request.form['creditCard']
			CSV = request.form['fCVC']
			expireDate = str(request.form['fCaducidad'])+"-01"
			phone = request.form['fPhoneNumber']
			birthDate = request.form['fBirthDate']
			password = request.form['password']
			rPassword = request.form['rPassword']

			if password == rPassword:

				con = dbConnectionService()

				con.DMSQuery("INSERT INTO User(tex_email, tex_password, cod_rol) VALUES('%s','%s', 1);"  % (email,password))

				con.DMSQuery("""
					INSERT INTO Person(id_user_fk, tex_dni, tex_first_name, tex_last_name, cod_gender, tim_birthday) VALUES
							(
								fn_getLastUserCreated(),
								'%s',
								'%s',
								'%s',
								'%s',
								'%s'
							)
						;""" % (idNumber,fname,lname,gender,birthDate))

				con.DMSQuery("INSERT INTO Client(id_person_fk, id_country_fk) VALUES(fn_getLastPersonCreated(),fn_getCountry('%s'));" % country )

				con.DMSQuery("""
										INSERT INTO CreditCard(id_client_fk, tex_number, tim_expiration_date, tex_code) VALUES
											(
												fn_getLastClientCreated(),
												'%s',
												'%s',
												'%s'
											)
										;""" % (creditCardNumber,expireDate,CSV))

				con.DMSQuery("""
										INSERT INTO Address(tex_street_address, tex_number_street, tex_zip, tex_city, tex_state) VALUES 
											( 
												'%s',
												'%s',
												'%s',
												'%s',
												'%s'
											)
										;""" % (street,streetNumber,zipCode,city,state))
				
				con.DMSQuery("INSERT INTO AddressClient(id_client_fk, id_address_fk) VALUES(fn_getLastClientCreated(),fn_getLastAddressCreated());")

				return redirect(url_for("auth_bp.main"))
			else:
				flash('Las contraseñas no coinciden!')
				return render_template("signup.html", title ="register")

		except:

			bussinessName = request.form['fNombreEmpresa']
			email = request.form['email']
			country = request.form['fCountry']
			city = request.form['fCity']
			street = request.form['fcalle']
			streetNumber = request.form['fNumeroCalle']
			state = request.form['fEstado']
			zipCode = request.form['fZip']
			RTNnumber = request.form['RTNnumber']
			accountNumber = request.form['fAccount']
			phone = request.form['fTelefono']
			password = request.form['password']
			rPassword = request.form['rPassword']
		
			if password == rPassword:

				con = dbConnectionService()

				con.DMSQuery("INSERT INTO User(tex_email, tex_password, cod_rol) VALUES('%s', '%s', 2)  ; "%(email,password))

				con.DMSQuery("""
        			INSERT INTO Business(id_user_fk, id_country_fk, tex_name, tex_rtn, tex_bankAccount) VALUES
					(
						fn_getLastUserCreated(),
						fn_getCountry('%s'),
						'%s',
						'%s',
						'%s' 
					)
				; 
				"""%(country,bussinessName,RTNnumber,accountNumber))


				con.DMSQuery(  
					"""
						INSERT INTO Address(tex_street_address, tex_number_street, tex_zip, tex_city, tex_state) VALUES 
							(
								'%s',
								'%s',
								'%s',
								'%s',
								'%s'
							)
						;
					"""%(street,streetNumber,zipCode,city,state)
				)


				con.DMSQuery(  
					"""
						INSERT INTO AddressBusiness(id_business_fk, id_address_fk) VALUES
							(
								fn_getLastBusinessCreated(), 
								fn_getLastAddressCreated()   
							)
						;
					"""
				)

				return redirect(url_for("auth_bp.main"))
			else:
				flash('Las contraseñas no coinciden!')
				return render_template("signup.html", title ="register")
	else:
		return render_template("signup.html", title ="register")

@auth_bp.route("/forgot_password", methods=["GET", "POST"])
def forgot_pass():
	return render_template("forgot_password.html", title="forgot password")

@auth_bp.route("/process_payment", methods=["GET","POST"])
def process_payment():
	if request.method == "POST":
		email = session['email']
		trackingNumber = session['trackingNumber']
		con = dbConnectionService()

		products = session['shoppingCart']
		total = 0

		for product in products:
			p = con.query("SELECT * FROM vw_%s WHERE id = '%s';" % (product[2],product[0]))[0]
			price = re.sub("(L\.)|(,)","",str(p[5])).strip() # Limpiar el valor del precio
			subtotal = float(price)*float(product[1])
			product.append(subtotal)
			total = total + subtotal

		ISV = total*0.15
		totalAPagar = total + ISV

		# Inserciones en la base de datos
		con.DMSQuery(
			"""
				INSERT INTO Invoice(tex_number_order ,dec_totalPaid ) VALUES 
					('%s', %s)
				;
			"""%(trackingNumber,totalAPagar)
		)

		for product in products:
			# 0: id, 1: cantidad, 2: categoría, 3: total

			# Insertar cada Producto comprado en la base de datos
			con.DMSQuery(
				"""
					INSERT INTO InvoiceDetail(id_invoice_fk, id_inventory_fk, sma_quantity, dec_totalPrice) VALUES
					(
						fn_getLastInvoice(),
						fn_getIdInventoryProduct(%s), 
						%s, 
						%s
					)
				;
				"""%(product[0],product[1],product[3])
			)

			# Actualizar el Inventario
			con.DMSQuery(
				"""
				UPDATE Inventory 
				SET med_quantity = med_quantity - %s
				WHERE id = fn_getIdInventoryProduct('%s')
				"""%(product[1],product[0])
			)

		con.DMSQuery(
			"""
				INSERT INTO GeneralOrder(id_invoice_fk, tim_delivery_date) VALUES
					(
						fn_getLastInvoice(),
						'%s'
					)
				;
			"""%("2025-01-01")
		)

		if session['userType'] == 1:

			con.DMSQuery(
				"""
					INSERT INTO CustomerOrder(id_client_fk, id_generalOrder_fk) VALUES 
						(
							fn_getIdByEmail('%s'), 
							fn_getLastGeneralOrder()
						)
					;
				"""%(email)
			)
		else:
			con.DMSQuery(
				"""
					INSERT INTO BusinessOrder(id_business_fk, id_generalOrder_fk) VALUES 
					(
						fn_getIdByEmail('%s'), 
						fn_getLastGeneralOrder()
					)
					;
				"""%(email)
			)

		# Reinicio de variables en Sesión 
		session['cartCounter'] = 0
		session['shoppingCart'] = []

		return redirect("/")
		#return "Eula"
	else:

		if session.get('email') is None:
			flash('Debe Iniciar Sesión para Realizar el Pago')
			return redirect("/auth/login")
		else:
			s = string.ascii_lowercase
			trackingNumber = ''.join(secrets.choice(s) for i in range(16)).upper() # Generado utilizando la librería Secret para que no se repita
			session['trackingNumber'] = trackingNumber

			email = session['email']

			con = dbConnectionService()

			userType = (con.query(
				"""
					SELECT 
						CASE
							WHEN cod_rol = "cliente" THEN 1
							WHEN cod_rol = "empresa" THEN 2
							WHEN cod_rol = "empleado" THEN 3
							WHEN cod_rol = "administrador" THEN 4
						END
					FROM 
						User
					WHERE 
						tex_email = '%s' 
				; 
				""" % (email))[0][0]
			)

			session['userType'] = userType

			if userType == 1:
			
				paymentInfo = (con.query(
					"""
						SELECT 
							SUBSTRING(
								CreditCard.tex_number, -4
							) AS number
						FROM
							User 
						INNER JOIN 
							Person ON User.id = Person.id_user_fk
						INNER JOIN 
							Client ON Person.id = Client.id_person_fk
						INNER JOIN
							CreditCard ON Client.id  = CreditCard.id_client_fk 
						WHERE 
							User.tex_email = '%s'
						;
					""" % (email))[0][0]
				) 

				name = (con.query(
				"""
					SELECT 
						CONCAT(
							tex_first_name, 
							" ",
							tex_last_name
						) AS name
					FROM 
						User
					INNER JOIN 
						Person ON User.id = Person.id_user_fk
					WHERE 
						User.tex_email = '%s'
					;
				""" % (email))[0][0]
				)

				print(paymentInfo)
				print(name)

			elif userType == 2:
				
				paymentInfo = (con.query(
					"""
					SELECT 
						Business.tex_bankAccount AS bank
					FROM
						User 
					INNER JOIN 
						Business ON User.id = Business.id_user_fk
					WHERE 
						User.tex_email = '%s'
					;
					""" % (email))[0][0]
				) 

				name = (con.query(
					"""
						SELECT 
							Business.tex_name AS name
						FROM
							User
						INNER JOIN
							Business ON User.id = Business.id_user_fk
						WHERE 
							User.tex_email = '%s'
						;
					""" % (email))[0][0]
				)

				print(paymentInfo)
				print(name)
			
			address = (con.query(
				"""
					SELECT 
						CONCAT(
								Address.tex_street_address, ", ",
								Address.tex_number_street, ", ",
								Address.tex_zip, ", ",
								Address.tex_city, ", ",
								Address.tex_state
						) AS Address, 
						Address.id
					FROM 
						User 
					INNER JOIN 
						(
							(
								SELECT 
									Person.id_user_fk AS id_user_fk, 
									AddressClient.id_address_fk AS id_address_fk
								FROM 
									Person 
								INNER JOIN 
									Client ON Person.id = Client.id_person_fk
								INNER JOIN 
									AddressClient ON  Client.id = AddressClient.id_client_fk
								WHERE 
									Person.id IN (
												SELECT 
													id_person_fk
												FROM 
													Client
									) 
							)
							UNION 
							(
								SELECT 
									Business.id_user_fk AS id_user_fk,
									AddressBusiness.id_address_fk AS id_address_fk
								FROM 
									Business
								INNER JOIN 
									AddressBusiness ON Business.id = AddressBusiness.id_business_fk
							)
						) AS Addresses ON User.id = Addresses.id_user_fk
					INNER JOIN 
						Address ON Addresses.id_address_fk = Address.id
					WHERE 
						User.tex_email = '%s'
					;
				""" % (email))[0][0]
			)

			print(address)

			products = session['shoppingCart']
			total = 0

			for product in products:
				p = con.query("SELECT * FROM vw_%s WHERE id = '%s';" % (product[2],product[0]))[0]
				price = re.sub("(L\.)|(,)","",str(p[5])).strip() # Limpiar el valor del precio
				subtotal = float(price)*float(product[1])
				total = total + subtotal

			ISV = total*0.15
			totalAPagar = total + ISV
			
			return render_template("process_payment.html", title="Process payment", address=address, track=trackingNumber, userType=userType, paymentInfo=paymentInfo, name=name, total=total, ISV=ISV, totalAPagar=totalAPagar)