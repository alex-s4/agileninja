<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Agile Ninja | Search for issues</title>
<link rel="icon" type="image/x-icon" href="/img/favicon.ico">
<script src="https://kit.fontawesome.com/cda43cd265.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css">
</head>
<body class="bg-light">

	<!-- NAVIGATIONAL BAR -->
	<nav class="navbar navbar-expand-lg fixed-top px-5">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">
				<img src="/img/agileninja-logo-2.png" alt="Agile Ninja Logo" class="navbar-img pe-2">
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
				<div class="navbar-nav">
					<button type="button" class="new-proj-btn btn btn-info me-2" data-bs-toggle="modal" data-bs-target="#staticBackdropNewProj"><i class="fa-solid fa-diagram-project me-2"></i>New Project</button>
					<button type="button" class="new-proj-btn btn btn-secondary me-3" data-bs-toggle="modal" data-bs-target="#staticBackdropNewTick"><i class="fa-solid fa-ticket me-2"></i>New Ticket</button>
					<a class="nav-link" href="/dashboard">Dashboard</a>
					<a class="nav-link" href="#">Profile</a>
					
				</div>
			</div>

			
			<div class="me-5">
				<a href="#" class="header-current-user-wholename"><i class="fa-solid fa-user-ninja me-2"></i> ${currentUser.getFullName()}</a>
			</div>
			<form id="logoutForm" method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<button class="btn rounded-1 btn-outline-danger" type="submit"><i class="fa-solid fa-arrow-right-from-bracket me-1"></i></button>
			</form>
		</div>
	  </nav>
	
	
	<!-- MAIN CONTENT -->
	<main class="main-content px-5 mx-5  mb-5">
			
			<h2 class="mb-3"><i class="fa-solid fa-magnifying-glass me-3"></i>Search for issues</h2>
				
			
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
					
								<!-- PROJECT SELECT DROPDOWN FIELD -->
								<div class="input-group mb-3">
									<form:label class="input-group-text" path="project">Project</form:label>
									<form:select path="project" class="form-select"  required="true">
										<form:option value="" label="-- Please Select a Project --" selected="true" disabled="true" />
										<c:forEach var="aProject" items="${existingProjects}">
											<form:option value="${aProject.getId()}"><c:out value="${aProject.getProjectName()} (${aProject.getProjectKey()})" /></form:option>
										</c:forEach>
									</form:select>
								</div>

								<!-- TITLE TEXT FIELD -->
								<div class="input-group mb-3">
									<form:label class="input-group-text" path="ticketName">Title</form:label>
									<form:input class="form-control" path="ticketName" type="text" required="true"/>
								</div>

								<!-- ASSIGNEE SELECT DROPDOWN FIELD -->
								<div class="input-group mb-3">
									<form:label class="input-group-text" path="assignee">Assignee</form:label>
									<form:select class="form-select" path="assignee" required="true">
										<c:forEach var="user" items="${allUsers}">
											<form:option value="${user.getId()}"><c:out value="${user.firstName} ${user.lastName} (${user.getUsername()})"/></form:option>
										</c:forEach>
									</form:select>
								</div>

								<!-- SEVERITY SELECT DROPDOWN FIELD -->
								<div class="input-group mb-3">
									<form:label class="input-group-text" path="ticketSeverity">Severity</form:label>
									
									<form:select class="form-select" path="ticketSeverity">
										<form:options items="${severities}" itemValue="id" itemLabel="issueSeverity"/>
									</form:select>

									<!-- <i class="fa-sharp fa-solid fa-circle-info ms-2 my-auto tooltip-lc">
										<span class="tooltiptext-lc p-2 px-4">Some Text Here</span>
									</i> -->
								</div>

								<!-- PRIORITY SELECT DROPDOWN FIELD -->
								<div class="input-group mb-3">
									<form:label class="input-group-text" path="ticketPriority">Priority</form:label>
									<form:select class="form-select" path="ticketPriority">
										<form:options items="${priorities}" itemValue="id" itemLabel="issuePriority"/>
									</form:select>

									<!-- <i class="fa-sharp fa-solid fa-circle-info ms-2 my-auto tooltip-lc"></i> -->
								</div>

								<!-- TYPE SELECT DROPDOWN FIELD -->
								<div class="input-group mb-3">
									<form:label class="input-group-text" path="ticketType">Type</form:label>
									<form:select class="form-select" path="ticketType">
										<form:options items="${types}" itemValue="id" itemLabel="issueType"/>
									</form:select>

									<!-- <i class="fa-sharp fa-solid fa-circle-info ms-2 my-auto tooltip-lc"></i> -->
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
							
							<p class="dash-filter-text fw-bold fs-4 me-4">Filter:</p>

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
									<span class="me-2">Type</span>
									<span class="badge text-bg-dark filter-count-type">${filterTypeSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="type" items="${types}">
											<div class="form-check">
												<input class="form-check-input-type" type="checkbox" value="${type.getIssueType()}" id="ty${type.getId()}">
												<label class="form-check-label-type ms-2" for="ty${type.getId()}">
													${type.getIconAndTypeName()}
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
							</div>

							<!-- 3. ISSUE STATUS FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span class="me-2">Status</span>
									<span class="badge text-bg-dark filter-count-stat">${filterStatSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="status" items="${statuses}">
											<div class="form-check">
												<input class="form-check-input-status" type="checkbox" value="${status.getIssueStatus()}" id="st${status.getId()}">
												<label class="form-check-label-status ms-2" for="st${status.getId()}">
													${status.getIconAndStatusName()}
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
							</div>

							<!-- 4. ISSUE PRIORITY FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span class="me-2">Priority</span>
									<span class="badge text-bg-dark filter-count-prio">${filterPrioSize}</span>
								</button>
								<ul class="dropdown-menu">
									<li>
										<c:forEach var="priority" items="${priorities}">
											<div class="form-check">
												<input class="form-check-input-priority" type="checkbox" value="${priority.getIssuePriority()}" id="pr${priority.getId()}">
												<label class="form-check-label-priority ms-2" for="pr${priority.getId()}">
													${priority.getIconAndPriorityName()}
												</label>
											</div>
										</c:forEach>
									</li>
								</ul>
							</div>

							<!-- 5. ISSUE SEVERITY FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span class="me-2">Severity</span>
									<span class="badge text-bg-dark filter-count-sev">${filterSevSize}</span>
								</button>
								<ul class="dropdown-menu">
									<c:forEach var="severity" items="${severities}">
										<li>
											<div class="form-check">
												<input class="form-check-input-severity" type="checkbox" value="${severity.getIssueSeverity()}" id="sv${severity.getId()}">
												<label class="form-check-label-severity ms-2" for="sv${severity.getId()}">
													${severity.getIconAndSeverityName()}
												</label>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>

							<!-- 6. ISSUE ASSIGNEE FILTER -->
							<div class="input-group mb-3 me-2">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
									<span class="me-2">Assignee</span>
									<span class="badge text-bg-dark filter-count-ass">${filterAssSize}</span>
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
							<button class="btn btn-success btn-sm" id="btn-submit-filter"><i class="fa-solid fa-filter me-2"></i>Apply</button>
							<!-- <button class="btn btn-outline-secondary btn-sm" id="btn-clear-filter">Clear Filter</button> -->
						</div>
					</div>
					
				
			</div>

			<!-- ISSUE TABLE -->
			<div>
				<table class="table table-hover" id="main-tab-lc">
					<thead>
						<tr class="table-secondary">
							<th scope="col">Key
								<c:if test="${orderBy==null || !orderBy.equals('ticketKey')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-key"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketKey') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-key"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketKey') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-key"></i>
								</c:if>
							</th>
							<th scope="col">Type 
								<c:if test="${orderBy==null || !orderBy.equals('ticketType')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-type"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketType') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-type"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketType') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-type"></i>
								</c:if>
							</th>
							<th scope="col">Issue Name
								<c:if test="${orderBy==null || !orderBy.equals('ticketName')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-name"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketName') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-name"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketName') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-name"></i>
								</c:if>
							</th>
							<th scope="col">Status 
								<c:if test="${orderBy==null || !orderBy.equals('ticketStatus')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-status"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketStatus') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-status"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketStatus') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-status"></i>
								</c:if>
							</th>
							<th scope="col">Priority 
								<c:if test="${orderBy==null || !orderBy.equals('ticketPriority')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-priority"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketPriority') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-priority"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketPriority') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-priority"></i>
								</c:if>
							</th>
							<th scope="col">Severity 
								<c:if test="${orderBy==null || !orderBy.equals('ticketSeverity')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-severity"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketSeverity') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-severity"></i>
								</c:if>
								<c:if test="${orderBy.equals('ticketSeverity') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-severity"></i>
								</c:if>
							</th>
							<th scope="col">Modified 
								<c:if test="${orderBy==null || !orderBy.equals('updatedAt')}">
									<i class="fa-solid fa-sort ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-modified"></i>
								</c:if>
								<c:if test="${orderBy.equals('updatedAt') && orderIn.equals('ASC')}">
									<i class="fa-solid fa-sort-down ms-2 btn-lc-sorter btn-lc-sorter-to-desc" id="sort-modified"></i>
								</c:if>
								<c:if test="${orderBy.equals('updatedAt') && orderIn.equals('DESC')}">
									<i class="fa-solid fa-sort-up ms-2 btn-lc-sorter btn-lc-sorter-to-asc" id="sort-modified"></i>
								</c:if>


							</th>
							<th scope="col">Assigned to 
								<!-- <i class="fa-solid fa-sort-down ms-2 btn-lc-sorter" id="sort-assignee"></i> -->
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ticket" items="${ticketsByProject}">
						<tr>
							<td>${ticket.getTicketKey()}</td>
							<td>${ticket.getTicketType().getIconAndTypeName()}</td>
							<td><a target="_blank" href="/ticket/${ticket.getTicketKey()}">${ticket.getTicketName()}</a></td>
							<td>${ticket.getTicketStatus().getIconAndStatusName()}</td>
							<td>${ticket.getTicketPriority().getIconAndPriorityName()}</td>
							<td>${ticket.getTicketSeverity().getIconAndSeverityName()}</td>
							<c:if test="${ticket.getUpdatedAt()!=null}">
								<td>${ticket.getUpdatedAtFormattedDateOnly()}</td>
							</c:if>
							<c:if test="${ticket.getUpdatedAt()==null}">
								<td>${ticket.getCreatedAtFormattedDateOnly()}</td>
							</c:if>
							<td><i class="fa-solid fa-user-ninja me-2"></i>${ticket.getAssignee().getFirstName()} ${ticket.getAssignee().getLastName()}</td>
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <script src="/js/app.js"></script>
</body>
</html>