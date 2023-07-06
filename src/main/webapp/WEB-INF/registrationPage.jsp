<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Register</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body>

	<!-- NAVIGATIONAL BAR (NON-LOGGED) -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary fixed-top px-5">
		<div class="container-fluid">
				<a class="navbar-brand" href="/">
					<img src="/img/navbar-logo-actualsize.png" alt="Agile Ninja Logo" class="navbar-img">
				</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
					<div class="navbar-nav">
					<a class="nav-link active" aria-current="page" href="/dashboard">Home</a>
					<a class="nav-link" href="#">Products</a>
					<a class="nav-link" href="#">Pricing</a>
					<a class="nav-link disabled">Disabled</a>
					</div>
				</div>
		
		</div>
	  </nav>

	<main class="main-content px-5">

			<div class="input-group mb-3">
				<label class="input-group-text" for="regform-roles">
					Choose a role
				</label>
				<select id="regform-roles">
					<!-- <option selected>-- Choose a role --</option> -->
					<option value="user" selected>User</option>
					<option value="admin">Administrator</option>
				</select>
			</div>
			
			<div id="user-regForm">
				<h1>Register as User!</h1>
				
				<form:form id="userRegistration" method="POST" action="/registration" modelAttribute="user">
				
				<p><form:errors path="user.*"/></p>
					<p>
						<form:label path="firstName">First Name:</form:label>
						<form:input path="firstName"/>
					</p>
					<p>
						<form:label path="lastName">Last Name:</form:label>
						<form:input path="lastName"/>
					</p>
					<p>
						<form:label path="email">Email:</form:label>
						<form:input path="email"/>
					</p>
					<p>
						<form:label path="username">Username:*</form:label>
						<form:input path="username"/>
					</p>
					<p>
						<form:label path="password">Password:*</form:label>
						<form:password path="password"/>
					</p>
					<p>
						<form:label path="confirm">Password Confirmation:*</form:label>
						<form:password path="confirm"/>
					</p>
					<p>* - Required</p>
					<input for="userRegistration" type="submit" value="Register!"/>
				</form:form>
			</div>
			
			<div id="admin-regForm">
				<h1>Register as Administrator!</h1>
				<form:form id="adminRegistration" method="POST" action="/registrationAdmin" modelAttribute="user">
				<p><form:errors path="user.*"/></p>
				<p>${registrationMessageError}</p>
					<p>
						<form:label path="firstName">First Name:</form:label>
						<form:input path="firstName"/>
					</p>
					<p>
						<form:label path="lastName">Last Name:</form:label>
						<form:input path="lastName"/>
					</p>
					<p>
						<form:label path="email">Email:</form:label>
						<form:input path="email"/>
					</p>
					<p>
						<form:label path="username">Username:*</form:label>
						<form:input path="username"/>
					</p>
					<p>
						<form:label path="password">Password:*</form:label>
						<form:password path="password"/>
					</p>
					<p>
						<form:label path="confirm">Password Confirmation:*</form:label>
						<form:password path="confirm"/>
					</p>
					<p>* - Required</p>
					<input type="submit" for="adminRegistration" value="Register as Admin!"/>
				</form:form>
			</div>
	</main>


	<!-- JS SCRIPT -->
	<!-- NOTE: INSERT THE JQUERY SCRIPT FIRST BEFORE THE LOCAL JS FILE -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <script src="/js/app.js"></script>
</body>
</html>