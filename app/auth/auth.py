from flask import Blueprint, Flask , jsonify, render_template, session, request, redirect, url_for, flash
from .forms import RegistrationForm, LoginForm
auth_bp = Blueprint("auth_bp", __name__, template_folder="templates/auth")

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
			CSV = request.form['fCSV'].trim()
			expireDate = request.form['fCaducidad'].trim()
			phone = request.form['fPhoneNumber'].trim()
			birthDate = request.form['fBirthDate'].trim()
			password = request.form['password'].trim()
			rPassword = request.form['rPassword'].trim()

			if password == rPassword:
				return redirect(url_for("auth_bp.main"))
			else:
				flash('Las contraseñas no coinciden!')
				return render_template("signup.html", title ="register")

		except:
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
  return render_template("process_payment.html", title="Process payment")