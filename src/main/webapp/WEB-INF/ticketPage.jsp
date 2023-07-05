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
        <form:form method="POST" action="/ticket/${theTicket.getId()}/edit" modelAttribute="theTicket">
            

            <h1>${theTicket.getTicketKey()}: <form:input class="input-txtfield" path="ticketName" value="${theTicket.getTicketName()}"/></h1>
            <h3>Description</h3>
            <form:textarea class="form-control form-control-lc" path="ticketDescription" cols="75" />
            
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
            <form:input path="reporter" value="${currentUser.getId()}" hidden="true"></form:input>
            <form:input path="ticketKey" value="${theTicket.getTicketKey()}" hidden="true"></form:input>
            <form:input path="project" value="${theTicket.getProject()}" hidden="true"></form:input>
            <input type="hidden" name="_method" value="put">

            <input type="submit" value="Update">
        </form:form>
        <!-- END OF FORM TAG -->
      
  </div>

  <!-- COMMENT SECTION -->
  <div class="comment-section-lc">

        <h3>Comments: (${allComments.size()})</h3>
        <!-- COMMENT LIST -->
        <c:forEach var="theComment" items="${allComments}">

              <div>
                <h5>${theComment.getUser().getUsername()}&nbsp;<span>${theComment.getCreatedAt()}</span></h5>
                <p>${theComment.getText()}</p>
              </div>
          
          
        </c:forEach>

        <!-- NEW COMMENT FORM -->
        <form:form method="POST" action="/ticket/${theTicket.getId()}/comment/new" modelAttribute="newComment"> 

        
              <form:label path="text">Add Comment:</form:label>
              <form:textarea path="text" cols="60" />

              <!-- FIXED FIELDS TO HIDE -->
              <form:input path="ticket" value="${theTicket.getId()}" hidden="true"></form:input>
              <form:input path="user" value="${currentUser.getId()}" hidden="true"></form:input>



              <input type="submit" value="Add">

        </form:form>
  
  </div>








  <!-- JS FILE -->
  <script src="/js/app.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    
  </body>
</html>