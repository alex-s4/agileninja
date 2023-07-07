<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

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
		
                <button type="button" class="btn btn-primary me-3 btn-lg" data-bs-toggle="modal" data-bs-target="#staticBackdropLogin">Login</button>
                <button type="button" class="btn btn-warning me-3 btn-lg reg-btn">Register for FREE</button>
		</div>
	  </nav>

    <main class="main-content px-5 mx-5 me-5">
        
        <!-- LOGIN FORM MODAL -->
        <div class="modal fade" id="staticBackdropLogin" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Login</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="POST" action="/login">
                            <p>
                                <label for="username">Username</label>
                                <input type="text" id="username" name="username"/>
                            </p>
                            <p>
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password"/>
                            </p>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="modal-footer">
                            <input type="submit" value="Login!"/>
                            <a href="/registration">Register!</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- POP UP MESSAGES -->
        <c:if test="${errorMessage!=null}">
            <div class="alert alert-danger position-absolute" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${logoutMessage!=null}">
            <div class="alert alert-success position-absolute" role="alert">
                ${logoutMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${registrationMessageSuccess!=null}">
            <div class="alert alert-success position-absolute" role="alert">
                ${registrationMessageSuccess}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- JUMBOTRON -->
        <div class="p-5 mb-4 rounded-3 jbt-main-bkg">
            <div class="container-fluid py-5">
                <h1 class="display-5 fw-bold">The Future of Project Management</h1>
                <p class="col-md-8 fs-4">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Magni quae quisquam odio.</p>
                <button type="button" class="btn btn-primary me-3 btn-lg reg-btn">Know more!</button>
            </div>
        </div>
        
    </main>


    <!-- FOOTER -->
	<footer class="footer-distributed pt-4 mt-5">
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
			Agile Ninja is a multi-purpose project management and ticketing tool where teams collaborate on projects and
			organize tasks in a productive way.
			</p>
			<div class="footer-icons">
			<a href="#"><i class="fa fa-facebook"></i></a>
			<a href="#"><i class="fa fa-twitter"></i></a>
			<a href="#"><i class="fa fa-linkedin"></i></a>
			<a href="#"><i class="fa fa-github"></i></a>
			</div>
		</div>
	</footer>


    <!-- JS FILE -->
    <!-- NOTE: INSERT THE JQUERY SCRIPT FIRST BEFORE THE LOCAL JS FILE -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <script src="/js/app.js"></script>
</body>
</html>