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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<h1>Hi ${currentUser.getFirstName()}</h1>
	<!-- <form id="new-proj-btn" method="GET" action="/project/new">
        <input type="submit" value="New Project" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"/>
    </form> -->

    <button class="new-proj-btn btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" onclick="openFormNewProj()">New Project</button>
    <button class="new-proj-btn btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" onclick="openFormNewTkt()">New Ticket</button>

	
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Logout!" />
    </form>

	<div class="popup-modal-lc">
		<p>${newProjSuccess}</p>
	</div>

    <!-- NEW PROJECT FORM -->
	<div id="new-proj-form" class="modal-lc">
		<div id="modal-newproj-lc" class="modal-content-lc">
			<span class="close-lc" onclick="closeFormNewProj()">&times;</span>
			<h1>Create new Project</h1>
			
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

					<input for="projectCreation" type="submit" value="Create"/><a href="#" onclick="closeFormNewProj()">cancel</a>

			</form:form>
		</div>
	</div>
	

    <!-- NEW TICKET FORM -->
	<div id="new-tkt-form" class="modal-lc">
		<div id="modal-newproj-lc" class="modal-content-lc">
			<span class="close-lc" onclick="closeFormNewTkt()">&times;</span>
			<h1>Create new Ticket</h1>
			
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


				<input for="projectCreation" type="submit" value="Create"/><a href="#" onclick="closeFormNewTkt()">cancel</a>
				
			</form:form>
		</div>
	</div>
    
	<!-- FILTER SECTION -->
	<div>
			
			<div class="d-flex flex-row">

				<!-- 1. PROJECT FILTER -->
				<div>
					<h3>Project</h3>
					<c:forEach var="project" items="${existingProjects}">
						<div class="form-check">
							<input class="form-check-input-proj" type="checkbox" value="${project.getProjectKey()}" id="proj${project.getId()}">
							<label class="form-check-label-proj" for="proj${project.getId()}">
								${project.getProjectName()} (${project.getProjectKey()})
							</label>
						</div>
					</c:forEach>

				</div>

				<!-- 2. ISSUE TYPE FILTER -->
				<div>
					<h3>Type</h3>
					<c:forEach var="type" items="${types}">
						<div class="form-check">
							<input class="form-check-input-type" type="checkbox" value="${type.getIssueType()}" id="ty${type.getId()}">
							<label class="form-check-label-type" for="ty${type.getId()}">
								${type.getIssueType()}
							</label>
						</div>
					</c:forEach>
				</div>

				<!-- 3. ISSUE STATUS FILTER -->
				<div>
					<h3>Status</h3>
					<c:forEach var="status" items="${statuses}">
						<div class="form-check">
							<input class="form-check-input-status" type="checkbox" value="${status.getIssueStatus()}" id="st${status.getId()}">
							<label class="form-check-label-status" for="st${status.getId()}">
								${status.getIssueStatus()}
							</label>
						</div>
					</c:forEach>
				</div>

				<!-- 4. ISSUE PRIORITY FILTER -->
				<div>
					<h3>Priority</h3>
					<c:forEach var="priority" items="${priorities}">
						<div class="form-check">
							<input class="form-check-input-priority" type="checkbox" value="${priority.getIssuePriority()}" id="pr${priority.getId()}">
							<label class="form-check-label-priority" for="pr${priority.getId()}">
								${priority.getIssuePriority()}
							</label>
						</div>
					</c:forEach>
				</div>

				<!-- 5. ISSUE SEVERITY FILTER -->
				<div>
					<h3>Severity</h3>
					<c:forEach var="severity" items="${severities}">
						<div class="form-check">
							<input class="form-check-input-severity" type="checkbox" value="${severity.getIssueSeverity()}" id="sv${severity.getId()}">
							<label class="form-check-label-severity" for="sv${severity.getId()}">
								${severity.getIssueSeverity()}
							</label>
						</div>
					</c:forEach>
				</div>


			</div>
			<button class="submit" id="btn-submit-filter">find</button>
	</div>

	<!-- ISSUE TABLE -->
	<div>
		<table class="table table-hover">
			<thead>
				<tr>
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
					<td><a href="/ticket/${ticket.getTicketKey()}">${ticket.getTicketName()}</a></td>
					<td>${ticket.getTicketStatus().getIssueStatus()}</td>
					<td>${ticket.getTicketPriority().getIssuePriority()}</td>
					<td>${ticket.getTicketSeverity().getIssueSeverity()}</td>
					<td>${ticket.getUpdatedAt()}</td>
					<td>${ticket.getAssignee().getUsername()}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>



	
	<!-- JS SCRIPT -->
	<!-- NOTE: INSERT THE JQUERY SCRIPT FIRST BEFORE THE LOCAL JS FILE -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="/js/app.js"></script>
</body>
</html>