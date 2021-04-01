<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container-fluid">
		<div class="row mt-5">
		<div class="col-md-4 offset-md-4">
			<div class="card">
				
				<%@include file="components/message.jsp" %>
				
				
				<div class="card-body px-5">
					<div class="container text-center">
						<img src="img/registration.png" style="max-width: 100px;" class="img-fluid">
						<h3 class="text-center">Sign up here!!</h3>
					</div>
					
					<form action="RegisterServlet" method="post">
						<div class="form-group">
							<label for="name">User Name</label> <input
								type="text" class="form-control" id="name" name="user_name"
								aria-describedby="emailHelp" placeholder="Enter here">
						</div>
						<div class="form-group">
							<label for="email">User Email</label> <input
								type="email" class="form-control" id="email" name="user_email"
								aria-describedby="emailHelp" placeholder="Enter here">
						</div>
						<div class="form-group">
							<label for="password">User Password</label> <input
								type="password" class="form-control" id="password" name="user_password"
								aria-describedby="emailHelp" placeholder="Enter here">
						</div>
						<div class="form-group">
							<label for="phone">User Phone</label> <input
								type="number" class="form-control" id="phone" name="user_phone"
								aria-describedby="emailHelp" placeholder="Enter here">
						</div>
						<div class="form-group">
							<label for="name">User Address</label>
							 <textarea name="user_address" class="form-control" placeholder="Enter your address" style="height: 100px;"></textarea>
						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-outline-success">Register</button>
							<button type="reset" class="btn btn-outline-warning">Reset</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>

</body>
</html>