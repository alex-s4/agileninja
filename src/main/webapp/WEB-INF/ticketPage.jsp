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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

  
	<!-- NAVIGATIONAL BAR -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary fixed-top px-5">
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

	<main class="main-content px-5">

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
										<form:label path="projectName">Project Name *</form:label>
										<form:input path="projectName" required="true"/>
									</p>
									<p>
										<form:label path="projectKey">Project Key *</form:label>
										<form:input path="projectKey" minlength="2" maxlength="3" style="text-transform:uppercase" required="true"/>
									</p>
									
									<p>* - Required</p>
									
									<!-- Hidden Field/s -->
									<form:input path="projectOwner" value="${currentUser.getId()}" hidden="true"/>
									
									<div class="modal-footer">
										<!-- <a href="#" onclick="closeFormNewProj()">cancel</a> -->
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
										<input class="btn btn-primary" for="projectCreation" type="submit" value="Create"/>
									</div>
								</form:form>
							</div>

						</div>
					</div>
				</div>
				

				<!-- NEW TICKET FORM -->
				<div id="staticBackdropNewTick" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="staticBackdropLabel">Create new Ticket</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>

							<div class="modal-body">
								<form:form id="ticketCreation" method="POST" action="/ticket/new" modelAttribute="newTicket">
									<p><form:errors path="ticket.*"/></p>
						
									<p>
										<form:label path="project">Project*</form:label>
										<form:select path="project">
											<form:option value="-" label="--Please Select a Project--"/>
											<form:options items="${existingProjects}" itemValue="id" itemLabel="projectName"/>
										</form:select>
									</p>
									<p>
										<form:label path="ticketName">Title</form:label>
										<form:input path="ticketName" type="text"/>
									</p>
									<p>
										<form:label path="assignee">Assignee</form:label>
										<form:select path="assignee">
											<c:forEach var="user" items="${allUsers}">
												<form:option value="${user.getId()}"><c:out value="${user.firstName} ${user.lastName} (${user.getUsername()})"/></form:option>
											</c:forEach>
										</form:select>
									</p>
									<p>
										<form:label path="ticketSeverity">Severity</form:label>
										<form:select path="ticketSeverity">
											<form:options items="${severities}" itemValue="id" itemLabel="issueSeverity"/>
										</form:select>
									</p>
									<p>
										<form:label path="ticketPriority">Priority</form:label>
										<form:select path="ticketPriority">
											<form:options items="${priorities}" itemValue="id" itemLabel="issuePriority"/>
										</form:select>
									</p>
									<p>
										<form:label path="ticketType">Type</form:label>
										<form:select path="ticketType">
											<form:options items="${types}" itemValue="id" itemLabel="issueType"/>
										</form:select>
									</p>
									<p>
										<form:label path="ticketDescription">Description</form:label>
										<form:textarea path="ticketDescription"></form:textarea>
									</p>
									<p>* - Required</p>
									<!-- Hidden Field/s -->
									<form:input path="reporter" type="text" value="${currentUser.getId()}" hidden="true" />
									<form:input path="ticketStatus" value="${backlog.getId()}" hidden="true"/>


									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
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
					

					<h1>${theTicket.getTicketKey()}: <form:input class="issuePropInputText input-txtfield" path="ticketName" value="${theTicket.getTicketName()}"/></h1>
					<h3>Description</h3>
					<form:textarea class="issuePropInputText form-control form-control-lc" path="ticketDescription" cols="75" rows="10" />
					
					<div>
						<p><span>Type:</span>
						<form:select class="issuePropDropdown" path="ticketType">
							<form:options items="${types}" itemValue="id" itemLabel="issueType" />
						</form:select>
						</p>
						<p><span>Status:</span>
						<form:select class="issuePropDropdown" path="ticketStatus">
							<form:options items="${statuses}" itemValue="id" itemLabel="issueStatus" />
						</form:select>
						</p>
						<p><span>Priority:</span>
						<form:select class="issuePropDropdown" path="ticketPriority">
							<form:options items="${priorities}" itemValue="id" itemLabel="issuePriority" />
						</form:select>
						</p>
						<p><span>Severity:</span>
						<form:select class="issuePropDropdown" path="ticketSeverity">
							<form:options items="${severities}" itemValue="id" itemLabel="issueSeverity" />
						</form:select>
						</p>
					</div>
					<hr>
					<div>
						<p><span>Created By:</span>${theTicket.getReporter().getUsername()}</p>

						<p><span>Assignee:</span>
						<form:select class="issuePropDropdown" path="assignee">
							<form:options items="${allUsers}" itemValue="id" itemLabel="username" />
						</form:select>
						</p>

					</div>
					<hr>
					<div>
						<p><span>Created:</span>${theTicket.getCreatedAt()}</p>
						<p><span>Modified:</span>${theTicket.getUpdatedAt()}</p>
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
				<!-- COMMENT LIST -->
				<c:forEach var="theComment" items="${allComments}">

						<div class="comment-cont-lc">

							<div class="d-flex flex-row">
							<h5 class="me-1">${theComment.getUser().getUsername()}&nbsp;<span>${theComment.getCreatedAt()}</span></h5>
							<c:if test="${theComment.getUpdatedAt()!=null}">
								<i>- edited</i>
							</c:if>                
								<c:if test="${currentUser.equals(theComment.getUser())}">
								<button id="edit-cmt-btn${theComment.getId()}" class="ms-4 edit-comment-btn" type="button">Edit</button>
								</c:if>
							</div>

							<p>${theComment.getText()}</p>

							<!-- INSERT EDIT COMMENT FORM HERE -->
							<c:if test="${currentUser.equals(theComment.getUser())}">
							<form:form class="edit-comment-form" method="POST" action="/ticket/${theTicket.getId()}/comment/${theComment.getId()}/edit" modelAttribute="theComment${theComment.id}"> 
								
									<p><form:textarea path="text" cols="60" /></p>


									<input type="submit" value="Save">
									<button type="button" class="canc-btn">Cancel</button>

									<!-- FIXED FIELDS TO HIDE -->
									<form:input path="user" value="${theComment.getUser().getId()}" hidden="true"></form:input>
									<form:input path="ticket" value="${theTicket.getId()}" hidden="true"></form:input>
									<input type="hidden" name="_method" value="put">

							</form:form>
							</c:if>
							
						
						</div>
					</c:forEach>
					
				

						<!-- NEW COMMENT FORM -->
						<form:form method="POST" action="/ticket/${theTicket.getId()}/comment/new" modelAttribute="newComment"> 
						
							<form:label path="text">Add Comment:</form:label>
							<p><form:textarea path="text" cols="60" /></p>

							<!-- FIXED FIELDS TO HIDE -->
							<form:input path="ticket" value="${theTicket.getId()}" hidden="true"></form:input>
							<form:input path="user" value="${currentUser.getId()}" hidden="true"></form:input>
							<input type="submit" value="Add">

						</form:form>
				
			</div>

	</main>
 

	<!-- JS FILE -->
	<!-- NOTE: INSERT THE JQUERY SCRIPT FIRST BEFORE THE LOCAL JS FILE -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
	<script src="/js/app.js"></script>
    
  </body>
</html>