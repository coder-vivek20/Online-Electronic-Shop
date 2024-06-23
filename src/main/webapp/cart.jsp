<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf", dcf);
    User auth= (User) request.getSession().getAttribute("auth");
    if(auth!=null){
    	request.setAttribute("auth", auth);
    	
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
    	ProductDao pDao = new ProductDao(DbCon.getConnection());
    	cartProduct = pDao.getCartProducts(cart_list);
    	double total = pDao.getTotalCartPrice(cart_list);
    	request.setAttribute("total", total);
    	request.setAttribute("cart_list", cart_list);
    }
    %>
<!DOCTYPE html>
<html>
<head>
<title>cart page</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td{
 vartical-align:middle;
}
.btn-incre, .btn-decre{
box-shodow: none;
font-size:25px;
}
/* Style the checkout button */
  .btn-checkout {
    font-size: 18px;
    padding: 5px 20px;
  }

  /* Style the table headers */
  th {
    text-align: center;
  }

  /* Add hover effect to table rows */
  tbody tr:hover {
    background-color: #f5f5f5;
  }

  /* Center the total price */
  .total-price {
    text-align: center;
    font-size: 24px;
    margin-bottom: 20px;
  }

  /* Responsive table */
  @media (max-width: 768px) {
    .table-responsive {
      overflow-x: auto;
    }
    .table th,
    .table td {
      white-space: nowrap;
    }
  }
</style>
</head>
<body>
<%@include file="includes/navbar.jsp"%>
<div class="container">
<div class="d-flex py-3"><h3>Total Price: INR.  ${(total>0)?total:0}</h3>
<a class="mx-3 btn btn-primary" href="cart-check-out">Check Out</a></div>
<table class="table table-Loght">
<thead>
<tr>
<th scope="col">Name</th>
<th scope="col">Category</th>
<th scope="col">Price</th>
<th scope="col">Buy Now</th>
<th scope="col">Cancel</th>
</tr>
</thead>
<tbody>
<%
	if (cart_list != null) {
	for (Cart c : cartProduct) {%>
		<tr>
		<td><%=c.getName() %></td>
		<td><%=c.getCategory() %></td>
		<td><%=c.getPrice() %></td>
		<td>
		<form action="order-now" method="post" class="form-inline">
		<input type="hidden" name="id" value="<%=c.getId() %>" class="form-input">
		<div class="form-group d-flex justify-content-between">
		<a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
		<input type="text" name="quantity" class="form-control w-30" value="<%= c.getQuantity() %>" readonly>

		<a class="btn btn-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a>

		</div>
		<button type="submit" class="btn btn-primary btn-sm">Buy</button>		
		</form>
		</td>
		<td><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId() %>">Remove</a></td>
		</tr>
	<%}
	}
				%>
</tbody>
</table>
</div>
<div class="container" style="margin-bottom: 380px;"></div>
<%@include file="includes/footer.jsp"%>
</body>
</html>