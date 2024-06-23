package cn.techtutorial.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.ProductDao;
import cn.techtutorial.model.Product;

@WebServlet("/filter-products")

public class FilterProductsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
	    if (category != null && !category.isEmpty()) {
	        try (Connection con = DbCon.getConnection()) {
	            ProductDao productDao = new ProductDao(con);
	            List<Product> filteredProducts = productDao.getProductsByCategory(category);
	            
	            // Set the attribute and forward the request to product-list.jsp
	            request.setAttribute("products", filteredProducts);
	            request.getRequestDispatcher("UpdatedList.jsp").forward(request, response);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            // Handle database error
	            response.getWriter().println("An error occurred while fetching products.");
	        }
	    } else {
	        // Handle case where category is null or empty
	        response.getWriter().println("Please select a category.");
	    }
	}
}