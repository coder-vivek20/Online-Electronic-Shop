<%@page import="java.util.*"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="cn.techtutorial.servlet.*"%>
<%@page import="cn.techtutorial.dao.*"%>

<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>welcome to shopping cart!</title>
<%@include file="includes/head.jsp"%>
<style> 
.card {
    border: 1px solid #dedede; /* Adds a light grey border */
    border-radius: 8px; /* Rounded corners for the card */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
    transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for hover effects */
    overflow: hidden; /* Ensures the image doesn't break the rounded border */
}

.card:hover {
    transform: translateY(-5px); /* Slight lift effect on hover */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Increased shadow on hover for emphasis */
}

.card-img-top {
    border-top-left-radius: 8px; /* Rounded top-left corner of the image */
    border-top-right-radius: 8px; /* Rounded top-right corner of the image */
}

.card-title, .price, .category {
    color: #333333; /* Dark grey color for text for better contrast */
}

.btn-dark, .btn-primary {
    border-radius: 4px; /* Rounded corners for buttons */
}

.btn-dark:hover, .btn-primary:hover {
    opacity: 0.9; /* Slight transparency effect on hover for buttons */
}

.price {
    color: #e63946; /* A vibrant red color for the price to make it stand out */
}

.category {
    font-style: italic; /* Italicize the category for a touch of style */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">All Products</div>
		 
		<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="categoryDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Select Category
    </button>
    <div class="dropdown-menu" aria-labelledby="categoryDropdown">
        <%
            ProductDao productDao = new ProductDao(DbCon.getConnection());
            List<String> categories = productDao.getAllCategories();
            for (String category : categories) {
        %>
            <a class="dropdown-item" href="filter-products?category=<%= category %>"><%= category %></a>
        <%
            }
        %>
    </div>
</div>

		 
		 
		 
		 <div class="row">
		<% 
                if(!products.isEmpty()){
                	for(Product p:products){
                	%>
                	<div class="col-md-3 my-3">
				<div class="card w-100" style="width: 18rem;">
					<img class="card-img-top" src="product-images/<%=p.getImage() %>"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%= p.getName() %></h5>
						<h6 class="price">Price: Rs. <%= p.getPrice() %></h6>
						<h6 class="category">Category: <%=p.getCategory() %></h6>
						<div class="mt-3 d-flex justify-content-between">
						<a href="add-to-cart?id=<%=p.getId() %>" class="btn btn-dark">Add to Cart</a>
<a
								class="btn btn-primary" onclick="buyNowConfirmation(<%=p.getId()%>)" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>						</div>
						</div>
				</div>
			</div>
			<%
                	}
                } else{
                	out.println("there is no products");
                }
		%>
			
		</div>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>