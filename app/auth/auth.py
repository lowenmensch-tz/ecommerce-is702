from flask import Blueprint, Flask , jsonify, render_template, session, request, redirect, url_for, flash
from .forms import RegistrationForm, LoginForm
auth_bp = Blueprint("auth_bp", __name__, template_folder="templates/auth")
import string
import secrets
from mariaDB.dbConnection import *

@auth_bp.route("/login", methods=["GET", "POST"])
def main():
	if request.method == "POST":
		form = LoginForm()
		email = request.form['email']
		password = request.form['password']

		con = dbConnectionService()

		user = con.query(""" 
			SELECT 
				CASE 
					WHEN tex_email = '%s' &&  tex_password = '%s' THEN 1
					ELSE 0
				END
			FROM 
				User
			;
			""" % (email,password)
		)

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

				#con.DMSQuery("INSERT INTO User(tex_email, tex_password, cod_rol) VALUES('%s', '%s', 2)  ; "%(email,password))

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
		
		return "Eula"
	else:
		s = string.ascii_lowercase
		trackingNumber = ''.join(secrets.choice(s) for i in range(16)).upper() # Generado utilizando la librería Secret para que no se repita

		return render_template("process_payment.html", title="Process payment", track=trackingNumber)