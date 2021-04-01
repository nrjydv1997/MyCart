<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<%@include file="components/common_css_js.jsp" %>

<title>Hello, world!</title>
</head>
<body>
	<%@include file="components/navbar.jsp" %>
	
	
	<div class="container-fluid">
	<div class="row mt-3 mx-2">
		
		<%
			String catId = request.getParameter("category");	
		
			ProductDao pDao =new ProductDao(FactoryProvider.getFactory());
			List<Product> pList =null;
			
			if(catId==null || catId.trim().equals("all")){
				 pList = pDao.getAllProducts();
			}else {
				int  cid = Integer.parseInt(catId.trim());
				pList = pDao.getAllProductsById(cid);
			}
			
		    
		   
		    CategoryDao catDao =new CategoryDao(FactoryProvider.getFactory());
		    List<Category> catList = catDao.getCategories();
		%>
		
		<!-- Show categories -->
		<div class="col-md-2">
			<div class="list-group mt-4">
				<a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All products </a>
			<%
				for(Category cat: catList){
					%> 
					<a href="index.jsp?category=<%=cat.getCategoryId() %>" class="list-group-item list-group-item-action"><%=cat.getCategoryTitle() %></a>
					<%
				}
			
			%>
			</div>
		</div>
		
		<!-- Show products -->
		<div class="col-md-10">
			<div class="row mt-4">
				<div class="col-md-12">
					<div class="card-columns">
						<!-- traversing products -->
						<%
							for(Product product: pList){
								%>
									<!-- product card -->
									<div class="card product-card">
										<div class="card-body">
										
											<div class="container text-center">
											<img style="max-height: 200px; max-width: 100%; width: auto;" class="card-img-top m-2" alt="product" src="img/products/<%=product.getpPhoto()%>">
										    </div>
										    
											<h5 class="card-title"><%=product.getpName() %></h5>
											<p class=""card-text> <%=Helper.get10Words(product.getpDesc()) %></p>
										</div>
										
										<div class="card-footer text-center">
											<button class="btn custom-bg text-white" onclick="add_to_cart(<%=product.getpId()%>,'<%=product.getpName()%>',<%=product.getPriceAfterDiscount()%>)">Add to cart</button>
											<button class="btn btn-outline-success ">&#8377;<%=product.getPriceAfterDiscount() %> /- <span class="text-secondary discount-label"><span class="orig-price">&#8377;<%=product.getpPrice()%></span> , <%=product.getpDiscount() %>% off</span></button>
										</div>
									</div>
									
								<%
							}
							
							if(pList.size()==0){
								out.println("<h3>No item in this category</h3>");
							}
						%>
					</div>
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
