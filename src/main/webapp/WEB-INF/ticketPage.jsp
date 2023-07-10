<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${theTicket.getTicketKey()}</title>
<link rel="icon" type="image/x-icon" href="/img/favicon.ico">
<script src="https://kit.fontawesome.com/cda43cd265.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

  
	<!-- NAVIGATIONAL BAR -->
	<nav class="navbar navbar-expand-lg fixed-top px-5">
		<div class="container-fluid">
				<a class="navbar-brand" href="/">
					<img src="/img/navbar-logo-actualsize.png" alt="Agile Ninja Logo" class="navbar-img pe-2">
				</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
					<div class="navbar-nav">
						<button type="button" class="new-proj-btn btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#staticBackdropNewProj">New Project</button>
						<button type="button" class="new-proj-btn btn btn-primary me-3" data-bs-toggle="modal" data-bs-target="#staticBackdropNewTick">New Ticket</button>
						<a class="nav-link" href="/dashboard">Dashboard</a>
						<a class="nav-link" href="#">Profile</a>
						
					</div>
				</div>

				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input class="btn btn-secondary" type="submit" value="Logout!" />
				</form>
		</div>
	</nav>

	<main class="main-content px-5 mx-5 mb-5">

		<!-- NEW PROJECT FORM -->
		<div id="staticBackdropNewProj" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<!-- MODAL CONTENT -->
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">Create new Project</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form:form id="projectCreation" method="POST" action="/project/new" modelAttribute="newProject">
							
							<p><form:errors path="project.*"/></p>

							<p>
								<form:label path="projectName" class="me-1">Project Name</form:label> 
								<form:input path="projectName" placeholder="Most Awesome Project" required="true" class="ps-1"/>
							</p>
							<p>
								<form:label path="projectKey" class="me-1">Project Key</form:label> 
								<i class="tooltip-lc fa-sharp fa-solid fa-circle-info me-3"><span class="tooltiptext-lc p-2 px-4">Choose a descriptive prefix for your project’s issue keys to recognize work from this project.</span></i>
								<form:input path="projectKey" minlength="2" maxlength="3" style="text-transform:uppercase" required="true" placeholder="MAP"/>
							</p>
											
							<!-- Hidden Field/s -->
							<form:input path="projectOwner" value="${currentUser.getId()}" hidden="true"/>
							
							<div class="modal-footer">
								<!-- <a href="#" onclick="closeFormNewProj()">cancel</a> -->
								<button type="button" class="btn btn-link" data-bs-dismiss="modal">Cancel</button>
								<input class="btn btn-primary" for="projectCreation" type="submit" value="Create"/>
							</div>
						</form:form>
					</div>

				</div>
			</div>
		</div>
		

		<!-- NEW TICKET FORM -->
		<div id="staticBackdropNewTick" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">Create new Ticket</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<form:form id="ticketCreation" method="POST" action="/ticket/new" modelAttribute="newTicket">
							<p><form:errors path="ticket.*"/></p>
				
							<div class="input-group mb-3">
								<form:label class="input-group-text" path="project">Project</form:label>
								<form:select path="project" class="form-select">
									<form:option value="-" label="--Please Select a Project--"/>
									<form:options items="${existingProjects}" itemValue="id" itemLabel="projectName"/>
								</form:select>
							</div>

							<div class="input-group mb-3">
								<form:label class="input-group-text" path="ticketName">Title</form:label>
								<form:input class="form-control" path="ticketName" type="text"/>
							</div>

							<div class="input-group mb-3">
								<form:label class="input-group-text" path="assignee">Assignee</form:label>
								<form:select class="form-select" path="assignee">
									<c:forEach var="user" items="${allUsers}">
										<form:option value="${user.getId()}"><c:out value="${user.firstName} ${user.lastName} (${user.getUsername()})"/></form:option>
									</c:forEach>
								</form:select>
							</div>

							<div class="input-group mb-3">
								<form:label class="input-group-text" path="ticketSeverity">Severity</form:label>
								<form:select class="form-select" path="ticketSeverity">
									<form:options items="${severities}" itemValue="id" itemLabel="issueSeverity"/>
								</form:select>
							</div>

							<div class="input-group mb-3">
								<form:label class="input-group-text" path="ticketPriority">Priority</form:label>
								<form:select class="form-select" path="ticketPriority">
									<form:options items="${priorities}" itemValue="id" itemLabel="issuePriority"/>
								</form:select>
							</div>

							<div class="input-group mb-3">
								<form:label class="input-group-text" path="ticketType">Type</form:label>
								<form:select class="form-select" path="ticketType">
									<form:options items="${types}" itemValue="id" itemLabel="issueType"/>
								</form:select>
							</div>

							<div class="form-floating">
								<form:textarea class="form-control" placeholder="Make your ticket descriptive" path="ticketDescription" style="height: 150px"></form:textarea>
								<form:label path="ticketDescription">Description</form:label>
							</div>
							
							<!-- Hidden Field/s -->
							<form:input path="reporter" type="text" value="${currentUser.getId()}" hidden="true" />
							<form:input path="ticketStatus" value="${backlog.getId()}" hidden="true"/>


							<div class="modal-footer">
								<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
								<input for="ticketCreation" class="btn btn-primary" type="submit" value="Create"/>
							</div>

						</form:form>
					</div>
				</div>
			</div>
		</div>




		<!-- BREADCRUMB -->
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
			<li class="breadcrumb-item"><a href="/?proj=${theTicket.getProject().getProjectKey()}&type=&status=&prio=&severity=&assigned=">${theTicket.getProject().getProjectName()}</a></li>
			<li class="breadcrumb-item active" aria-current="page">${theTicket.getTicketKey()}</li>
			</ol>
		</nav>




		<!-- DISPLAY/EDIT FORM 2 in 1 -->
		<div id="edit-mode-lc">

			<!-- START OF FORM TAG -->
			<form:form id="issuePropForm" method="POST" action="/ticket/${theTicket.getId()}/edit" modelAttribute="theTicket">
				
			<div class="d-flex flex-row">

				<div>
					<h1 class="mb-3">${theTicket.getTicketKey()}: <form:input class="issuePropInputText input-txtfield" path="ticketName" value="${theTicket.getTicketName()}"/></h1>
					<h3>Description</h3>
					
					<form:textarea class="issuePropInputText form-control form-control-lc" path="ticketDescription" cols="125" rows="10" required="true"/>
				</div>

				<div>
					<div>
						<table>
							<tr>
								<td><p>Type:</p></td>
								<td>
									<p>
									<form:select class="issuePropDropdown dropdwn-type" path="ticketType">
										<form:options items="${types}" itemValue="id" itemLabel="issueType" />
									</form:select>
									</p>
								</td>
							</tr>
							<tr>
								<td><p>Status:</p></td>
								<td>
									<p>
									<form:select class="issuePropDropdown dropdwn-stat" path="ticketStatus">
										<form:options items="${statuses}" itemValue="id" itemLabel="issueStatus" />
									</form:select>
									</p>
								</td>
							</tr>
							<tr>
								<td><p>Priority:</p></td>
								<td>
									<p>
										<form:select class="issuePropDropdown dropdwn-prio" path="ticketPriority">
											<form:options items="${priorities}" itemValue="id" itemLabel="issuePriority" />
										</form:select>
									</p>
								</td>
							</tr>
							<tr>
								<td><p>Severity:</p></td>
								<td>
									<p>
										<form:select class="issuePropDropdown dropdwn-sev" path="ticketSeverity">
											<form:options items="${severities}" itemValue="id" itemLabel="issueSeverity" />
										</form:select>
									</p>
								</td>
							</tr>
						</table>
					</div>

					<hr>

					<div>

						<table>
							<tr>
								<td>
									<p class="me-2">Created By:</p>
								</td>
								<td>
									<!-- TO DO: REPLACE "USERNAME" TO "FIRSTNAME" + "LASTNAME" -->
									<p class="ms-1">${theTicket.getReporter().getUsername()}</p>
								</td>
							</tr>
							<tr>
								<td>
									<p>Assignee:</p>
								</td>
								<td>
									<p>
									<form:select class="issuePropDropdown" path="assignee">
										<form:options items="${allUsers}" itemValue="id" itemLabel="username" />
									</form:select>
									</p>
								</td>
							</tr>
						</table>

					</div>

					<hr>
					<div>
						<table>
							<tr>
								<td><p>Created:</p></td>
								<td><p class="ms-2">${theTicket.getCreatedAt()}</p></td>
							</tr>
							<tr>
								<td><p>Modified:</p></td>
								<td><p class="ms-2">${theTicket.getUpdatedAt()}</p></td>
							</tr>
						</table>
					</div>
				</div>
			</div>

				<!-- HIDDEN FIELDS -->
				<form:input path="reporter" value="${theTicket.getReporter().getId()}" hidden="true"></form:input>
				<form:input path="ticketKey" value="${theTicket.getTicketKey()}" hidden="true"></form:input>
				<form:input path="project" value="${theTicket.getProject().getId()}" hidden="true"></form:input>
				<input type="hidden" name="_method" value="put">

				<!-- <input type="submit" value="Update"> -->
			</form:form>
			<!-- END OF FORM TAG -->
			
		</div>




			<!-- COMMENT SECTION -->
			<div class="comment-section-lc">

				<h3>Comments: (${allComments.size()})</h3>
				<hr>
				<!-- COMMENT LIST -->
				<c:forEach var="theComment" items="${allComments}">

						<div class="comment-cont-lc">

							<div class="d-flex flex-row">
							<h5 class="me-1">${theComment.getUser().getUsername()}&nbsp;<span>${theComment.getCreatedAt()}</span></h5>
							<c:if test="${theComment.getUpdatedAt()!=null}">
								<i>- edited</i>
							</c:if>                
								<c:if test="${currentUser.equals(theComment.getUser())}">
								<button id="edit-cmt-btn${theComment.getId()}" class="ms-4 edit-comment-btn btn btn-outline-primary btn-sm" type="button">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
									<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
								  	</svg>
								</button>
								</c:if>
							</div>

							<p>${theComment.getText()}</p>

							<!-- INSERT EDIT COMMENT FORM HERE -->
							<c:if test="${currentUser.equals(theComment.getUser())}">
							<form:form class="edit-comment-form" method="POST" action="/ticket/${theTicket.getId()}/comment/${theComment.getId()}/edit" modelAttribute="theComment${theComment.id}"> 
								
									<p><form:textarea path="text" cols="60" /></p>


									<input type="submit" value="Save" class="btn btn-primary btn-sm">
									<button type="button" class="btn btn-outline-dark btn-sm canc-btn">Cancel</button>
									
										
									
									<!-- FIXED FIELDS TO HIDE -->
									<form:input path="user" value="${theComment.getUser().getId()}" hidden="true"></form:input>
									<form:input path="ticket" value="${theTicket.getId()}" hidden="true"></form:input>
									<input type="hidden" name="_method" value="put">

							</form:form>
							</c:if>
							
						
						</div>
					</c:forEach>
					
				

						<!-- NEW COMMENT FORM -->
						<form:form method="POST" action="/ticket/${theTicket.getId()}/comment/new" modelAttribute="newComment" class="mt-4"> 
						
							<form:label path="text"><h6>Add Comment:</h6></form:label>
							<p><form:textarea path="text" cols="60" /></p>

							<!-- FIXED FIELDS TO HIDE -->
							<form:input path="ticket" value="${theTicket.getId()}" hidden="true"></form:input>
							<form:input path="user" value="${currentUser.getId()}" hidden="true"></form:input>
							<input type="submit" class="btn btn-sm btn-outline-primary" value="Add" >
							<!-- POPUP ERROR -->
							<c:if test="${commentErrorMsg!=null}">
								<div class="alert alert-danger position-absolute" role="alert">
									${commentErrorMsg}
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</c:if>
						</form:form>
				
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
            DDT is aligned with Agile and Scrum principles actually doing more work with half the time spent.
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