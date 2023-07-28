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
	<link rel="icon" type="image/x-icon" href="/img/favicon.ico">
	<script src="https://kit.fontawesome.com/cda43cd265.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-light">

	<!-- NAVIGATIONAL BAR (NON-LOGGED) -->
	<nav class="navbar navbar-expand-lg fixed-top px-5">
		<div class="container-fluid">
				<a class="navbar-brand" href="/">
					<img src="/img/navbar-logo-actualsize.png" alt="Agile Ninja Logo" class="navbar-img">
				</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
					<div class="navbar-nav">
						<a class="nav-link" href="#">About</a>
						<a class="nav-link" href="#">Our Products</a>
						<a class="nav-link" href="#">Pricing</a>
						<a class="nav-link" href="#">Documentation</a>
					</div>
				</div>
		
		</div>
	  </nav>

	<main class="main-content px-5 mx-5 mb-5">

			<!-- <div class="input-group mb-3">
				<label class="input-group-text" for="regform-roles">
					Choose a role
				</label>
				<select id="regform-roles">
					<option value="user" selected>User</option>
					<option value="admin">Administrator</option>
				</select>
			</div> -->
			
			
			
			<div id="admin-regForm" class="d-flex justify-content-center mt-5">
				<div class="p-4 bg-secondary bg-opacity-10 rounded-3 border border-dark border-2">
					<h2 class="mb-4"><i class="fa-solid fa-user-plus ms-1 me-3"></i>Registration</h2>
					<h5>Create an Admin Account for your Organization</h5>
					<form:form id="adminRegistration" method="POST" action="/registrationAdmin" modelAttribute="user">
					<p><form:errors path="user.*"/></p>
					<p>${registrationMessageError}</p>
						
	
						<div class="row g-3 mb-3">
							<div class="col">
								<form:input path="firstName" class="form-control" placeholder="First Name" aria-label="First name"/>
							</div>
							<div class="col">
								<form:input path="lastName" class="form-control" placeholder="Last Name" aria-label="Last name"/>
							</div>
						</div>
		
						<div class="input-group mb-3">
							<span class="input-group-text" id="basic-addon1">Email</span>
							<form:input path="email" class="form-control" placeholder="your@example.com" aria-label="Email" aria-describedby="basic-addon1"/>
						</div>
						
						<div class="mb-3">
							<form:input path="username" class="form-control" placeholder="Username" aria-label="Username"/>
						</div>
	
						<div class="row g-3 mb-3">
							<div class="col">
								<form:password path="password" class="form-control" placeholder="Password" aria-label="Password"/>
							</div>
							<div class="col">
								<form:password path="confirm" class="form-control" placeholder="Confirm Password" aria-label="Confirm"/>
							</div>
						</div>					
						
						<input type="submit" for="adminRegistration" value="Register!" class="btn btn-lg btn-info me-4"/>
						<a href="/">back to Main Page</a>
					</form:form>

				</div>
			</div>
	</main>



	<!-- FOOTER -->
	<footer class="footer-distributed pt-4">
		<div class="footer-left">
			<h3><img src="/img/navbar-logo-actualsize.png" alt="Agile Ninja Logo" class="footer-brand-img"></h3>
			<p class="footer-links">
			<a href="#" class="link-1">Home</a>
			<a href="#">Blog</a>
			<a href="#">Pricing</a>
			<a href="#">About</a>
			<a href="#">FAQ</a>
			<a href="#">Contact</a>
			</p>
			<p class="footer-company-name">Dojo Dev Technologies © 2023</p>
		</div>
		<div class="footer-center">
			<div>
			<i class="fa fa-map-marker"></i>
			<p><span>123 Baywalk Boulevard</span> Manila, PH</p>
			</div>
			<div>
			<i class="fa fa-phone"></i>
			<p>+63.555.555.5555</p>
			</div>
			<div>
			<i class="fa fa-envelope"></i>
			<p><a href="mailto:support@dojodev.com">support@dojodev.com</a></p>
			</div>
		</div>
		<div class="footer-right">
			<p class="footer-company-about">
			<span>About the company</span>
			Founded in 2023, Dojo Dev Technologies (DDT) provides the software industry to efficiently deliver their products. 
            DDT is aligned with Agile and Scrum principles.
			</p>
			<div class="footer-icons">
			<a href="#"><i class="fa fa-facebook"></i></a>
			<a href="#"><i class="fa fa-twitter"></i></a>
			<a href="#"><i class="fa fa-linkedin"></i></a>
			<a href="#"><i class="fa fa-github"></i></a>
			</div>
		</div>
	</footer>




	<!-- JS SCRIPT -->
	<!-- NOTE: INSERT THE JQUERY SCRIPT FIRST BEFORE THE LOCAL JS FILE -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
	<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <script src="/js/app.js"></script>
</body>
</html>