<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - Agile Ninja</title>
</head>
<body>
	<h1>Test</h1>
	<form id="new-proj-btn" method="GET" action="/project/new">
        <input type="submit" value="New Project" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"/>
    </form>

	<form id="new-ticket-btn" method="GET" action="/ticket/new">
        <input type="submit" value="New Ticket" />
    </form>

    
	
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Logout!" />
    </form>
</body>
</html>