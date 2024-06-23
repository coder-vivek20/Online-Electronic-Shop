<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
    <!-- Include your CSS and JavaScript files here -->
</head>
<body>
    <h1>Payment Page</h1>
    <%-- Retrieve the payment mode and product ID from the request parameters --%>
    <% String paymentMode = request.getParameter("mode");
       String productIdString = request.getParameter("productId");
       if (paymentMode == null || productIdString == null) {
           %>
           <p>Error: Missing parameters</p>
           <%
           return;
       }
       int productId = Integer.parseInt(productIdString);
       // Perform the payment processing based on the payment mode
       if (paymentMode.equals("online")) {
           // Process online payment
           %>
           <p>Online Payment Processed Successfully for Product ID: <%= productId %></p>
           <p>Redirecting to Home Page...</p>
           <script>
               setTimeout(function() {
                   window.location.href = "index.jsp";
               }, 3000); // Redirect to home page after 3 seconds
           </script>
           <%
       } else if (paymentMode.equals("cash-on-delivery")) {
           // Process cash on delivery
           %>
           <p>Cash on Delivery Selected for Product ID: <%= productId %></p>
           <p>Please wait for confirmation...</p>
           <p>Redirecting to Home Page...</p>
           <script>
               setTimeout(function() {
                   window.location.href = "index.jsp";
               }, 3000); // Redirect to home page after 3 seconds
           </script>
           <%
       } else {
           // Invalid payment mode
           %>
           <p>Invalid Payment Mode</p>
           <p>Redirecting to Home Page...</p>
           <script>
               setTimeout(function() {
                   window.location.href = "index.jsp";
               }, 3000); // Redirect to home page after 3 seconds
           </script>
           <%
       }
    %>
</body>
</html>
