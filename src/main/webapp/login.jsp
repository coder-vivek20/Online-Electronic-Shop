
<%@page import="java.util.*"%>
<%@page import="cn.techtutorial.model.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

	pageEncoding="ISO-8859-1"%>
	<%
    User auth= (User) request.getSession().getAttribute("auth");
    if(auth!=null){
    	request.getSession().setAttribute("auth", auth);
    	response.sendRedirect("index.jsp");
    }
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
    	request.setAttribute("cart_list", cart_list);
    }
    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f7f7f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-container {
            min-height: 80vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-card {
        background: linear-gradient(to right, #ff758c 0%, #ff7eb3 50%, #be77ff 100%);
            width: 100%;
            max-width: 600px;
            min-height: 400px;
            padding: 45px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
           
            color: #fff;
        }
        .login-card .form-control {
         padding: 15px 10px;
            background-color: transparent;
            border: none;
            border-bottom: 2px solid #fff;
            border-radius: 0;
            box-shadow: none;
            color: #fff;
        }
        .login-card .form-control::placeholder {
            color: #ddd;
        }
        .login-card .form-control:focus {
            background-color: transparent;
            color: #fff;
        }
        .login-card .btn-primary {
         padding: .325rem .55rem; 
    font-size: .875rem; 
    line-height: 1.5;
    border-radius: .2rem;
            background-color: #fff;
            border: none;
            color: #6a11cb;
            font-weight: bold;
            transition: all 0.3s;
            width: 150px;
        }
        .login-card .btn-primary:hover {
            background-color: #ddd;
            color: #6a11cb;
        }
        
    </style>
</head>
<%@include file="includes/head.jsp"%>

<body>
<%@include file="includes/navbar.jsp"%>

    <div class="login-container">
        <div class="card login-card">
            <div class="card-body">
            
            <% String loginError = (String) request.getAttribute("loginError"); %>
<% if (loginError != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= loginError %>
    </div>
<% } %>
            
            
                <h3 class="text-center mb-4">User Login</h3>
                <form action="LoginServlet" method="post">
                    <div class="form-group mb-3">
                        <input type="email" class="form-control" name="Login-email" placeholder="Enter Your Email" required>
                    </div>
                    <div class="form-group mb-3">
                        <input type="password" class="form-control" name="Login-password" placeholder="Password" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block mb-4">Login</button>
                    <div class="text-center">
                    <a href="Registration.jsp" style="color:black">Don't have an account? Register</a>
                    </div>
                </form>
                
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <%@include file="includes/footer.jsp"%>
    
</body>
</html>
