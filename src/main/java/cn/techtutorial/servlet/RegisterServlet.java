package cn.techtutorial.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.UserDao;
import cn.techtutorial.model.User;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String name = request.getParameter("name");
		    String email = request.getParameter("email");
		    String password = request.getParameter("password");
            String address = request.getParameter("address");
		    try {
		        UserDao userDao = new UserDao(DbCon.getConnection());
		        boolean registrationSuccess = userDao.registerUser(name, email, password, address);

		        if (registrationSuccess) {
		            response.sendRedirect("login.jsp"); // Redirect to login page after successful registration
		        } else {
		            response.sendRedirect("error.jsp"); // Redirect to error page
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		        response.sendRedirect("error.jsp"); // Redirect to error page
		    } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
    
	}


