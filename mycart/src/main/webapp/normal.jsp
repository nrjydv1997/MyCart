<%@page import="com.learn.mycart.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
    	User user = (User) session.getAttribute("current-user");	
    	
    	if(user==null){
    		session.setAttribute("message", "You are not logged in !! Login first..");
    		response.sendRedirect("login.jsp");
    		return;
    	}else {
    		if(user.getUserType().equals("admin")){
    			session.setAttribute("message", "You are not normal user ! You can't access this page..");
    			response.sendRedirect("login.jsp");
    			return;
    		}
    	}
    	
    
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Normal user panel</title>

<%@include file="components/common_css_js.jsp" %>

</head>
<body>
	
	<%@include file="components/navbar.jsp" %>
	
	<h1>This is normal user panel</h1>
	
	<!-- start modal -->
	<%@include file="components/common_modals.jsp" %>
	<!-- end modal -->
</body>
</html>