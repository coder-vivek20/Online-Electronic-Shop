<%@page import="cn.techtutorial.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.connection.DbCon"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <%@include file="includes/head.jsp"%>
    <style>
        .card {
            border: 1px solid #dedede; /* Adds a light grey border */
            border-radius: 8px; /* Rounded corners for the card */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for hover effects */
            overflow: hidden; /* Ensures the image doesn't break the rounded border */
            margin: 10px;
            width: 300px;
            display: inline-block;
        }

        .card:hover {
            transform: translateY(-5px); /* Slight lift effect on hover */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Increased shadow on hover for emphasis */
        }

        .card-img-top {
            border-top-left-radius: 8px; /* Rounded top-left corner of the image */
            border-top-right-radius: 8px; /* Rounded top-right corner of the image */
            max-width: 100%;
            height: auto;
        }

        .card-title, .price, .category {
            color: #333333; /* Dark grey color for text for better contrast */
            margin: 10px;
        }

        .btn-dark, .btn-primary {
            border-radius: 4px; /* Rounded corners for buttons */
            margin: 10px;
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
</head>
<body>



    <div id="product-list">
        <c:forEach var="product" items="${products}">
            <div class="card">
                <img class="card-img-top" src="product-images/${product.image}" alt="${product.name}">
                <div class="card-body">
                    <h5 class="card-title">${product.name}</h5>
                    <h6 class="price">Price: $${product.price}</h6>
                    <h6 class="category">Category: ${product.category}</h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <a href="add-to-cart?id=${product.id}" class="btn btn-dark">Add to Cart</a>
                        <a class="btn btn-primary" href="order-now?quantity=1&id=${product.id}">Buy Now</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
