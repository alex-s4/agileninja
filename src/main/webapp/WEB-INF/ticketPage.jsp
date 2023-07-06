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
        <form:form id="issuePropForm" method="POST" action="/ticket/${theTicket.getId()}/edit" modelAttribute="theTicket">
            

            <h1>${theTicket.getTicketKey()}: <form:input class="issuePropInputText input-txtfield" path="ticketName" value="${theTicket.getTicketName()}"/></h1>
            <h3>Description</h3>
            <form:textarea class="issuePropInputText form-control form-control-lc" path="ticketDescription" cols="75" />
            
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


 




  <!-- JS FILE -->
  <!-- NOTE: INSERT THE JQUERY SCRIPT FIRST BEFORE THE LOCAL JS FILE -->
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
  <script src="/js/app.js"></script>
    
  </body>
</html>