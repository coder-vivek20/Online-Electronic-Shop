<%@page import="cn.techtutorial.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="cn.techtutorial.servlet.*"%>
<%@page import="cn.techtutorial.dao.*"%>
<%@page import="cn.techtutorial.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
    ProductDao pd = new ProductDao(DbCon.getConnection());
    String category = request.getParameter("category");
    List<Product> products = pd.getProductsByCategory(category);

%>

<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <%@include file="includes/head.jsp"%>
    <style>
        /* Add your custom styles here */
        .product {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
        }

        .product img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <%@include file="includes/navbar.jsp"%>
    <div class="container">
        <div class="card-header my-3">Filtered Products</div>
        
<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="categoryDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Select Category
    </button>
    <div class="dropdown-menu" aria-labelledby="categoryDropdown">
        <%
            ProductDao productDao = new ProductDao(DbCon.getConnection());
            List<String> categories = productDao.getAllCategories();
            for (String cat : categories) {
        %>
            <a class="dropdown-item" href="filter-products?category=<%= cat %>"><%= cat %></a>
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
						<h6 class="price">Price: $<%= p.getPrice() %></h6>
						<h6 class="category">Category: <%=p.getCategory() %></h6>
						<div class="mt-3 d-flex justify-content-between">
						<a href="add-to-cart?id=<%=p.getId() %>" class="btn btn-dark">Add to Cart</a>
<a
								class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>						</div>
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
