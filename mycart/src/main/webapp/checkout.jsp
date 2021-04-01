<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
    	User user = (User) session.getAttribute("current-user");	
    	
    	if(user==null){
    		session.setAttribute("message", "You are not logged in !! Login first to access checkout page..");
    		response.sendRedirect("login.jsp");
    		return;
    	}
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout Page</title>
<%@include file="components/common_css_js.jsp" %>
</head>
<body>
	
	<%@include file="components/navbar.jsp" %>
	
	<div class="container">
		<div class="row mt-5">
			<div class="col-md-6">
				<!-- card -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-5">Your selected items</h3>
						<div class="cart-body">
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
			<!-- form details -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-5">Your details for order</h3>
						<form action="">
							<div class="form-group">
							<label for="email">User Email</label> <input value="<%=user.getUserEmail() %>"
								type="email" class="form-control" id="email" name="user_email"
								aria-describedby="emailHelp" placeholder="Enter email">
							</div>
							
							<div class="form-group">
							<label for="name">Your name</label> <input value="<%=user.getUserName() %>"
								type="text" class="form-control" id="name" name="user_name"
								aria-describedby="emailHelp" placeholder="Enter name">
							</div>
							
							<div class="form-group">
							<label for="contact">Your name</label> <input value="<%=user.getUserPhone() %>"
								type="number" class="form-control" id="contact" name="user_contact"
								aria-describedby="emailHelp" placeholder="Enter contact">
							</div>
							
							<div class="form-group">
							<label for="address">Your shipping address</label>
							 <textarea value="<%=user.getUserAddress()%>" name="user_address" class="form-control" placeholder="Enter your address" style="height: 100px;"></textarea>
							</div>
							
							<div class="container text-center">
								<button class="btn btn-outline-success">Order Now</button>
								<button class="btn btn-outline-primary">Continue Shopping</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- start modal -->
	<%@include file="components/common_modals.jsp" %>
	<!-- end modal -->
</body>
</html>