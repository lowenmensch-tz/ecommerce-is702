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
		print(email)
		print(password)
		
		session['email'] = email
		return redirect(url_for("general_bp.home"))
	return render_template("login.html", title="Login")

@auth_bp.route("/register", methods=["GET","POST"])
def signup():
	if request.method == "POST":
		form = LoginForm()
		try:

			fname = request.form['fname'].trim()
			lname = request.form['lname'].trim()
			email = request.form['email'].trim()
			gender = request.form['gender'].trim()
			country = request.form['fCountry'].trim()
			city = request.form['fCity'].trim()
			street = request.form['fcalle'].trim()
			streetNumber = request.form['fNumeroCalle'].trim()
			state = request.form['fEstado'].trim()
			zipCode = request.form['fZip'].trim()
			idNumber = request.form['idNumber'].trim()
			creditCardNumber = request.form['creditCard'].trim()
			CSV = request.form['fCVC'].trim()
			expireDate = request.form['fCaducidad'].trim()
			phone = request.form['fPhoneNumber'].trim()
			birthDate = request.form['fBirthDate'].trim()
			password = request.form['password'].trim()
			rPassword = request.form['rPassword'].trim()

			if password == rPassword:

							con = dbConnectionService()
				con.connect()

				con.DMSQuery(
					"""
						INSERT INTO User(tex_email, tex_password, cod_rol) VALUES
						(%s, %s, 1); 

						INSERT INTO Person(id_user_fk, tex_dni, tex_first_name, tex_last_name, cod_gender, tim_birthday) VALUES
							(
								fn_getLastUserCreated(),
								%s,
								%s,
								%s,
								%s,
								%s
							)
						;

						INSERT INTO Client(id_person_fk, id_country_fk) VALUES
							(
								fn_getLastPersonCreated(),
								fn_getCountry(%s)
							)
						;

						INSERT INTO CreditCard(id_client_fk, tex_number, tim_expiration_date, tex_code) VALUES
							(
								fn_getLastClientCreated(),
								%s,
								%s,
								%s
							)
						;


						INSERT INTO Address(tex_street_address, tex_number_street, tex_zip, tex_city, tex_state) VALUES 
							( 
								%s,
								%s,
								%s,
								%s,
								%s
							)
						;
						INSERT INTO AddressClient(id_client_fk, id_address_fk) VALUES
							(
								fn_getLastClientCreated(),
								fn_getLastAddressCreated()
							)
						;
					""" % (
						email,
						password,
						idNumber,
						fname,
						lname,
						gender,
						birthDate,
						country,
						creditCardNumber,
						expireDate,
						CSV,
						street,
						streetNumber,
						zipCode,
						city,
						state
					)
				)

				return redirect(url_for("auth_bp.main"))
			else:
				flash('Las contraseñas no coinciden!')
				return render_template("signup.html", title ="register")

		except:

			session['userType'] = 1 # El tipo de Usuario es un Asociado

			bussinessName = request.form['fNombreEmpresa'].trim()
			email = request.form['email'].trim()
			country = request.form['fCountry'].trim()
			city = request.form['fCity'].trim()
			street = request.form['fcalle'].trim()
			streetNumber = request.form['fNumeroCalle'].trim()
			state = request.form['fEstado'].trim()
			zipCode = request.form['fZip'].trim()
			RTNnumber = request.form['RTNnumber'].trim()
			accountNumber = request.form['fAccount'].trim()
			phone = request.form['fTelefono'].trim()
			password = request.form['password'].trim()
			rPassword = request.form['rPassword'].trim()
		
			if password == rPassword:
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