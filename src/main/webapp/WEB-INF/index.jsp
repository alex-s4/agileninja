<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - Agile Ninja</title>
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
						<a class="nav-link active" aria-current="page" href="/dashboard">Dashboard</a>
						<a class="nav-link" href="#">Profile</a>
						
					</div>
				</div>

				<div class="me-5">
					<a href="#" class="header-current-user-wholename"><i class="fa-solid fa-user-ninja me-2"></i> ${currentUser.getFullName()}</a>
				</div>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<button class="btn btn-danger" type="submit"><i class="fa-solid fa-arrow-right-from-bracket me-1"></i> Logout!</button>
				</form>
		</div>
	  </nav>
	
	
	<!-- MAIN CONTENT -->
	<main class="main-content px-5 mx-5  mb-5">
			<h2>Search for issues</h2>
						
			<c:if test="${newProjSuccess!=null}">
				<div class="alert alert-info position-absolute" role="alert">
					${newProjSuccess}
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>

			<!-- NEW PROJECT FORM -->
			<div id="staticBackdropNewProj" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog  modal-dialog-centered">
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
									<form:input class="ps-1" path="projectKey" minlength="2" maxlength="3" style="text-transform:uppercase" required="true" placeholder="MAP"/>
								</p>
												
								<!-- Hidden Field/s -->
								<form:input path="projectOwner" value="${currentUser.getId()}" hidden="true"/>
								
								<div class="modal-footer">
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
									<form:select path="project" class="form-select"  required="true">
										<form:option value="" label="-- Please Select a Project --" selected="true" disabled="true" />
										<c:forEach var="aProject" items="${existingProjects}">
											<form:option value="${aProject.getId()}"><c:out value="${aProject.getProjectName()} (${aProject.getProjectKey()})" /></form:option>
										</c:forEach>
									</form:select>
								</div>

								<div class="input-group mb-3">
									<form:label class="input-group-text" path="ticketName">Title</form:label>
									<form:input class="form-control" path="ticketName" type="text" required="true"/>
								</div>

								<div class="input-group mb-3">
									<form:label class="input-group-text" path="assignee">Assignee</form:label>
									<form:select class="form-select" path="assignee" required="true">
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
			

			<!-- FILTER SECTION -->
			<div>
					
					<div class="d-flex flex-row filter-checkbox-cont">
						<div class="d-flex flex-row justify-content-start">
							
							<!-- 1. PROJECT FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span class="me-2">Project</span>
									<span class="badge text-bg-dark filter-count-proj">${filterProjSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="project" items="${existingProjects}">
											<div class="form-check">
												<input class="form-check-input-proj" type="checkbox" value="${project.getProjectKey()}" id="proj${project.getId()}">
												<label class="form-check-label-proj" for="proj${project.getId()}">
													${project.getProjectName()} (${project.getProjectKey()})
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
								

							</div>

							<!-- 2. ISSUE TYPE FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span>Type</span>
									<span class="badge text-bg-secondary filter-count-type">${filterTypeSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="type" items="${types}">
											<div class="form-check">
												<input class="form-check-input-type" type="checkbox" value="${type.getIssueType()}" id="ty${type.getId()}">
												<label class="form-check-label-type" for="ty${type.getId()}">
													${type.getIssueType()}
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
							</div>

							<!-- 3. ISSUE STATUS FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span>Status</span>
									<span class="badge text-bg-secondary filter-count-stat">${filterStatSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="status" items="${statuses}">
											<div class="form-check">
												<input class="form-check-input-status" type="checkbox" value="${status.getIssueStatus()}" id="st${status.getId()}">
												<label class="form-check-label-status" for="st${status.getId()}">
													${status.getIssueStatus()}
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
							</div>

							<!-- 4. ISSUE PRIORITY FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span>Priority</span>
									<span class="badge text-bg-secondary filter-count-prio">${filterPrioSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="priority" items="${priorities}">
											<div class="form-check">
												<input class="form-check-input-priority" type="checkbox" value="${priority.getIssuePriority()}" id="pr${priority.getId()}">
												<label class="form-check-label-priority" for="pr${priority.getId()}">
													${priority.getIssuePriority()}
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
							</div>

							<!-- 5. ISSUE SEVERITY FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span>Severity</span>
									<span class="badge text-bg-secondary filter-count-sev">${filterSevSize}</span>
								</button>
								<ul class="dropdown-menu">
									<c:forEach var="severity" items="${severities}">
										<li>
											<div class="form-check">
												<input class="form-check-input-severity" type="checkbox" value="${severity.getIssueSeverity()}" id="sv${severity.getId()}">
												<label class="form-check-label-severity" for="sv${severity.getId()}">
													${severity.getIssueSeverity()}
												</label>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>

							<!-- 6. ISSUE ASSIGNEE FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span>Assignee</span>
									<span class="badge text-bg-secondary filter-count-ass">${filterAssSize}</span>
								</button>
								<ul class="dropdown-menu">
								<c:forEach var="user" items="${allUsers}">
									<li>
										
											<div class="form-check">
												<input class="form-check-input-assignee" type="checkbox" value="${user.getUsername()}" id="as${user.getId()}">
												<label class="form-check-label-assignee" for="as${user.getId()}">
													${user.getFirstName()} ${user.getLastName()}
												</label>
											</div>
										
									</li>
								</c:forEach>
								</ul>
							</div>

						</div>

						<div>
							<button class="btn btn-primary btn-sm" id="btn-submit-filter">Apply Filter</button>
							<!-- <button class="btn btn-outline-secondary btn-sm" id="btn-clear-filter">Clear Filter</button> -->
						</div>
					</div>
					
				
			</div>

			<!-- ISSUE TABLE -->
			<div>
				<table class="table table-hover">
					<thead>
						<tr class="table-secondary">
							<th scope="col">Key</th>
							<th scope="col">Type</th>
							<th scope="col">Issue Name</th>
							<th scope="col">Status</th>
							<th scope="col">Priority</th>
							<th scope="col">Severity</th>
							<th scope="col">Modified</th>
							<th scope="col">Assigned to</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ticket" items="${ticketsByProject}">
						<tr>
							<td>${ticket.getTicketKey()}</td>
							<td>${ticket.getTicketType().getIssueType()}</td>
							<td><a target="_blank" href="/ticket/${ticket.getTicketKey()}">${ticket.getTicketName()}</a></td>
							<td>${ticket.getTicketStatus().getIssueStatus()}</td>
							<td>${ticket.getTicketPriority().getIssuePriority()}</td>
							<td>${ticket.getTicketSeverity().getIssueSeverity()}</td>
							<c:if test="${ticket.getUpdatedAt()!=null}">
								<td>${ticket.getUpdatedAtFormattedDateOnly()}</td>
							</c:if>
							<c:if test="${ticket.getUpdatedAt()==null}">
								<td>${ticket.getCreatedAtFormattedDateOnly()}</td>
							</c:if>
							<td>${ticket.getAssignee().getFirstName()} ${ticket.getAssignee().getLastName()}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
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