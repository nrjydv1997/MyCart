<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	User user = (User) session.getAttribute("current-user");

	if (user == null) {
		session.setAttribute("message", "You are not logged in !! Login first..");
		response.sendRedirect("login.jsp");
		return;
	} else {
		if (user.getUserType().equals("normal")) {
			session.setAttribute("message", "You are not admin ! You can't access this page..");
			response.sendRedirect("login.jsp");
			return;
		}
	}
%>

<%
	CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
	List<Category> list = catDao.getCategories();
	
	//getting count
	
	Map<String, Long> map =  Helper.getCounts(FactoryProvider.getFactory());
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>

<%@include file="components/common_css_js.jsp" %>

<style>
	body{
		background: #e2e2e2;
	}
</style>

</head>
<body>
	
	<%@include file="components/navbar.jsp" %>
	
	<div class="container admin">
		
			<div class="container-fluid">
				<%@include file="components/message.jsp" %>
			</div>
<!-- first row -->
		<div class="row mt-3">
			
			<!-- first column -->
			<div class="col-md-4">
				<div class="card" data-toggle="tooltip" data-placement="left" title="Number of users in this website">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle" alt="user pic" src="img/users.png">
						</div>
						<h1><%=map.get("userCount") %></h1>
						<h1 style="font-size: 30px;" class="text-uppercase text-muted">Users</h1>
					</div>
				</div>
			</div>
			
			<!-- second column -->
			<div class="col-md-4">
				<div class="card" data-toggle="tooltip" data-placement="bottom" title="Total categories">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle" alt="user pic" src="img/list.png">
						</div>
						<h1><%=list.size() %></h1>
						<h1 style="font-size: 30px;" class="text-uppercase text-muted">Categories</h1>
					</div>
				</div>
			</div>
			
			<!-- third column -->
			<div class="col-md-4">
				<div class="card" data-toggle="tooltip" data-placement="right" title="Total number of products">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle" alt="user pic" src="img/product.png">
						</div>
						<h1><%=map.get("productCount") %></h1>
						<h1  style="font-size: 30px;" class="text-uppercase text-muted">Products</h1>
					</div>
				</div>
			</div>
		</div>
<!-- End first row -->
	
<!--Start second row -->
		<div class="row mt-3">
				<!-- first column -->
				<div class="col-md-6">
					<div class="card" data-toggle="modal" data-target="#add-category-modal">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width: 125px"  class="img-fluid rounded-circle" alt="Add product" src="img/add_category.png">
							</div>
							<p class="mt-2">click here to add new category</p>
							<h1 style="font-size: 30px;" class="text-uppercase text-muted">Add category</h1>
						</div>
					</div>
				</div>
				
				<!-- second column -->
				<div class="col-md-6">
					<div class="card" data-toggle="modal" data-target="#add-product-modal">
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width: 125px"  class="img-fluid rounded-circle" alt="Add product" src="img/plus.png">
							</div>
							<p class="mt-2">click here to add new product</p>
							<h1 style="font-size: 30px;" class="text-uppercase text-muted">Add product</h1>
						</div>
					</div>
				</div>
		</div>
<!--End second row -->

<!--Start third row -->

		<div class="row mt-3">
				<!-- first column -->

				<div onclick="window.location='view_products.jsp'" class="col-md-12">
					<div class="card" data-toggle="tooltip" data-placement="top" title="Click here to view all products" >
						<div class="card-body text-center">
							<div class="container">
								<img style="max-width: 125px"  class="img-fluid rounded-circle" alt="Add product" src="img/magnifying-glass.png">
							</div>
							<p class="mt-2">click here to view all products</p>
							<h1 style="font-size: 30px;" class="text-uppercase text-muted">View Product</h1>
						</div>
					</div>
				</div>
		</div>


<!--End third row -->

	</div>
	
<!-- Start Category Modal -->
	

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationServlet" method="post">
					
						<input type="hidden" name="operation" value="addcategory">
						<div class="form-group">
							<input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required/>
						</div>
						
						<div class="form-group">
							<textarea style="height: 200px;" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
						</div>
						
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
							<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	<!-- End Category Modal -->
	<!-- ------------------------------------------------------------------------------ -->
	<!-- Start Product Modal -->
	
	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- Start form -->
						<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
						
							<input type="hidden" name="operation" value="addproduct">
							
							<!-- product title -->
							<div class="form-group">
								<input class="form-control" type="text " placeholder="Enter title of product" name="pName" required/>
							</div>
							
							<!-- product description -->
							<div class="form-group">
								<textarea style="height: 150px;" class="form-control" placeholder="Enter product description" name="pDesc" required ></textarea>
							</div>
							
							<!-- product price -->
							<div class="form-group">
								<input class="form-control" type="number" placeholder="Enter price of product" name="pPrice" required/>
							</div>
							
							<!-- product discount -->
							<div class="form-group">
								<input class="form-control" type="number" placeholder="Enter discount on product" name="pDiscount" required/>
							</div>
							
							<!-- product quantity -->
							<div class="form-group">
								<input class="form-control" type="number" placeholder="Enter quantity of product" name="pQuantity" required/>
							</div>
							
							<!-- product category -->
							
							
							
							<div class="form-group">
								<select class="form-control" name="catId">
									<%
										for(Category c: list){
											%>
											
												<option class="form-control" value="<%=c.getCategoryId() %>"><%=c.getCategoryTitle() %></option>
												
											<% 
										}
									%>
								
								</select>
							</div>
							
							<!-- product profile -->
							<div class="form-group">
								<label for="pPic">Select picture of product</label><br>
								<input type="file" name="pPic" required />
							</div>
							
							<!-- submit button -->
							<div class="container text-center">
								<button class="btn btn-outline-success">Add product</button>
								<button type="button" class="btn btn-secondary"	data-dismiss="modal">Close</button>
							</div>
	
						</form>
					
					<!-- End form -->
				
				</div>
				
			</div>
		</div>
	</div>
	<!-- End Product Modal -->
	<!-- start modal -->
	<%@include file="components/common_modals.jsp" %>
	<!-- end modal -->
	
	<script>
	$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		})
	</script>
</body>
</html>