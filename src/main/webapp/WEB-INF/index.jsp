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
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<h1>Hi ${currentUser.getFirstName()}</h1>
	<!-- <form id="new-proj-btn" method="GET" action="/project/new">
        <input type="submit" value="New Project" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"/>
    </form> -->

    <button class="new-proj-btn" onclick="openFormNewProj()">New Project</button>
    <button class="new-proj-btn" onclick="openFormNewTkt()">New Ticket</button>

	
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Logout!" />
    </form>

    <!-- NEW PROJECT FORM -->
    <div id="new-proj-form">
        <h1>Create new Project</h1>
		
		<form:form id="projectCreation" method="POST" action="/project/new" modelAttribute="newProject">
		 
		    <p><form:errors path="project.*"/></p>

			<p>
	            <form:label path="projectName">Project Name *</form:label>
	            <form:input path="projectName" type="text"/>
	        </p>
	        <p>
	            <form:label path="projectKey">Project Key *</form:label>
	            <form:input path="projectKey" type="text"/>
            </p>
	        
            <p>* - Required</p>
	        
             <input for="projectCreation" type="submit" value="Create"/><a href="#" onclick="closeFormNewProj()">cancel</a>

	    </form:form>
    </div>

    <!-- NEW TICKET FORM -->
    <div id="new-tkt-form">
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
	            <form:label path="reporter">Reporter</form:label>
	            <form:input path="reporter" type="text" readonly="true" value="${currentUser.getUsername()}"/>
	        </p>
            <p>
	            <form:label path="assignee">Assignee</form:label>
	            <form:select path="assignee">
                    <form:options items="${allUsers}" itemValue="id" itemLabel="username"/>
                </form:select>
	        </p>
	        <p>
	            <form:label path="ticketStatus">Status</form:label>
	            <form:select path="ticketStatus">
                    <form:options items="${statuses}" itemValue="id" itemLabel="issueStatus"/>
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
	        
             <input for="projectCreation" type="submit" value="Create"/><a href="#" onclick="closeFormNewTkt()">cancel</a>

	    </form:form>
    </div>



    <script src="/js/app.js"></script>
</body>
</html>