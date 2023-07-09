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
    <script src="https://kit.fontawesome.com/cda43cd265.js" crossorigin="anonymous"></script>
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

                            <div class="input-group input-group-lg mb-3">
                                <span class="input-group-text"><label for="username">Username</label></span>
                                <input class="form-control" type="text" id="username" name="username"/>
                            </div>

                            <div class="input-group input-group-lg mb-3">
                                <span class="input-group-text"><label for="password">Password</label></span>
                                <input class="form-control" type="password" id="password" name="password"/>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="modal-footer">
                            <input class="btn btn-lg btn-primary" type="submit" value="Login!"/>
                            <a href="/registration">Sign up</a>
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
                <h1 class="display-5 fw-bold">We build things that helps build things</h1>
                <p class="col-md-8 fs-4">In Agile Ninja&trade;, we have the ability to get things done incrementally and respond to change.</p>
                <button type="button" class="btn btn-info mt-4 me-3 btn-lg reg-btn">Know more!</button>
            </div>
        </div>

        <div class="d-flex align-items-center">
            <div class="p-4 col-md-6 me-5 mb-4 rounded-3 border border-secondary">
                <div class="h-100 p-4 text-dark me-2">
                <h1 class="mb-3">What is Agile Ninja?</h1>
                <p class="fs-5">
                    Agile Ninja is a multi-purpose <strong>project management</strong> and <strong>ticketing tool</strong> where teams collaborate on projects and organize tasks in a productive and efficient way.
                    It strictly follows the principles of <a class="fw-bold" href="https://www.agilealliance.org/agile101/">Agile</a> and <a class="fw-bold" href="https://www.scrum.org/learning-series/what-is-scrum">Scrum</a> methodologies.
                </p>
                <!-- <button class="btn btn-primary" type="button">Try Now</button> -->
                </div>
            </div>
            
            <img src="/img/navbar-logo-actualsize.png" alt="Agile Ninja Logo" class="img-fluid img-landing">
        </div>
            

        
        

        <p class="h2 my-4 text-center">The Manifesto for Agile Software Development</p>

        <div class="container text-center">
            <div class="row">
                <div class="col">
                    <div class="card" style="width: 18rem;">
                        <img src="https://st4.depositphotos.com/1001201/39308/i/450/depositphotos_393085710-stock-photo-teamwork-of-partners-concept-of.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                          <h5 class="card-title">Individuals and interactions</h5>
                          <p class="card-text fst-italic">over processes and tools</p>
                          
                        </div>
                      </div>
                </div>
                <div class="col">
                    <div class="card" style="width: 18rem;">
                        <img src="https://media.istockphoto.com/id/1075599562/photo/programmer-working-with-program-code.jpg?s=612x612&w=0&k=20&c=n3Vw5SMbMCWW1YGG6lnTfrwndNQ8B_R4Vw-BN7LkqpA=" class="card-img-top" alt="...">
                        <div class="card-body">
                          <h5 class="card-title">Working software</h5>
                          <p class="card-text fst-italic">over comprehensive documentation</p>
                          
                        </div>
                      </div>
                </div>
                <div class="col">
                    <div class="card" style="width: 18rem;">
                        <img src="https://st.depositphotos.com/2309453/4248/i/450/depositphotos_42483789-stock-photo-smiling-young-man-shaking-hands.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                          <h5 class="card-title">Customer collaboration</h5>
                          <p class="card-text fst-italic">over contract negotiation</p>
                          
                        </div>
                      </div>
                </div>
                <div class="col">
                    <div class="card" style="width: 18rem;">
                        <img src="https://static7.depositphotos.com/1129853/676/i/450/depositphotos_6769050-stock-photo-process-arrow.jpg" class="card-img-top" alt="...">
                        <div class="card-body">
                          <h5 class="card-title">Responding to change</h5>
                          <p class="card-text fst-italic">over following a plan</p>
                          
                        </div>
                      </div>
                </div>
                
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
			organize tasks in a productive and efficient way.
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